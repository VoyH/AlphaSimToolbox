function indir_Normalize(InDir,OutDir,Parameter)
%---Parameter.NormalizeType
%-EPI
%-InDir=FunImgAR;OutDir=FunImgARW;
%-T1_Segment
%-InDir{1}=FunImgAR;InDir{2}=T1Img;OutDir=FunImgARW;

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

switch Parameter.NormalizeType
    case 'EPI'
       indir_NormalizeEPI(InDir,OutDir,Parameter);
    case 'T1_Segment'
       indir_NormalizeT1Segment(InDir,OutDir,Parameter);
end




function indir_NormalizeT1Segment(InDir,OutDir,Parameter,ImgType)
indir_Coregister(InDir,OutDir);
indir_Segmentation(InDir,OutDir);