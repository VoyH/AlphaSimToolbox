function indir_Segmentation(InDir_T1,OutDir_Segment,Parameter)
%InDir_T1=T1ImgCoreg; Or InDir_T1=T1Img
%Parameter.AffineRegularisation='mni';  European brains (mni)
%Parameter.AffineRegularisation='eastern'; East Asian brains (eastern)
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%   151208 jiaxize, support SPM12




SubfodrList=init_InDirAndOutDir(InDir_T1,OutDir_Segment);
indir_CopyT1(InDir_T1,OutDir_Segment,SubfodrList);
SpmBatch=cell(length(SubfodrList),1);
for i=1:length(SubfodrList)
    SpmBatch{i}.jobs = init_SpmBatch('Segmentation');
    Parameter=init_SegmentationParameter(OutDir_Segment,SubfodrList{i},Parameter);
    SpmBatch{i} = output_SpmBatch4Seg(SpmBatch{i},Parameter);    
end

batch_run_spm_jobman(SubfodrList,SpmBatch);

% parfor i=1:length(SubfodrList)
%         run_SpmBatch(SpmBatch{i});    
% end    

function Parameter=init_SegmentationParameter(OutDir_Segment,SubfodrNam,Parameter)
Parameter.T1FilePath=inpath_Misc([OutDir_Segment filesep SubfodrNam],'Get1stSubImgPath');
Parameter.SPMPath=get_Parameters('SpmFunctionPath');


function SpmBatch = output_SpmBatch4Seg(SpmBatch,Parameter)

if strcmpi(spm('ver'),'SPM8')
    SpmBatch.jobs{1,1}.spatial{1,1}.preproc.opts.tpm={[Parameter.SPMPath,filesep,'tpm',filesep,'grey.nii']; ...
                                                      [Parameter.SPMPath,filesep,'tpm',filesep,'white.nii']; ...
                                                      [Parameter.SPMPath,filesep,'tpm',filesep,'csf.nii']};
elseif strcmpi(spm('ver'),'SPM12')
    SpmBatch.jobs{1,1}.spatial{1,1}.preproc.opts.tpm={[Parameter.SPMPath,filesep,'toolbox',filesep,'OldSeg',filesep,'grey.nii']; ...
                                                      [Parameter.SPMPath,filesep,'toolbox',filesep,'OldSeg',filesep,'white.nii']; ...
                                                      [Parameter.SPMPath,filesep,'toolbox',filesep,'OldSeg',filesep,'csf.nii']};                                                  
end

SpmBatch.jobs{1,1}.spatial{1,1}.preproc.data={Parameter.T1FilePath};
SpmBatch.jobs{1,1}.spatial{1,1}.preproc.opts.regtype=Parameter.AffineRegularisation;





    