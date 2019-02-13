function infodr_RegressOutCov(FunImg_Infodr,Fun_Outfodr,infile_Mask,Parameter,CovariablesTextfilepath)
%Parameter.IsRemoveIntercept  1 is yes , 0 is no
%
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

IsRemoveIntercept=Parameter.IsRemoveIntercept;
ImgCovModel=1;
ACovariablesDef.polort=Parameter.PolynomialTrend;
ACovariablesDef.ort_file=CovariablesTextfilepath;
APostfix=get_Postfix('RegressOutCov');
rp_y_RegressOutCovariates(FunImg_Infodr,ACovariablesDef,APostfix,infile_Mask,ImgCovModel,IsRemoveIntercept);

copyfile([FunImg_Infodr APostfix],Fun_Outfodr);
rmdir([FunImg_Infodr APostfix],'s');


end

