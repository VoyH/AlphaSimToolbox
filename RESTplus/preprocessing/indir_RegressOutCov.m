function indir_RegressOutCov(Fun_Indir,Fun_Outdir,Cov_OutDir,Parameter)
%Parameter.IsWholeBrain
%Parameter.IsCSF
%Parameter.IsWhiteMatter
%Parameter.IsHeadMotion_Rigidbody6
%Parameter.IsOtherCovariatesROI
%Parameter.IsRemoveIntercept
%Parameter.PolynomialTrend
%Parameter.InDirRealignParameter
%Parameter.OtherCovariatesROIList
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%   fixed bug line about Parameter.CovariablesTextfilepath 170201 by jiaxize

    inpath_Misc(Fun_Outdir,'MakeCurrentDir');
    inpath_Misc(Cov_OutDir,'MakeCurrentDir');

    ReslicedMaskPath=Reslice_DefaultMask(Fun_Indir,Cov_OutDir);
    CovariatesROIList=Generate_CovROIlist(Parameter,ReslicedMaskPath);
    SubfodrList=dir_NameList(Fun_Indir);

    for i=1:length(SubfodrList)
        Parameter.CovariablesTextfilepath=[Cov_OutDir filesep SubfodrList{i} filesep 'RegressOut_Covariables.txt'];
        out_CovariablesTextfilepath(Fun_Indir,Cov_OutDir,SubfodrList{i},CovariatesROIList,Parameter);
    end
    
if matlabpool('size')>0    
    parfor i=1:length(SubfodrList)
        CovariablesTextfilepath=[Cov_OutDir filesep SubfodrList{i} filesep 'RegressOut_Covariables.txt'];
        infodr_RegressOutCov([Fun_Indir filesep SubfodrList{i}],...
                              [Fun_Outdir filesep SubfodrList{i}],...
                              '',Parameter,CovariablesTextfilepath);
    end
else
    for i=1:length(SubfodrList)
        CovariablesTextfilepath=[Cov_OutDir filesep SubfodrList{i} filesep 'RegressOut_Covariables.txt'];
        infodr_RegressOutCov([Fun_Indir filesep SubfodrList{i}],...
                              [Fun_Outdir filesep SubfodrList{i}],...
                              '',Parameter,CovariablesTextfilepath);
    end    
end
    
    
    

end

function ReslicedMaskPath=Reslice_DefaultMask(Fun_Indir,Cov_OutDir)
FirstSubjectfodrPath=inpath_Misc(Fun_Indir,'Get1stSubPath');
TargetSpace=inpath_Misc(FirstSubjectfodrPath,'Get1stSubImgPath');
[Outdata,NewVoxSize,Header]=read_To3d(TargetSpace);
hld=1;
% DefaultmaskList={'BrainMask_05_91x109x91','CsfMask_07_91x109x91','WhiteMask_09_91x109x91'};
DefaultmaskList={'BrainMask_05_61x73x61','CsfMask_07_61x73x61','WhiteMask_09_61x73x61'};

MaskdirPath=get_Parameters('MaskPath');

for i=1:length(DefaultmaskList)
    reslice_Image([MaskdirPath filesep DefaultmaskList{i} '.hdr'],...
                  [Cov_OutDir filesep 'Resampled_' DefaultmaskList{i} '.nii'],...
                  NewVoxSize,hld, TargetSpace);
end

ReslicedMaskPath.BrainMask=[Cov_OutDir filesep 'Resampled_' DefaultmaskList{1} '.nii'];
ReslicedMaskPath.CsfMask=[Cov_OutDir filesep 'Resampled_' DefaultmaskList{2} '.nii'];
ReslicedMaskPath.WhiteMask=[Cov_OutDir filesep 'Resampled_' DefaultmaskList{3} '.nii'];


end

function CovROI=Generate_CovROIlist(Parameter,ReslicedMaskPath)
    CovROI=[];
    
    if isfield(Parameter,'IsWholeBrain')&&(1==Parameter.IsWholeBrain)
       CovROI=[CovROI;{ReslicedMaskPath.BrainMask}];
    end
    
    if isfield(Parameter,'IsCSF')&&(1==Parameter.IsCSF)
       CovROI=[CovROI;{ReslicedMaskPath.CsfMask}];
    end
    
    if isfield(Parameter,'IsWhiteMatter')&&(1==Parameter.IsWhiteMatter)
       CovROI=[CovROI;{ReslicedMaskPath.WhiteMask}];
    end
    
    if isfield(Parameter,'IsOtherCovariatesROI')&&(1==Parameter.IsOtherCovariatesROI)
       CovROI=[CovROI;Parameter.OtherCovariatesROIList]; 
    end

    
end

function out_CovariablesTextfilepath(Fun_Indir,Cov_OutDir,SubfodrNam,CovariatesROIList,Parameter)


        Signal_Matrix=Extract_ROISignal([Fun_Indir filesep SubfodrNam],...
                                        CovariatesROIList,...
                                        [Cov_OutDir filesep SubfodrNam filesep 'Covariates']);
                                
        if (Parameter.IsHeadMotion_Rigidbody6==1)
            Rpfile=inpath_Misc([Parameter.InDirRealignParameter filesep SubfodrNam filesep 'rp*'],...
                               'Get1SubPath_RegExp');
            RpCovariables=load(Rpfile);
        else
            RpCovariables=[];
        end
        
        
        if ~isempty(CovariatesROIList)
            CovTC=load([Cov_OutDir filesep SubfodrNam filesep 'ROISignals_Covariates.txt']);
            CovariablesMatrix=[RpCovariables,CovTC];
        else
            CovariablesMatrix=RpCovariables;
        end
        
        save(Parameter.CovariablesTextfilepath, 'CovariablesMatrix', '-ASCII', '-DOUBLE','-TABS');

end
