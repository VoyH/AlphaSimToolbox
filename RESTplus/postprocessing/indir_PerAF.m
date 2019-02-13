function indir_PerAF(indir_FunImg,outfodr_PerAF,infilepath_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


inpath_Misc(outfodr_PerAF,'MakeCurrentDir');
SubfodrList=dir_NameList(indir_FunImg);


if matlabpool('size')>0 
    parfor i=1:length(SubfodrList)
       infodr_PerAF([indir_FunImg filesep SubfodrList{i}],...
                     [outfodr_PerAF filesep 'PerAF_' SubfodrList{i} '.nii'],...
                     infilepath_Mask,Parameter);
    end
else
    for i=1:length(SubfodrList)
       infodr_PerAF([indir_FunImg filesep SubfodrList{i}],...
                     [outfodr_PerAF filesep 'PerAF_' SubfodrList{i} '.nii'],...
                     infilepath_Mask,Parameter);
    end
end


end