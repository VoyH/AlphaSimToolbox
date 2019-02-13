function [ResultMaps]=infodr_FunctionalConnectivity(AllVolume,outfileNam_FC,infile_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


ACovariablesDef=Parameter.CovariablesDef;
VorR_tag=Parameter.VorR_tag;
AROIDef=Parameter.ROIDef;
[ResultMaps]=rp_fc(AllVolume,infile_Mask, AROIDef,outfileNam_FC, ACovariablesDef, VorR_tag);
end