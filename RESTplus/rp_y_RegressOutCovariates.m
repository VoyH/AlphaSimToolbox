function [theCovariables] = rp_y_RegressOutCovariates(DataDir,CovariablesDef,Postfix,MaskFilename, ImgCovModel,IsRemoveIntercept)
% FORMAT rp_y_RegressOutCovariates(DataDir,CovariablesDef,Postfix,MaskFilename, ImgCovModel)
% Input:
%   DataDir        - where the 3d+time dataset stay, and there should be 3d EPI functional image files. It must not contain / or \ at the end.
%   CovariablesDef - A struct which defines the coviarbles.
%                 CovariablesDef.polort    - The order of the polynomial like 3dfim+.
%                                            0: constant
%                                            1: constant + linear trend
%                                            2: constant + linear trend + quadratic trend.
%                                            3: constant + linear trend + quadratic trend + cubic trend.   ...
%                 CovariablesDef.ort_file  - The filename of the text file which contains the covaribles.
%                 CovariablesDef.CovImgDir - Directory Cell: the image directory you want to regress out 
%                 CovariablesDef.CovMat    - Covariable Matrix. Time points by Cov number matrix
%                 CovariablesDef.CovMask   - Covariable Masks. Cells of Mask file names.
%   Postfix        - Post fix of the resulting data directory. e.g. '_Covremoved'
%   MaskFilename   - The mask file for regression. Empty means perform regression on all the brain voxels.
%   ImgCovModel    - The model for the image covariates defined in CovariablesDef.CovImgDir. E.g., used for the voxel-specific 12 head motion regression model
%                     1 (default): Use the current time point. e.g., Txi, Tyi, Tzi
%                     2: Use the current time point and the previous time point. e.g., Txi, Tyi, Tzi, Txi-1, Tyi-1, Tzi-1
%                     3: Use the current time point and their squares. e.g., Txi, Tyi, Tzi, Txi^2, Tyi^2, Tzi^2
%                     4: Use the current time point, the previous time point and their squares. e.g., Txi, Tyi, Tzi, Txi-1, Tyi-1, Tzi-1 and their squares (total 12 items). Like the Friston autoregressive model (Friston, K.J., Williams, S., Howard, R., Frackowiak, R.S., Turner, R., 1996. Movement-related effects in fMRI time-series. Magn Reson Med 35, 346-355.)
%   IsRemoveIntercept - 1: remove the intercept
%                       0: not remove the intercept
% Output:
%   *.nii - data removed the effect of covariables.
%___________________________________________________________________________
% Written by YAN Chao-Gan 111209.
% Last Revised by JIA Xi-Ze, 150419. Add IsRemoveIntercept
% The Nathan Kline Institute for Psychiatric Research, 140 Old Orangeburg Road, Orangeburg, NY 10962, USA
% Child Mind Institute, 445 Park Avenue, New York, NY 10022, USA
% The Phyllis Green and Randolph Cowen Institute for Pediatric Neuroscience, New York University Child Study Center, New York, NY 10016, USA
% ycg.yan@gmail.com


if ~exist('MaskFilename','var')
    MaskFilename='';
end

if ~exist('ImgCovModel','var')
    ImgCovModel=1;
end

if ~isfield(CovariablesDef,'CovImgDir')
    CovariablesDef.CovImgDir = {};
end

if ~exist('IsRemoveIntercept','var')
    IsRemoveIntercept=1;
end

% [AllVolume,VoxelSize,theImgFileList, Header] =y_ReadAll(DataDir);
[AllVolume, VoxelSize, theImgFileList, Header, VolumnAmount]=read_To4d(DataDir);
[nDim1,nDim2,nDim3,nDim4]=size(AllVolume);


if ~isempty(CovariablesDef.CovImgDir)
    Cov5DVolume=zeros(nDim1,nDim2,nDim3,nDim4,length(CovariablesDef.CovImgDir));
    for i=1:length(CovariablesDef.CovImgDir);
        fprintf('\n\tRead the Image covariates: No. %d...\n',i);
        [CovTempVolume, VoxelSize, theImgFileList, Header, VolumnAmount]=read_To4d(CovariablesDef.CovImgDir{i});
        Cov5DVolume(:,:,:,:,i) = CovTempVolume;
    end
end
clear CovTempVolume

if ~isempty(MaskFilename)
    [MaskData,MaskVox,MaskHead]=read_To3d(MaskFilename);
else
    MaskData=ones(nDim1,nDim2,nDim3);
end


theCovariables=[];
%Add polynomial in the baseline model according to 3dfim+.pdf
if isfield(CovariablesDef,'polort')
    thePolOrt=[];
    if CovariablesDef.polort>=0,
        thePolOrt =(1:nDim4)';
        thePolOrt =repmat(thePolOrt, [1, (1+CovariablesDef.polort)]);
        for x=1:(CovariablesDef.polort+1),
            thePolOrt(:, x) =thePolOrt(:, x).^(x-1) ;
        end
    end
    theCovariables =[theCovariables,thePolOrt];
end

if isfield(CovariablesDef,'CovMat')
    theCovariables=[theCovariables,CovariablesDef.CovMat];
end

if isfield(CovariablesDef,'ort_file')
    if exist(CovariablesDef.ort_file, 'file')==2,
        theCovariablesFromFile =load(CovariablesDef.ort_file);
        theCovariables =[theCovariables,theCovariablesFromFile];
    else
        warning(sprintf('\n\nCovariables definition text file "%s" doesn''t exist, please check! This covariables will not be regressed out this time.', CovariablesDef.ort_file));
    end
end

if isfield(CovariablesDef,'CovMask')
    for iMask=1:length(CovariablesDef.CovMask)
        [iMaskData,iMaskVox,iMaskHead]=read_To3d(CovariablesDef.CovMask{iMask});
        
        TempTC=reshape(AllVolume,[],nDim4);
        TempTC = mean(TempTC(find(iMaskData),:))';

        theCovariables=[theCovariables,TempTC];
    end
end



MaskData = any(AllVolume,4) .* MaskData; % skip the voxels with all zeros

VolumeAfterRemoveCov=zeros(nDim1,nDim2,nDim3,nDim4);

fprintf('\n\tRegressing Out Covariates...\n');
for i=1:nDim1
    fprintf('.');
    for j=1:nDim2
        for k=1:nDim3
            if MaskData(i,j,k)
                DependentVariable=squeeze(AllVolume(i,j,k,:));
                if ~isempty(CovariablesDef.CovImgDir)
                    if ImgCovModel==1
                        ImgCovTemp = squeeze(Cov5DVolume(i,j,k,:,:));
                    elseif ImgCovModel==2
                        Q1 = squeeze(Cov5DVolume(i,j,k,:,:));
                        ImgCovTemp = [Q1, [zeros(1,size(Q1,2));Q1(1:end-1,:)]];
                    elseif ImgCovModel==3
                        Q1 = squeeze(Cov5DVolume(i,j,k,:,:));
                        ImgCovTemp = [Q1,  Q1.^2];
                    elseif ImgCovModel==4
                        Q1 = squeeze(Cov5DVolume(i,j,k,:,:));
                        ImgCovTemp = [Q1, [zeros(1,size(Q1,2));Q1(1:end-1,:)], Q1.^2, [zeros(1,size(Q1,2));Q1(1:end-1,:)].^2];
                    end
                    AlltheCovariables=[theCovariables,ImgCovTemp];
                else
                    AlltheCovariables=theCovariables;
                end
                
                [b,r] = old_regress_ss(DependentVariable,AlltheCovariables);
                if 1==IsRemoveIntercept
                   VolumeAfterRemoveCov(i,j,k,:)=r;
                elseif 0==IsRemoveIntercept
                   VolumeAfterRemoveCov(i,j,k,:)=r+b(1);
                else
                    error('IsRemoveIntercept is wrong');
                end
            end
        end
    end
end
VolumeAfterRemoveCov(isnan(VolumeAfterRemoveCov))=0;

if strcmp(DataDir(end),filesep)==1,
    DataDir=DataDir(1:end-1);
end

OutputDir =sprintf('%s%s',DataDir,Postfix); 
ans=rmdir(OutputDir, 's');
[theParentDir,theOutputDirName]=fileparts(OutputDir);
mkdir(theParentDir,theOutputDirName);

Header_Out = Header;
Header_Out.pinfo = [1;0;0];
Header_Out.dt    =[16,0];

% y_Write(VolumeAfterRemoveCov,Header_Out,[OutputDir,filesep,'CovRegressed_4DVolume.nii']);
write_To4dNifti(VolumeAfterRemoveCov,Header_Out,[OutputDir,filesep,'CovRegressed_4DVolume.nii'])

fprintf('\n\tRegressing Out Covariates finished.\n');

