function [VMHCBrain, Header]= infodr_VMHC(AllVolume,outfile_VMHC,infile_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if 0==infile_Mask
   infile_Mask='';
end
CUTNUMBER=Parameter.CutNumber;
[VMHCBrain, Header]= rp_VMHC(AllVolume, outfile_VMHC, infile_Mask, 0, '', '', '', '', '', '',CUTNUMBER);
end