function [ui_struct]=creat_pipeline_ui_struct(current_UI_cell)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

       ui_struct='';
        for j=1:2:size(current_UI_cell,2)
            propertyname=current_UI_cell{j};
            propertyvalue=current_UI_cell{j+1};       
            ui_struct.(propertyname)=propertyvalue;
        end        
end