function indir_CoHeReHo(indir_FunImg,outfodr_CoHeReHo,infile_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



    inpath_Misc(outfodr_CoHeReHo,'MakeCurrentDir');
    SubfodrList=dir_NameList(indir_FunImg);
    parfor i=1:length(SubfodrList)   
        infodr_Fun=[indir_FunImg filesep SubfodrList{i}];
        outfile_CoHeReHo=[outfodr_CoHeReHo filesep 'CoHeReHo_' SubfodrList{i} '.nii'];
        infodr_CoHeReHo(infodr_Fun,outfile_CoHeReHo,infile_Mask,Parameter);
    end

end