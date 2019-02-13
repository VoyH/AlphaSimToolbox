function pipeline_batch(OperationList,InputParameter)


% OperationCell
% OperationList={'RemoveFirstTimePoints','Realign','NormalizeEpi','T1CoregisterFun',...
%                  'T1Segment','NormalizeSeg','Smooth','Detrend','Filter','RegressOutCovariates',...
%                  'Alff','fALFF','KccReHo','CoHeReHo','FunctionalConnectivity','Vmhc','PerAF','DegreeCentrality'};
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201407
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

h = waitbar(0,'Calculating, please wait...');

for i=1:length(OperationList)
    waitbar(i / length(OperationList));    
    pipeline_kernel(OperationList{i},InputParameter);
end
close(h)
end

