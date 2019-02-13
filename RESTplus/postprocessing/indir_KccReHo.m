function indir_KccReHo(indir_FunImg,outfodr_KccReHo,infile_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



    SubfodrList=dir_NameList(indir_FunImg);
    inpath_Misc(outfodr_KccReHo,'MakeCurrentDir');
    
    
if matlabpool('size')>0     
    parfor i=1:length(SubfodrList)
        infodr_KccReHo([indir_FunImg filesep SubfodrList{i}],...
                       [outfodr_KccReHo filesep 'KccReHo_' SubfodrList{i} '.nii'],...
                       infile_Mask,Parameter);
    end
else
    for i=1:length(SubfodrList)
        infodr_KccReHo([indir_FunImg filesep SubfodrList{i}],...
                       [outfodr_KccReHo filesep 'KccReHo_' SubfodrList{i} '.nii'],...
                       infile_Mask,Parameter);
    end
end
end