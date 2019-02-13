function indir_NormalizeSeg_Sym_run(funimg_in,normalized_fun,normalized_t1img,templatepath,checknormfolder,Parameter)
%Parameter.BoundingBox
%Parameter.VoxSize
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

[ImgType,ImgExt]=indir_Chek(funimg_in);

SubfodrList=dir_NameList(funimg_in);
SpmBatch=cell(length(SubfodrList),1);
for i=1:length(SubfodrList)
    SpmBatch{i}.jobs = init_SpmBatch('NormalizeSeg_Sym');
    Parameter=init_SegSym_Parameter(funimg_in,normalized_t1img,SubfodrList{i},ImgType,Parameter);
    SpmBatch{i} = output_SpmBatch4SegSym(SpmBatch{i},templatepath,Parameter);
end

parfor i=1:length(SubfodrList) 
    run_SpmBatch(SpmBatch{i});
end

move_InDir2OutDir(funimg_in,normalized_fun,'RegularExpression',[get_Postfix('Normalize_sym') '*']);
if ~isempty(checknormfolder)
   indir_GeneratePics4Chek(normalized_fun,checknormfolder);
end



end


function Parameter=init_SegSym_Parameter(indir_FunImg,normalized_t1img,SubfodrNam,ImgType,Parameter)
Parameter.resamplelist=spread_Fodr4SPM([indir_FunImg filesep SubfodrNam],ImgType);
Parameter.sourcefile={inpath_Misc([normalized_t1img filesep SubfodrNam],'Get1stSubImgPath')};
end


function SpmBatch = output_SpmBatch4SegSym(SpmBatch,templatepath,Parameter)

 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj(1,1).source=Parameter.sourcefile;
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj(1,1).resample =Parameter.resamplelist;
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.template={templatepath};
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.prefix = get_Postfix('Normalize_sym');
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.bb=Parameter.BoundingBox;
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.vox=Parameter.VoxSize;

end