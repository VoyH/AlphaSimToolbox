function indir_Coregister(InDir_T1Img,InDir_RealignParameter,OutDir_T1Coregister)
%-InDir{1}=T1Img;
%-InDir{2}=RealignParameter;
%-OutDir=T1Coregister;

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

[ImgType,ImgExt]=indir_Chek(InDir_T1Img);
SubfodrList=init_InDirAndOutDir(InDir_T1Img,OutDir_T1Coregister);
indir_CopyT1(InDir_T1Img,OutDir_T1Coregister,SubfodrList);
SpmBatch=cell(length(SubfodrList),1);
for i=1:length(SubfodrList)
    SpmBatch{i}.jobs = init_SpmBatch('Coregister');
    Parameter=init_CoregisterParameter(OutDir_T1Coregister,InDir_RealignParameter,SubfodrList{i});
    SpmBatch{i} = output_SpmBatch4Corgstr(SpmBatch{i},Parameter);
end


batch_run_spm_jobman(SubfodrList,SpmBatch);

% parfor i=1:length(SubfodrList)
%     run_SpmBatch(SpmBatch{i});
% end


function Parameter=init_CoregisterParameter(T1CoregisterDir,InDir_RealignParameter,SubfodrNam)
Parameter.MeanFilePath=get_MeanImgPath([InDir_RealignParameter filesep SubfodrNam]);
Parameter.CoT1FilePath=inpath_Misc([T1CoregisterDir filesep SubfodrNam],'Get1stSubImgPath');


function SpmBatch = output_SpmBatch4Corgstr(SpmBatch,Parameter)
SpmBatch.jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.ref = {[Parameter.MeanFilePath ',1']};
SpmBatch.jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.source ={Parameter.CoT1FilePath};
