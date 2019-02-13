function run_pushbtn_callback_asltbx_3dasl(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20160109
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

global asl3D_P

% PAR.root=data_root;
asl3D_P.root=get(handles.h_eidt_work_dir,'string');

which batch_run
batch_run;

end