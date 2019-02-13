function [h_edit,obj_module]=...
         image_h_29_text_edit_pushbtn(h_fig,position_xy_width,text_string,default_edit_string)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    inputvalue.h_fig=h_fig;
    inputvalue.module_x=position_xy_width(1);
    inputvalue.module_y=position_xy_width(2);
    inputvalue.modulewidth=position_xy_width(3);
    inputvalue.textstring=text_string;
    
    
    
    %obj___input_brain_image___module
    handles.obj___input_brain_image___model=model_text_edit_pushbtn(default_edit_string);
    handles.obj___input_brain_image___module=...
               view_text_edit_pushbtn(inputvalue,'pixels_h29',handles.obj___input_brain_image___model);
    handles.obj___input_brain_image___module.set_selectdialog_fileext('brainimage');
    handles.obj___input_brain_image___module.set_selectdialogtype('file');
    handles.obj___input_brain_image___module.set_dialogtitle('please select your brain image.');
    handles.h_eidt___input_brain_image___module=handles.obj___input_brain_image___module.get_h_edit;
    
    
    h_edit=handles.h_eidt___input_brain_image___module;
    obj_module=handles.obj___input_brain_image___module;
    
end