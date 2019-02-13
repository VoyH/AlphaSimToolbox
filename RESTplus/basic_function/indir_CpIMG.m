function CopyList=indir_CpIMG(InDir,OutDir,Option,Parameter)
%Parameter.Prefix
%Parameter.ImgExt
%Parameter.SubfodrList
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if ~isfield(Parameter,'SubfodrList')
    Parameter.SubfodrList=dir_NameList(InDir);
end



switch Option
    case 'Prefix'
        CopyList=CpIMG_Prefix(InDir,OutDir,Parameter);
end









function CpIMG_Prefix(InDir,OutDir,Parameter)
if ~isfield(Parameter,'ImgExt')
  [ImgType,ImgExt]=indir_Chek(InDir_T1Img);
end

CopyList='';
j=1;
for i=1:length(Parameter.SubfodrList)
    InFodr=[InDir filesep Parameter.SubfodrList{i}];
    OutFodr=[OutDir filesep Parameter.SubfodrList{i}];
    CopyResult=infodr_CpIMG(InFodr,OutFodr,'Prefix',Parameter);
    if isempty(CopyResult)
        error('%s not exsit in%s',[Parameter.Prefix '*' Parameter.ImgExt],InFodr);
    else
       CopyList{j}=CopyResult;
       CopyResult='';
       j=j+1;
    end
end



    IMGlength=length(dir_NameList(InFodr));
    if(IMGlength==1)&&(strcmp(ImgExt,'.nii'))
       copyfile([InFodr filesep '*.nii'],[OutFodr filesep '*.nii']);
    elseif(IMGlength==2)&&(strcmp(ImgExt,'.img'))
       copyfile([InFodr filesep '*.img'],[OutFodr filesep '*.img']);
       copyfile([InFodr filesep '*.hdr'],[OutFodr filesep '*.hdr']);
    elseif(IMGlength==1)&&(strcmp(ImgExt,'.nii.gz'))
       copyfile([InFodr filesep '*.nii.gz'],[OutFodr filesep '*.nii.gz']);
    else
        fprintf('No %s in %s\n',[Parameter.Prefix '*' Parameter.ImgExt],InFodr);
    end