function [ImgType,ImgExt]=infodr_ChekImgTyp(InFodr)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

NiiAmount=dir([InFodr filesep '*.nii']);
ImgAmount=dir([InFodr filesep '*.img']);
NiigzAmount=dir([InFodr filesep '*.nii.gz']);

if length(NiiAmount)==1
       ImgType='.4dnii';    
       ImgExt='.nii';
elseif length(NiiAmount)>1
    ImgType='.3dnii';
    ImgExt='.nii';
elseif length(ImgAmount)>=1
       ImgType='.img';
       ImgExt='.img';
elseif length(NiigzAmount)==1
       ImgType='.nii.gz';
       ImgExt='.gz';
else
    error('Img Amount or Type is error!');
end