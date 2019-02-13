function brainimg_list=dir_imglist(inpath,prefix)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



if nargin<=1
    prefix='';
end
nii_list=dir_4RegExp(inpath,[prefix '*.nii']);
niigz_list=dir_4RegExp(inpath,[prefix '*.nii.gz']);
img_list=dir_4RegExp(inpath,[prefix '*.img']);

if isempty(nii_list)&&isempty(niigz_list)&& ...
   isempty(img_list)
   brainimg_list='';  
elseif ~isempty(nii_list)
    brainimg_list=nii_list;
elseif ~isempty(img_list)
    brainimg_list=img_list;
elseif ~isempty(niigz_list)
    brainimg_list=niigz_list;
else
    warning('no brain image');
end

end