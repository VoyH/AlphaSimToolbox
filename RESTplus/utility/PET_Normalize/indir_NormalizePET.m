function indir_NormalizePET(indir_FunImg,indir_SourceImage,outdir_FunImg,outfodr_ChekNorm,Parameter)
%Parameter.BoundingBox
%Parameter.VoxSize
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150729
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;
[ImgType,ImgExt]=indir_Chek(indir_FunImg);
SubfodrList=dir_NameList(indir_FunImg);
parfor i=1:length(SubfodrList)
    infodr_NormalizePET(indir_FunImg,indir_SourceImage,SubfodrList{i},ImgType,Parameter);
end
move_InDir2OutDir(indir_FunImg,outdir_FunImg,'RegularExpression',[get_Postfix('Normalize') '*']);
indir_GeneratePics4Chek(outdir_FunImg,outfodr_ChekNorm);