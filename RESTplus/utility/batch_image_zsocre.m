function batch_image_zsocre()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150511
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

figure_property.figure_name='Z-score calculate';
handles=init_figure_600x330(figure_property);
handles=init_UserP_600x330(handles);



set(handles.h_fig,'visible','on');
handles=init_ui_input_image_edit_box(handles);
handles=init_uicontrol(handles);
init_callback(handles);


guidata(gcf,handles);

end


function handles=init_ui_input_image_edit_box(handles)
%input image
[handles.h_eidt_input_image,handles.obj_input_image]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line3.y,450],...
                                      'Input directory:','');

                                  
%mask image
[handles.h_eidt_mask_image,handles.obj_mask_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line5.y,450],...
                                      'Input mask:','');
                                  
%output directory
[handles.h_eidt_output_directory,handles.obj_output_directory]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line7.y,450],...
                                      'Output directory:','');
                                  
end


function handles=init_uicontrol(handles)
ui_property_cell={ {'h_name','h_run_pushbtn',...
                    'tag','tag_run_pushbtn',...
                    'style','pushbutton',...
                    'position',[425 handles.UserP.line9.y 100 50],...
                    'string','RUN'},...
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


set(hObject,'enable','off');
if strcmp(tag_current,'tag_run_pushbtn')
         callback_run_pushbtn(handles);
end
set(hObject,'enable','on');


end


function callback_run_pushbtn(handles)
input_dir_path=get(handles.h_eidt_input_image,'string');
mask_image_path=get(handles.h_eidt_mask_image,'string');
output_directory_path=get(handles.h_eidt_output_directory,'string');
if ~isdir(output_directory_path)
        mkdir(output_directory_path);
end



fprintf('\nrunning tz-score calculation...\n');
fprintf('input: %s\n',input_dir_path);

 batch_calc3dimg('CalcZscoreWithinMask',input_dir_path,output_directory_path,mask_image_path);
 
fprintf('tz-score calculation finished!\n ');   





end