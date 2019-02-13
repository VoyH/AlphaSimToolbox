function set_spm_path(AOperation)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



if strcmp(AOperation,'default')
    spmpath=get_Parameters('SPMFUNCTIONPATH');
    addpath(genpath(spmpath));
end
end