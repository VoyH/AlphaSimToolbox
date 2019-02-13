function pet_normalize_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles=init_pet_normalize_gui('PET: Normalize');
handles=init_text_edit_pushbtn(handles);
handles=init_uicontrol(handles);
set(handles.h_fig,'visible','on');
init_callback(handles);
guidata(gcf,handles);


end


function handles=init_pet_normalize_gui(figure_name)
figure_property.figure_name=figure_name;
handles=init_figure_600x330(figure_property);
handles=init_UserP_600x330(handles);
guidata(gcf,handles);
end

function handles=init_text_edit_pushbtn(handles)
%input directory
[handles.h_eidt_input_directory,handles.obj_input_directory]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line5.y,450],...
                                      'Input directory:','');        
                                  
% Bounding box                                   
[handles.h_edit_bounding_box,handles.obj_bounding_box]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.line6.y,450],...
                                   'Bounding box:','[-90,-126,-72;90,90,108]');   
% Voxel size                                   
[handles.h_edit_voxel_size,handles.obj_voxel_size]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.line7.y,270],...
                                   'Voxel size :','[3 3 3]');
                               
%output directory
[handles.h_eidt_output_directory,handles.obj_output_directory]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line8.y,450],...
                                      'Output directory:','');                                  
                               
end

function handles=init_uicontrol(handles)
ui_property_cell={ {'h_name','h_program_title_text',...
                    'style','text',...
                    'position',[130 275 ...
                                handles.UserP.line1.y 30],...
                    'fontsize',20,...
                    'string','PET: Normalize'},...
                   {'h_name','h_run_pushbtn',...
                    'tag','tag_run_pushbtn',...
                    'style','pushbutton',...
                    'position',[430 handles.UserP.line10.y 100 40],...
                    'string','Run'},...
                    };
                
 handles.h_uicontrol_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_property_cell);                

end

function init_callback(handles)
h_fieldname_list=fieldnames(handles.h_uicontrol_struct);
for i=1:length(h_fieldname_list)
    set(handles.h_uicontrol_struct.(h_fieldname_list{i}),...
        'callback',{@the_uicontrol_callback}); 
end
end


function the_uicontrol_callback(hObject, eventdata)
handles=guidata(hObject);
tag_current=get(hObject,'tag');                
% set(hObject,'enable','off');
if strcmp(tag_current,'tag_run_pushbtn')
   run_pushbtn_callback(handles);
end
set(hObject,'enable','on');


end


function run_pushbtn_callback(handles)
input_string=get(handles.h_eidt_input_directory,'string');
bounding_box=eval(get(handles.h_edit_bounding_box,'string'));
voxel_size=eval(get(handles.h_edit_voxel_size,'string'));
output_string=get(handles.h_eidt_output_directory,'string');
Parameter.BoundingBox=bounding_box;
Parameter.VoxSize=voxel_size;
[pathstr, name, ext]=fileparts(input_string);
indir_NormalizePET(input_string,input_string,[output_string filesep get_Postfix('Normalize') name],...
                   [output_string filesep 'CheckNormalize'],Parameter);
end





