function del_RefTex(InDir,SubsInfo_path)
%Beta 1.00
%Used text which path is SubsInfo_path to delete the SubFiles within InDir  By Xi-ze Jia
%------------------------------------------------------------------------------------------------------------------------------
%function del_RefTex(InDir,SubsInfo_path)
% Input:
%     InDir           -  The directory of input data
%                        In this directory, it must be some files
%     SubsInfo_path   -  The text file of subject information
%___________________________________________________________________________
%	Written by Xi-ze Jia
% 	Mail to Authors:  <a href="willbbetter@gmail.com">Xi-ze Jia</a>;
%	Release=20140418;
%   Revised by Xi-ze Jia 20140516 support text empty
%Bug: Only support the '.txt' with one column(Subject number)
%     Subject Number must be the first column
%     Only support delete the subfiles like ALFF or ReHo within InDir





fid = fopen(SubsInfo_path);
SubsInfo_struct = textscan(fid,'%s');
Subject.no=SubsInfo_struct{1};
 if isempty(Subject.no)
    [pathstr, name, ext]=fileparts(SubsInfo_path);
    fprintf('%s%s is empty\n',name,ext);
 end

 for i=1:length(Subject.no)
 del_RegExp(InDir,['*' char(Subject.no(i)) '*']);    
 end

end