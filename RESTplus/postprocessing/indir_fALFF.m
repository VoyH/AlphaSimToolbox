function indir_fALFF(indir_FunImg,outfodr_fALFF,infile_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



inpath_Misc(outfodr_fALFF,'MakeCurrentDir');
SubfodrList=dir_NameList(indir_FunImg);
parfor i=1:length(SubfodrList)
    infodr_Fun=[indir_FunImg filesep SubfodrList{i}];
    outfile_fALFF=[outfodr_fALFF filesep 'fALFF_' SubfodrList{i} '.nii'];
    infodr_fALFF(infodr_Fun,outfile_fALFF,infile_Mask,Parameter);
end

end