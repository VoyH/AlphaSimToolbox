function indir_Detrend(indir_FunImg,outdir_FunImg,CutNumber)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    if nargin<=2
        CutNumber=10;
    end
    
    SubfoldrList=dir_NameList(indir_FunImg);
    
    
    if matlabpool('size')>0
        parfor i=1:length(SubfoldrList)
            infodr_Detrend([indir_FunImg filesep SubfoldrList{i}],[outdir_FunImg filesep SubfoldrList{i}],CutNumber);
        end
    else
        for i=1:length(SubfoldrList)
            infodr_Detrend([indir_FunImg filesep SubfoldrList{i}],[outdir_FunImg filesep SubfoldrList{i}],CutNumber);
        end        
    end
end