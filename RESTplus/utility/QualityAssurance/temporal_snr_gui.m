function temporal_snr_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150726
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles=init_quality_assurance_gui();
set(handles.h_fig,'visible','on');
set(handles.h_radiobtn_ui_struct.h_temporal_snr_radiobutton,'value',1);
handles=init_ui_input_image_edit_box(handles);
handles=init_uicontrol(handles);
init_callback(handles);


guidata(gcf,handles);

end


function handles=init_ui_input_image_edit_box(handles)
%input image
[handles.h_eidt_input_image,handles.obj_input_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line6.y,450],...
                                      'Input brain image:','');
                                  
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
input_image_path=get(handles.h_eidt_input_image,'string');
[pathstr, image_name, ext]=fileparts(input_image_path);
output_directory_path=get(handles.h_eidt_output_directory,'string');
if ~isdir(output_directory_path)
        mkdir(output_directory_path);
end

fprintf('\nrunning tSNR...\n');
fprintf('input: %s\n',input_image_path);
[in_image_data,VoxDim,Header]=read_To3d(input_image_path);
tSNR_image_data=(mean(in_image_data,4))./std(in_image_data,0,4);
tSNR_image_path=[output_directory_path filesep 'tSNR_' image_name '.nii'];
write_To3dNifti(tSNR_image_data,tSNR_image_path,size(tSNR_image_data),...
                VoxDim,Header,'single');
fprintf('tSNR calculation finished!\n ');   
end




