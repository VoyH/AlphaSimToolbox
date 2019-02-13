function callback_asltbx_pcasl_gui(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


 h_ui_struct=handles.h_UI;
 
 set_h_ui_struct_field_callback(h_ui_struct);

end

function set_h_ui_struct_field_callback(h_ui_struct)
 fieldname_list=fieldnames(h_ui_struct);
 for i=1:length(fieldname_list)
     current_field_value=h_ui_struct.(fieldname_list{i});
     if isstruct(current_field_value)
        set_sub_field_callback(current_field_value);
     elseif isnumeric(current_field_value)
        set(current_field_value,'callback',{@pasl_ui_callback}) ; 
     end
 end
end


function set_sub_field_callback(ui_struct)

fieldname_list=fieldnames(ui_struct);
for i=1:length(fieldname_list)
    current_field=fieldname_list{i};
    if strcmp(current_field,'h_text')
%        set(ui_struct.(current_field).('text'),'callback',{@pasl_ui_callback}); 
    elseif strcmp(current_field,'h_radiobtn')
       set_h_radiobtn_field_callback(ui_struct.(current_field));    
    end


end

end


function set_h_radiobtn_field_callback(ui_struct)
fieldname_list=fieldnames(ui_struct);
fields_amount=length(fieldname_list);
h_radiobtn_array=zeros(fields_amount,1);

for i=1:fields_amount
    h_radiobtn_array(i)=ui_struct.(fieldname_list{i});
end


for i=1:fields_amount
    set(ui_struct.(fieldname_list{i}),'callback',{@pasl_radiobtn_callback,h_radiobtn_array});
    
end
end

function pasl_ui_callback(hObject, eventdata)
handles=guidata(hObject);
currenttag=get(hObject,'tag');

if strcmp(currenttag,'work_directory_pushbtn')
    work_directory_path=uigetdir(pwd,'Please select the work directory');
    set(handles.h_UI.WorkDirectoryEdit,'string',work_directory_path);    
elseif strcmp(currenttag,'M0_image_select_pushbtn')
    [FileName,PathName,FilterIndex]=uigetfile({'*.img;*.nii;*.hdr'},'Please select the M0 file?');
    if 0~=FileName
       set(handles.h_UI.M0_image_select_edit,'string',[PathName FileName]);
    end
elseif strcmp(currenttag,'ROI_mask_4_M0_pushbtn')
    [FileName,PathName,FilterIndex]=uigetfile({'*.img;*.nii;*.hdr'},'Please select the ROI mask file?');
    if 0~=FileName
       set(handles.h_UI.ROI_mask_4_M0_edit,'string',[PathName FileName]);
    end
elseif strcmp(currenttag,'tag_run_asltbx_pcasl_pushbtn')
%     oldcolor=get(hObject,'BackgroundColor');
%     set(hObject,'enable','off','BackgroundColor','r');
       set(handles.h_UI.run_asltbx_pcasl_pushbtn,'enable','off');
       run_pushbtn_callback_asltbx_pcasl(handles);
       msgbox('SUCCESS!','SUCCESS');
%        set(handles.h_UI.run_asltbx_pasl_pushbtn,'enable','on');
       %     set(hObject,'enable','on','BackgroundColor',oldcolor);
    
end
end


function pasl_radiobtn_callback(hObject, eventdata,h_radiobtn_array)
 RadioBtnSet(h_radiobtn_array,hObject);
handles=guidata(hObject);
currenttag=get(hObject,'tag');

if strcmp('yes_use_unique_m0',currenttag) 
   set_enable_visible(handles.h_UI.which_approximate_m0,'on');
   set_enable_visible(handles.h_UI.know_unique_m0,'on');   
elseif strcmp('no_use_unique_m0',currenttag)
   set_enable_visible(handles.h_UI.which_approximate_m0,'off');
   set_enable_visible(handles.h_UI.know_unique_m0,'off'); 
   
   set_M0_value_enable(handles,'off')
   set_M0_image_enable(handles,'off');
   set_roi_mask_4_M0_enable(handles,'off'); 
   
   set(handles.h_UI.know_unique_m0.h_radiobtn.yes,'value',0);
   set(handles.h_UI.know_unique_m0.h_radiobtn.no,'value',0);
   
elseif strcmp('yes_know_unique_m0_vaule',currenttag)
   set_M0_value_enable(handles,'on')
   set_M0_image_enable(handles,'off');
   set_roi_mask_4_M0_enable(handles,'off');  
elseif strcmp('not_know_unique_m0_value',currenttag)
   set_M0_value_enable(handles,'off');
   set_M0_image_enable(handles,'on');
   set_roi_mask_4_M0_enable(handles,'on');   
elseif strcmp('open_pasl_tbx',currenttag)
    close(500);
   asltbx_pasl();  
   
elseif strcmp('open_casl_tbx',currenttag)
%     warndlg('casl tbx is not finished!');
    close(200);
    asltbx_pcasl(); 
    
end
end

function set_enable_visible(module_struct,if_enable)
all_field=fieldnames(module_struct);
for i=1:length(all_field)
    if isstruct(module_struct.(all_field{i}))
       all_sub_field=fieldnames(module_struct.(all_field{i}));
       for j=1:length(all_sub_field)
           set(module_struct.(all_field{i}).(all_sub_field{j}),'enable',if_enable);
       end
    else
        set(module_struct.(all_field{i}),'enable',if_enable);
    end
end
end

function set_M0_value_enable(handles,if_enable)
   set(handles.h_UI.M0_value_text,'enable',if_enable); 
   set(handles.h_UI.M0_value_edit,'enable',if_enable);
end

function set_M0_image_enable(handles,if_enable)
   set(handles.h_UI.M0_image_select_text,'enable',if_enable); 
   set(handles.h_UI.M0_image_select_edit,'enable',if_enable); 
   set(handles.h_UI.M0_image_select_pushbtn,'enable',if_enable); 
end

function set_roi_mask_4_M0_enable(handles,if_enable)
   set(handles.h_UI.ROI_mask_4_M0_text,'enable',if_enable); 
   set(handles.h_UI.ROI_mask_4_M0_edit,'enable',if_enable); 
   set(handles.h_UI.ROI_mask_4_M0_pushbtn,'enable',if_enable);
end

