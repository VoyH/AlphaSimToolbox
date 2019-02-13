function indir_NormalizeEPI(indir_FunImg,indir_RealignParameter,outdir_FunImg,outfodr_ChekNorm,Parameter)
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20141001
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

%Parameter.BoundingBox
%Parameter.VoxSize
[ImgType,ImgExt]=indir_Chek(indir_FunImg);
SubfodrList=dir_NameList(indir_FunImg);

if matlabpool('size')>0
    parfor i=1:length(SubfodrList)
        infodr_NormalizeEPI(indir_FunImg,indir_RealignParameter,SubfodrList{i},ImgType,Parameter);
    end
else
    for i=1:length(SubfodrList)
        infodr_NormalizeEPI(indir_FunImg,indir_RealignParameter,SubfodrList{i},ImgType,Parameter);
    end    
end

move_InDir2OutDir(indir_FunImg,outdir_FunImg,'RegularExpression',[get_Postfix('Normalize') '*']);
indir_GeneratePics4Chek(outdir_FunImg,outfodr_ChekNorm);



 