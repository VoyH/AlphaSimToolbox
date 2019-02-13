function indir_FunReorientImage(indir_RealignParameter,outFodr_ReorientMat,Parameter)
% Parameter.ReorientMatPrefix
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
    SubfodrList=dir_NameList(indir_RealignParameter);
    for i=1:length(SubfodrList)
         SubjPath_RealignParameter=[indir_RealignParameter filesep SubfodrList{i}];
        if isdir(SubjPath_RealignParameter)
            MeanFilePath=get_MeanImgPath(SubjPath_RealignParameter);
            ReorientImage(MeanFilePath,...
                          [outFodr_ReorientMat filesep Parameter.ReorientMatPrefix SubfodrList{i} '.mat']);
        end
    end

end