function MeanResultMatrix=mean_MultiFolder(MultiFolder,MeanResultName)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



FolderAmount=length(MultiFolder);
[Volume4d_Folder, VoxelSize_Folder, ImgFileList_Folder, Header_Folder, VolumnAmount_Folder] = read_MultiTo4d(MultiFolder);
[DimX,DimY,DimZ,VolumeAmount]=isequal_Multi4dDim(Volume4d_Folder);
Volume4dTem=zeros(DimX,DimY,DimZ,VolumeAmount);

for i=1:FolderAmount
    Volume4dTem=Volume4dTem+Volume4d_Folder{i};
end
MeanResultMatrix=Volume4dTem./FolderAmount;
Head=Header_Folder{1};
Head.dim=[DimX,DimY,DimZ,VolumeAmount];
write_To4dNifti(MeanResultMatrix,Head,MeanResultName);


