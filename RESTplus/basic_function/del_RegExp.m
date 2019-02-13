function [SUCCESS] = del_RegExp(InDir,DelRegExp)
%Used regular expression or whole name to delete files or folders within 'InDir' Folder  By Xi-ze Jia
%------------------------------------------------------------------------------------------------------------------------------
%function [SUCCESS] = del_RegExp(InDir,DelRegExp)
% Input:
%     InDir    -  The directory of input data
%                     1. In this directory, it can be some folders
%                     2. In this directory, it also can be some files
%     DelRegExp   -  The DelRegExp Or the whole name. eg. sub002(s*) or rest.nii(*.nii) or
%     rest.nii(*s*.nii) or rest.nii(rest.nii)
% Output:
%     SUCCESS  -  logical scalar, defining the outcome of del_RegExp.m.
%                 1 : del_RegExp.m executed successfully. 
%                 0 : an error occurred.
%
%___________________________________________________________________________
%	Written by Xi-ze Jia
% 	Mail to Authors:  <a href="willbbetter@gmail.com">Xi-ze Jia</a>;
%	Beta=1.20;
%	Release=20140418;
%           20140428 support delete folder
%           20140516 updata delete message
%   Bug not printf upper dir name
%   Bug if the folder have subfolder ,it also can delete the folder but do
%   not have warning
 
InDirData_list=dir([InDir filesep DelRegExp]);
[InDir_path, InDir_name, InDir_ext] = fileparts(InDir);

 if(isempty(InDirData_list))  
   fprintf('\n%s\n',InDir);
   fprintf('Warning!!!There is no file or folder to be delete!\n');  
   SUCCESS = 0;
 else
   fprintf('In(%s): ',InDir_name);
 end

  
  for i=1:length(InDirData_list)   
     if (isdir([InDir filesep InDirData_list(i).name]))
        fprintf('Del %s FOLDER success\n',InDirData_list(i).name);
        rmdir([InDir filesep InDirData_list(i).name],'s');
        SUCCESS = 1;
     else
        fprintf('Del %s FILE success\n',InDirData_list(i).name);
        delete([InDir filesep InDirData_list(i).name]);  
        SUCCESS = 1; 
     end

  end
  
  
  
end










