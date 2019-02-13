function infodr_Filter(AllVolume,OutPutFilePath,InPutMaskFile,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


ASamplePeriod=Parameter.SamplePeriod;
ALowPass_HighCutoff=Parameter.LowPass_HighCutoff;
AHighPass_LowCutoff=Parameter.HighPass_LowCutoff;
AAddMeanBack=Parameter.IsAddMeanBack;
CUTNUMBER=Parameter.CutNumber;

inpath_Misc(OutPutFilePath,'MakeParentDir');
old_bandpass(AllVolume,OutPutFilePath, ...
    ASamplePeriod, ALowPass_HighCutoff, AHighPass_LowCutoff, ...
    AAddMeanBack, ...
    InPutMaskFile,...
    CUTNUMBER)

end









