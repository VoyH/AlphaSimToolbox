function  [Volume4d_Multi,    VoxelSize_Multi, ...
           ImgFileList_Multi, Header_Multi   ,SubjectAmount_Multi]=init_MultiTo4d(MultiAmount)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



for i=1:MultiAmount
    Volume4d_Multi=cell(1,MultiAmount);
    VoxelSize_Multi=cell(1,MultiAmount);
    ImgFileList_Multi=cell(1,MultiAmount);
    Header_Multi=cell(1,MultiAmount);
    SubjectAmount_Multi=zeros(1,MultiAmount);    
end