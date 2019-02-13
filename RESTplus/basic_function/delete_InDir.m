function delete_InDir(InDir,Option,Parameter)
%delete_InDir(InDir,'RegularExpression',Parameter);
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com




InSubfodrList=dir_NameList(InDir);

switch Option   
    case 'RegularExpression'
        DelRegExp=Parameter;
        delete_UseRegularExpression(InDir,InSubfodrList,DelRegExp);        
end





function delete_UseRegularExpression(InDir,InSubfodrList,DelRegExp)
  for i=1:length(InSubfodrList)  
      FileList4Delete=DeleteList4RegExp([InDir filesep InSubfodrList{i}],DelRegExp);
      delete_FileList(FileList4Delete,[InDir filesep InSubfodrList{i}]);
  end

function FileList4Delete=DeleteList4RegExp(InSubfodrPath,DelRegExp)
FileList4Delete=dir_4RegExp(InSubfodrPath,DelRegExp);
if(isempty(FileList4Delete))  
   fprintf('\n%s\n',InSubfodrPath);
   fprintf('No %s to be delete\n',DelRegExp);  
end
  
function delete_FileList(FileList4Delete,InSubfodrPath)
for i=1:length(FileList4Delete)
    inpath_Misc([InSubfodrPath filesep FileList4Delete{i}],'Path4Delete')
    fprintf('delete %s sucess in %s\n',FileList4Delete{i},inpath_Misc(InSubfodrPath,'GetPathName'));
end



  




