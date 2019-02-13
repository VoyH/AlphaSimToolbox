function indir_Filter(indir_FunImg,outdir_FunImg,InPutMaskFile,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    SubfodrList=dir_NameList(indir_FunImg);
    for i=1:length(SubfodrList)
     infodr_Fun=[indir_FunImg filesep SubfodrList{i}];
     OutPutFilePath=[outdir_FunImg filesep SubfodrList{i} filesep  SubfodrList{i} get_Postfix('Filter') '.nii'];
     infodr_Filter(infodr_Fun,OutPutFilePath,InPutMaskFile,Parameter);
    end
end



