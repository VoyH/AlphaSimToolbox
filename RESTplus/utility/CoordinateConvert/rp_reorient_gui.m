function rp_reorient_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



handles=init_gui();
init_callback(handles);

end

function handles=init_gui()
    handles=init_coordinate_convert_gui('Reorient');
    set(handles.h_radiobtn_ui_struct.h_reorient,'value',1);
    handles=init_ui_text_edit_pushbtn(handles);
    handles=init_uicontrol(handles);
    set(handles.h_fig,'visi','on ');
    guidata(handles.h_fig,handles);
end


function handles=init_ui_text_edit_pushbtn(handles)   
%input image
[handles.h_eidt_input_image,handles.obj_input_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line6.y,450],...
                                      'Input brain image:','');
                                  
                                                          
%output directory
[handles.h_eidt_output_dir,handles.obj_output_dir]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line7.y,450],...
                                      'Output directory:',pwd);
                                  
end


function handles=init_uicontrol(handles)
ui_property_cell={{'h_name','h_transformation_pushbutton',...
                     'tag','tag_transformation_pushbutton',...
                     'style','pushbutton',...
                     'visible','on',...
                     'position',[460 handles.UserP.close_line43.y 100 40],...
                     'string','Reorient'}
                   };

handles.h_uicontrol_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_property_cell);  
end


function init_callback(handles)
h_fieldname_list=fieldnames(handles.h_uicontrol_struct);
for i=1:length(h_fieldname_list)
    set(handles.h_uicontrol_struct.(h_fieldname_list{i}),...
        'callback',{@the_uicontrol_callback,handles.h_uicontrol_struct}); 
end
end


function the_uicontrol_callback(hObject, eventdata,h_uicontrol_struct)

handles=guidata(hObject);
              
tag_current=get(hObject,'tag');                
% set(hObject,'enable','off');
if strcmp(tag_current,'tag_transformation_pushbutton')
   transformation_pushbutton_callback(handles);
end
set(hObject,'enable','on'); 


end


function transformation_pushbutton_callback(handles)
output_dir=get(handles.h_eidt_output_dir,'string');
input_image=get(handles.h_eidt_input_image,'string');


[pathstr, image_name, image_ext]=fileparts(input_image);
transformed_mat_path=[output_dir filesep image_name '_reorient.mat'];
reorient_image=[output_dir filesep image_name '_reorient' image_ext];
copy_brainimage_file(input_image,reorient_image);


% fprintf('\Reorienting image for %s: \n',reorient_image);



global spm_image_reorient_Parameters
spm_image_reorient_Parameters.ReorientFileList={[reorient_image,',1']};
uiwait(spm_image_reorient('init',reorient_image));
mat=spm_image_reorient_Parameters.ReorientMat;
save(transformed_mat_path,'mat');
clear global spm_image_reorient_Parameters
fprintf('Reorienting image for %s: OK \n',reorient_image);
guidata(gcf,handles);



end






