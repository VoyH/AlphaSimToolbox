function [h_edit,obj_module]=...
             mat_h_29_text_edit_pushbtn(h_fig,position_xy_width,text_string,default_edit_string)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



    [h_edit,obj_module]=...
         image_h_29_text_edit_pushbtn(h_fig,position_xy_width,text_string,default_edit_string);
    
    
    
        obj_module.set_dialogtitle('please select the matlab file.');
        obj_module.set_selectdialogtype('file');
        obj_module.set_selectdialog_fileext('matfile');
    
    
   
end