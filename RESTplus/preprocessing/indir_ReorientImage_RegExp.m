function indir_ReorientImage_RegExp(indir_fun,outFodr_ReorientMat,RegExp,Parameter)
% Parameter.ReorientMatPrefix
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
    SubfodrList=dir_NameList(indir_fun);
    for i=1:length(SubfodrList)
         SubjPath_RealignParameter=[indir_fun filesep SubfodrList{i}];
        if isdir(SubjPath_RealignParameter)            
            
            obj_path=path_operation(SubjPath_RealignParameter);
            FilePath=obj_path.must_1_brain_image_with_prefix(RegExp);
            
            ReorientImage(FilePath,...
                          [outFodr_ReorientMat filesep Parameter.ReorientMatPrefix SubfodrList{i} '.mat']);
        end
    end

end