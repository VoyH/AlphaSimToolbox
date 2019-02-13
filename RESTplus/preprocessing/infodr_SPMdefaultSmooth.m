function infodr_SPMdefaultSmooth(infodr_Fun,outfodr_Fun,Parameter)
% Parameter.FWHM
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

    [ImgType,ImgExt]=infodr_ChekImgTyp(infodr_Fun);
    SpmBatch.jobs = init_SpmBatch('SPMdefaultSmooth');
    Parameter=init_SmoothParameter(infodr_Fun,ImgType,Parameter);
    SpmBatch = output_SpmBatch4Smooth(SpmBatch,Parameter);
    run_SpmBatch(SpmBatch);
    move_Infodr2Outfodr(infodr_Fun,outfodr_Fun,'RegExp',[get_Postfix('Smooth') '*'])
end

function Parameter=init_SmoothParameter(infodr_Fun,ImgType,Parameter)
    Parameter.FileList=spread_Fodr4SPM(infodr_Fun,ImgType);
end

function SpmBatch = output_SpmBatch4Smooth(SpmBatch,Parameter)
    SpmBatch.jobs{1,1}.spatial{1,1}.smooth.data = Parameter.FileList; 
    SpmBatch.jobs{1,1}.spatial{1,1}.smooth.fwhm =Parameter.FWHM;
    SpmBatch.jobs{1,1}.spatial{1,1}.smooth.prefix =get_Postfix('Smooth');
end

