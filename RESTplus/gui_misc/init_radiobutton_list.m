function h_radiobutton_list= init_radiobutton_list(h_radiobtn_ui_struct)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150726
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

    h_fieldname_list=fieldnames(h_radiobtn_ui_struct);
    h_radiobutton_list=zeros(length(h_fieldname_list),1);
    for i=1:length(h_fieldname_list)
    h_radiobutton_list(i)=h_radiobtn_ui_struct.(h_fieldname_list{i});
    end
end