function move_InDir2OutDir(InDir,OutDir,Option,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if nargin<=3
    Parameter='';
    if nargin<=2
        Option='All';
    end
end

InSubfodrList=init_InDirAndOutDir(InDir,OutDir);

switch Option
    case 'All'
        move_all_InDir2OutDir(InDir,OutDir,InSubfodrList);    
    case 'RegularExpression'
        MvRegExp=Parameter;
        move_UseRegularExpression(InDir,OutDir,InSubfodrList,MvRegExp);
        
end

function move_all_InDir2OutDir(InDir,OutDir,InSubfodrList)
for i=1:length(InSubfodrList)
    movefile([InDir filesep InSubfodrList{i}],[OutDir filesep InSubfodrList{i}]);    
end

function move_UseRegularExpression(InDir,OutDir,SubfodrList,MvRegExp)
for i=1:length(SubfodrList)
    FileList4Move=Movelist4RegExp([InDir filesep SubfodrList{i}],MvRegExp);
    move_FileList(FileList4Move,[InDir filesep SubfodrList{i}],[OutDir filesep SubfodrList{i}]);
end

function FileList4Move=Movelist4RegExp(InSubFodrPath,MvRegExp)
FileList4Move=dir_4RegExp(InSubFodrPath,MvRegExp);
if(isempty(FileList4Move))  
   fprintf('\n%s\n',InSubFodrPath);
   fprintf('%s not exist\n',MvRegExp);  
end


function move_FileList(FileList4Move,InSubfodrPath,OutSubfodrPath)
if ~isempty(FileList4Move)
   inpath_Misc(OutSubfodrPath,'MakeCurrentDir');
end
for i=1:length(FileList4Move)
    movefile([InSubfodrPath filesep FileList4Move{i}],[OutSubfodrPath filesep FileList4Move{i}]);
end
 



