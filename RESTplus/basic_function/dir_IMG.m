function ListStruct=dir_IMG(Inpath,Prefix)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



if nargin<=1
    Prefix='';
end
ListStruct.nii=dir_4RegExp(Inpath,[Prefix '*.nii']);
ListStruct.niigz=dir_4RegExp(Inpath,[Prefix '*.nii.gz']);
ListStruct.img=dir_4RegExp(Inpath,[Prefix '*.img']);
ListStruct.hdr=dir_4RegExp(Inpath,[Prefix '*.hdr']);

if isempty(ListStruct.nii)&&isempty(ListStruct.niigz)&& ...
   isempty(ListStruct.img)&&isempty(ListStruct.hdr)

   ListStruct='';
end