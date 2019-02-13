function [NoExistList]=indir_IsExist(InDir,RegExp,SubfodrList)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if nargin<=2
    SubfodrList=dir_NameList(InDir);
end
j=1;
NoExistList='';
for i=1:length(SubfodrList)
    FocusFile=dir_4RegExp([InDir filesep SubfodrList{i}],RegExp);
    if isempty(FocusFile)
       NoExistList{j}=SubfodrList{i};
    else
       FocusFile=''; 
    end
end

