function norm2orig_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150720
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles=init_coordinate_convert_gui('norm-orig');


handles=init_uicontrol(handles);
handles=init_ui_text_edit_pushbtn(handles);
set(handles.h_fig,'visi','on ');

init_callback(handles);
guidata(gcf,handles);
end



function handles=init_uicontrol(handles)                            
set(handles.h_radiobtn_ui_struct.h_norm2orig_radiobutton,'value',1);
ui_property_cell={{'h_name','h_convert_pushbutton',...
                    'tag','tag_convert_pushbutton',...
                    'style','pushbutton',...
                    'visible','on',...
                    'position',[460 handles.UserP.close_line43.y 100 40],...
                    'string','Convert'},...
                   };

handles.h_uicontrol_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_property_cell);    
end





function handles=init_ui_text_edit_pushbtn(handles)
%input image
[handles.h_eidt_input_image,handles.obj_input_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.close_line20.y,450],...
                                      'Normalized brain image:','');
 
 [handles.h_eidt_ref_image,handles.obj_ref_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.close_line24.y,450],...
                                      'Original brain image:','');
                                  
 [handles.h_eidt_sn_mat,handles.obj_sn_mat]=...
         mat_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.close_line28.y,450],...
                                      'SN.mat:','');

  [handles.h_edit_coor_input,handles.obj_coor_input]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.close_line32.y,300],...
                                      'Coordinate in MNI:','');
                                  
%   handles.obj_coor_input.set_pushbuton_visible('off');                               
                                  
%output directory
[handles.h_eidt_output_dir,handles.obj_output_dir]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line9.y,450],...
                                      'Output directory:',pwd);
                                  
    
end






function init_callback(handles)
h_fieldname_list=fieldnames(handles.h_uicontrol_struct);
for i=1:length(h_fieldname_list)
    set(handles.h_uicontrol_struct.(h_fieldname_list{i}),...
        'callback',{@the_uicontrol_callback,handles.h_uicontrol_struct}); 
end

set(handles.h_edit_coor_input,...
        'callback',{@edit_coor_input_callback}); 
    
end







function the_uicontrol_callback(hObject, eventdata,h_uicontrol_struct)
handles=guidata(hObject);

                
                
tag_current=get(hObject,'tag');                
 

set(hObject,'enable','off');
if strcmp(tag_current,'tag_convert_pushbutton')
   convert_pushbutton_callback(handles);
end
set(hObject,'enable','on');
    
    
    


end



function edit_coor_input_callback(hObject, eventdata)
     coor_string=get(hObject,'string');
     coor_text =eval(['[',coor_string,']']);
     set(hObject,'string',num2str(coor_text))
     
end



function convert_pushbutton_callback(handles)
    coor_string=get(handles.h_edit_coor_input,'string');
    coor_num=str2num(coor_string);
    input_image_string=get(handles.h_eidt_input_image,'string');
    [image_pathstr,image_name,image_ext]=fileparts(input_image_string);
    
    ref_image_string=get(handles.h_eidt_ref_image,'string');
    sn_mat_string=get(handles.h_eidt_sn_mat,'string');
    output_dir_string=get(handles.h_eidt_output_dir,'string');
    
    outpath_coordinate_mask=[output_dir_string filesep image_name '_coor_mask' image_ext];
    coordinate2mask(input_image_string,outpath_coordinate_mask,coor_num);
    
    in3dfile_DeformationInverse...
         (sn_mat_string,ref_image_string,outpath_coordinate_mask,output_dir_string);
    

end




