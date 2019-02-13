function indir_Dicom2Nifti(InDir,OutDir)
% InDir include SubFolder
% InDir FunRaw
% OutDir FunImg
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



OldDirTemp=pwd;
cd(InDir);
SubFolderList=dir_NameList(InDir);
for i=1:length(SubFolderList)
    OutputDir=[OutDir filesep SubFolderList{i}];
    inpath_Misc(OutputDir,'UpdateCurrentDir')
    DicomFileList=dir_List([InDir filesep SubFolderList{i}]);
    call_DicomConvert([InDir filesep SubFolderList{i} filesep DicomFileList(1).name], ...
                       OutputDir, ...
                       'DefaultINI');
                   
    fprintf(['Converting Dicom Images:',SubFolderList{i},' OK\n']);
    
end

if isdir(OldDirTemp)
   cd(OldDirTemp);
end