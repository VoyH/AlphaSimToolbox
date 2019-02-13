function [Volume4d_Multi, VoxelSize_Multi, ImgFileList_Multi, Header_Multi, VolumnAmount_Multi] = read_MultiTo4d(MultiFolder)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



MultiAmount=length(MultiFolder);
[Volume4d_Multi,VoxelSize_Multi,ImgFileList_Multi,Header_Multi,VolumnAmount_Multi]=init_MultiTo4d(MultiAmount);

for i=1:MultiAmount
    [Volume4d_Multi{i},VoxelSize_Multi{i},ImgFileList_Multi{i},Header_Multi{i},VolumnAmount_Multi(i)]=read_To4d(MultiFolder{i});
end