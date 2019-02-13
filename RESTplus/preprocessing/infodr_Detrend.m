function infodr_Detrend(Infodr,Outfodr,CutNumber)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    if nargin<=2
        CutNumber=10;
    end
    
    tic;
    [AllVolume,VoxelSize,ImgFileList, Header,VolumnAmount] =read_To4d(Infodr);	
%     fprintf(['\nRemoving the linear trend: ',Infodr,'\n']);    
    AllVolume=run_Detrend(AllVolume,CutNumber);
    save_Detrend(AllVolume,VoxelSize,Header,Infodr,Outfodr);
    toc;
end


function AllVolume=run_Detrend(AllVolume,CutNumber)

   	DimX = size(AllVolume,1); 
    DimY = size(AllVolume,2); 
    DimZ = size(AllVolume,3); 
    nDimTimePoint =size(AllVolume,4);
		
    AllVolume=reshape(AllVolume,[],nDimTimePoint)';
    theMean=mean(AllVolume);
    SegmentLength = ceil(size(AllVolume,2) / CutNumber);
    fprintf('\n\t Detrend working.\tWait...');
    for iCut=1:CutNumber
        if iCut~=CutNumber
            Segment = (iCut-1)*SegmentLength+1 : iCut*SegmentLength;
        else
            Segment = (iCut-1)*SegmentLength+1 : size(AllVolume,2);
        end
    
        AllVolume(:,Segment) = detrend(AllVolume(:,Segment));
    
        fprintf('.');
    end
    
    AllVolume=AllVolume+repmat(theMean,[nDimTimePoint,1]);
    AllVolume=reshape(AllVolume',[DimX, DimY, DimZ, nDimTimePoint]);
end


function save_Detrend(AllVolume,VoxelSize,Header,Infodr,Outfodr)
    fprintf('\n\n\t Saving detrended images.\tWait...');
    inpath_Misc(Outfodr,'Path4Delete');
    imageOUT=[Outfodr filesep inpath_Misc(Infodr,'GetPathName') get_Postfix('Detrend') '.nii'];
    Header_Out = Header;
    Header_Out.pinfo = [1;0;0];
    Header_Out.dt    =[16,0];

    write_To4dNifti(AllVolume,Header_Out,imageOUT);
    fprintf('\n\t Detrend over.\n\t');
end