function indir_RmFirstTimePoints(InDir,OutDir,TimePointsAmount)
%Remove First X Time Points
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

copy_InDir2OutDir(InDir,OutDir);
InDir=OutDir;
[ImgType,ImgExt]=indir_Chek(InDir);


switch ImgType
    case '.img'
        DeleteImgFirstTimePoints(InDir,TimePointsAmount);
    case '.3dnii'
        DeleteFirstFiles(InDir,TimePointsAmount);
    case '.4dnii'
        DeleteNii4thDim(InDir,TimePointsAmount);
    case '.nii.gz'
        DeleteNiiGzFirstTimePoints(InDir,TimePointsAmount);
end


function DeleteImgFirstTimePoints(InDir,TimePointsAmount)
SubfodrList=dir_NameList(InDir);

for i=1:length(SubfodrList)
    ImgList=dir_4RegExp([InDir filesep SubfodrList{i}],'*.img');
    HdrList=dir_4RegExp([InDir filesep SubfodrList{i}],'*.hdr');
    for j=1:TimePointsAmount
        delete([InDir filesep SubfodrList{i} filesep ImgList{j}]);
        delete([InDir filesep SubfodrList{i} filesep HdrList{j}]);      
    end
end


function  DeleteFirstFiles(InDir,FileAmount)
SubfodrList=dir_NameList(InDir);

for i=1:length(SubfodrList)
    SubfileList=dir_NameList([InDir filesep SubfodrList{i}]);
    for j=1:FileAmount
        delete([InDir filesep SubfodrList{i} filesep SubfileList{j}]);
    end
end


function DeleteNii4thDim(InDir,DelIndex)
SubfodrList=dir_NameList(InDir);

for i=1:length(SubfodrList)
    Nii4dFilePath=inpath_Misc([InDir filesep SubfodrList{i}],'Get1stSubPath');
    [Volume4D, VoxelSize, ImgFileList, Header, VolumnAmount]=read_To4d([InDir filesep SubfodrList{i}]);
    delete(Nii4dFilePath);   
    write_To4dNifti(Volume4D(:,:,:,DelIndex+1:end),Header,Nii4dFilePath);     
end


function DeleteNiiGzFirstTimePoints(InDir,TimePointsAmount) 
SubfodrList=dir_NameList(InDir);

for i=1:length(SubfodrList)
    inpath_Misc([InDir filesep SubfodrList{i}],'Gunzip1stSubGzFile')
end
DeleteNii4thDim(InDir,TimePointsAmount)
