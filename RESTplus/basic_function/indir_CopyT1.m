function indir_CopyT1(InDir_T1,OutDir_T1,SubfodrList)
% Copy T1 from T1Img or T1Coregister and so on 
% If exist co* then copy co*
% else copy *.
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

if nargin<=2
    SubfodrList=dir_NameList(InDir_T1);
end

for i=1:length(SubfodrList)
    T1path=infodr_getT1([InDir_T1 filesep SubfodrList{i}]);
    inpath_Misc([OutDir_T1 filesep SubfodrList{i}],'MakeCurrentDir');   
    if 2==length(T1path)
       T1Name{1}=inpath_Misc(T1path{1},'GetPathWholeName');
       T1Name{2}=inpath_Misc(T1path{2},'GetPathWholeName');
       copyfile(T1path{1},[OutDir_T1 filesep SubfodrList{i} filesep T1Name{1}]);
       copyfile(T1path{2},[OutDir_T1 filesep SubfodrList{i} filesep T1Name{2}]);
    elseif 1==length(T1path)
       T1Name=inpath_Misc(T1path{1},'GetPathWholeName');        
       copyfile(T1path{1},[OutDir_T1 filesep SubfodrList{i} filesep T1Name]);
    elseif isempty(T1path)
        error('There is no image in T1');
    else
        error('T1 is wrong');
    end
end