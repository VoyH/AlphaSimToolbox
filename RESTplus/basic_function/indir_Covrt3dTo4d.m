function indir_Covrt3dTo4d(InDir)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

[ImgType,ImgExt]=indir_Chek(InDir);
SubfodrList=dir_NameList(InDir);

for i=1:length(SubfodrList)
    SubjetFodrPath=[InDir filesep SubfodrList{i}];
    switch ImgType   
        case '.img'
            Fodr_Covrt3dTo4d(SubjetFodrPath);
        case '.3dnii'
            Fodr_Covrt3dTo4d(SubjetFodrPath);
        case '.nii.gz'
            Fodr_CovrtNiigzTo4d(SubjetFodrPath);
    end
end


function Fodr_Covrt3dTo4d(FodrPath)
[Volume4D, VoxelSize, ImgFileList, Header, VolumnAmount]=read_To4d(FodrPath);
inpath_Misc(FodrPath,'FodrEmpty')
FodrNam=inpath_Misc(FodrPath,'GetPathName');
write_To4dNifti(Volume4D,Header,[FodrPath filesep FodrNam '.nii']);

function Fodr_CovrtNiigzTo4d(SubjetFodrPath)
inpath_Misc(SubjetFodrPath,'Gunzip1stSubGzFile')


