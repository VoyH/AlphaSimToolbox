function [DimX,DimY,DimZ,VolumeAmount]=isequal_Multi4dDim(Volume4D_Multi)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

[DimX1,DimY1,DimZ1,VolumeAmount1]=size(Volume4D_Multi{1});
for i=2:length(Volume4D_Multi)
    [DimX4Com,DimY4Com,DimZ4Com,VolumeAmount4Com]=size(Volume4D_Multi{i});
    if ((DimX4Com~=DimX1)||(DimY4Com~=DimY1)||(DimZ4Com~=DimZ1)||(VolumeAmount4Com~=VolumeAmount1))
        error('4D Volumn demention not equal!');
    end
end
[DimX,DimY,DimZ,VolumeAmount]=size(Volume4D_Multi{1});