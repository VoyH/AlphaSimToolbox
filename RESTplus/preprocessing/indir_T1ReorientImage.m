function indir_T1ReorientImage(indir_T1,outFodr_ReorientMat,Parameter)
% Parameter.ReorientMatPrefix
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

SubfodrList=dir_NameList(indir_T1);
for i=1:length(SubfodrList)
    T1Path=infodr_getT1([indir_T1 filesep SubfodrList{i}]);

    ReorientImage(T1Path{1},...
                     [outFodr_ReorientMat filesep Parameter.ReorientMatPrefix SubfodrList{i} '.mat']);
end

end