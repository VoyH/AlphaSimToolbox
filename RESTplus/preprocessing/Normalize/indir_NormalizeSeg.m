function indir_NormalizeSeg(InDir_Img,OutDir_Img,InDir_T1Seg,outfodr_ChekNorm,Parameter)
%Parameter.BoundingBox
%Parameter.VoxSize
%outfodr_ChekNorm = ''; do not creat folder for check normalize
%Normalize InDir_Img by unified segmentation
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

[ImgType,ImgExt]=indir_Chek(InDir_Img);

SubfodrList=dir_NameList(InDir_Img);
SpmBatch=cell(length(SubfodrList),1);
for i=1:length(SubfodrList)
    SpmBatch{i}.jobs = init_SpmBatch('Normalizewrite');
    Parameter=init_NormalizeSegParameter(InDir_Img,InDir_T1Seg,SubfodrList{i},ImgType,Parameter);
    SpmBatch{i} = output_SpmBatch4NormalizeSeg(SpmBatch{i},Parameter);
end

% parfor i=1:length(SubfodrList)
%     run_SpmBatch(SpmBatch{i});
% end

batch_run_spm_jobman(SubfodrList,SpmBatch);


if ~strcmpi(InDir_Img,OutDir_Img)
    move_InDir2OutDir(InDir_Img,OutDir_Img,'RegularExpression',[get_Postfix('Normalize') '*']);
end

if ~isempty(outfodr_ChekNorm)
   indir_GeneratePics4Chek(OutDir_Img,outfodr_ChekNorm);
end


function Parameter=init_NormalizeSegParameter(InDir_FunImg,InDir_T1Seg,SubfodrNam,ImgType,Parameter)
Parameter.FileList=spread_Fodr4SPM([InDir_FunImg filesep SubfodrNam],ImgType);
Parameter.MatFilePath={inpath_Misc([InDir_T1Seg filesep SubfodrNam filesep '*seg_sn.mat'],'Get1SubPath_RegExp')};


function SpmBatch = output_SpmBatch4NormalizeSeg(SpmBatch,Parameter)
SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.subj.matname = Parameter.MatFilePath;
SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.subj.resample = Parameter.FileList; 
if isfield(Parameter,'BoundingBox')
    SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.bb = Parameter.BoundingBox;
end

if isfield(Parameter,'VoxSize')
    SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.vox = Parameter.VoxSize;
end

SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.prefix = get_Postfix('Normalize');
    