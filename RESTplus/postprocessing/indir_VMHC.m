function indir_VMHC(indir_FunImg,outfodr_VMHC,infile_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if 0==infile_Mask
    infile_Mask='';
end
inpath_Misc(outfodr_VMHC,'MakeCurrentDir');
SubfodrList=dir_NameList(indir_FunImg);
parfor i=1:length(SubfodrList)
    infodr_Fun=[indir_FunImg filesep SubfodrList{i}];
    outfile_VMHC=[outfodr_VMHC filesep 'VMHC_' SubfodrList{i} '.nii'];
    [VMHCBrain, Header]= infodr_VMHC(infodr_Fun,outfile_VMHC,infile_Mask,Parameter);
end
end