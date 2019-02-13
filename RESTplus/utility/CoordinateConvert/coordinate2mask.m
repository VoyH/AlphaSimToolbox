function coordinate2mask(inpath_image,outpath_image_mask,input_coordinate)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    [Outdata,VoxDim,Header]=read_To3d(inpath_image);
    [ijk_roi]=HeaderCalc('MNI2IJK',input_coordinate,Header);
    zeros_data=zeros(size(Outdata));
    zeros_data(ijk_roi(1),ijk_roi(2),ijk_roi(3))=1;   
    write_To3dNifti(zeros_data,outpath_image_mask,size(Outdata),VoxDim,Header,'single'); 
end