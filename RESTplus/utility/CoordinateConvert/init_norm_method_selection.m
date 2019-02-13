function handles=init_norm_method_selection(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;


handles=init_uicontrol(handles);
handles=init_ui_text_edit_pushbtn(handles);

handles=init_callback(handles);

end


function handles=init_uicontrol(handles)                            

ui_norm_cell={{'h_name','h_normalize_method',...
                    'style','text',...
                    'position_xy',[45 handles.UserP.line6.y],...,...
                    'string','Normalize method:',...
                    'tag','tag_normalize_method'},...
                  {'h_name','h_epi',...
                    'style','radiobutton',...
                    'position_xy',[215 handles.UserP.line6.y],...,...
                    'string','EPI',...
                    'value',1,...
                    'tag','tag_EPI'},...
                   {'h_name','h_t1_seg',...
                    'style','radiobutton',...
                    'position_xy',[280 handles.UserP.line6.y],...,...
                    'string','T1 image unified segmentation',...
                    'tag','tag_t1_seg'},...
                    {'h_name','h_dartel',...
                    'style','radiobutton',...
                    'position_xy',[215 handles.UserP.line7.y+12],...,...
                    'string','DARTEL by using new segment',...
                    'tag','tag_dartel'},...
                   };
               

               

handles.h_norm_radiobtn_ui_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_norm_cell);  




ui_seg_cell={{'h_name','h_east_asian',...
                    'style','radiobutton',...
                    'position_xy',[215 handles.UserP.line8.y+12*2],...,...
                    'string','East Asian',...
                    'tag','tag_east_asian',...
                    'enable','off'},...
                    {'h_name','h_european',...
                    'style','radiobutton',...
                    'position_xy',[330 handles.UserP.line8.y+12*2],...,...
                    'string','European',...
                    'tag','tag_european',...
                    'value',1,...
                    'enable','off'},...
                    };
handles.h_seg_radiobtn_ui_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_seg_cell);  
                
end

function handles=init_ui_text_edit_pushbtn(handles)
%T1 directory
[handles.h_eidt_t1_img,handles.obj_t1_img]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line8.y-10,450],...
                                      'T1 image:',''); 
 handles.h_pushbtn_t1_img=handles.obj_t1_img.get_h_pushbtn;   
 handles.obj_t1_img.set_module_enable('off');             

 [handles.h_eidt_bounding_box,handles.obj_bounding_box]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.line9.y-10,450],...
                                      'Bounding box:','[-90,-126,-72;90,90,108]'); 
                                  
  [handles.h_eidt_voxel_size,handles.obj_voxel_size]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.line10.y-10,250],...
                                      'Voxel size:','[3 3 3]');                                  
end


function handles=init_callback(handles)
h_norm_radiobutton_list= init_radiobutton_list(handles.h_norm_radiobtn_ui_struct);
h_seg_radiobutton_list= init_radiobutton_list(handles.h_seg_radiobtn_ui_struct);


for i=1:length(h_norm_radiobutton_list)
    set(h_norm_radiobutton_list(i),'callback',{@the_norm_callback,h_norm_radiobutton_list,h_seg_radiobutton_list}); 
end



for i=1:length(h_seg_radiobutton_list)
    set(h_seg_radiobutton_list(i),'callback',{@the_seg_callback,h_seg_radiobutton_list}); 
end



end


function the_norm_callback(hObject, eventdata,h_norm_radiobutton_list,h_seg_radiobutton_list)

handles=guidata(hObject);

tag_current=get(hObject,'tag');                

h_t1_selection_list=[h_seg_radiobutton_list;
                     handles.h_eidt_t1_img;
                     handles.h_pushbtn_t1_img];

if strcmp(get(hObject,'style'),'radiobutton')                
   RadioBtnSet(h_norm_radiobutton_list,hObject);
   
   if strcmp(tag_current,'tag_EPI')
      batch_set_enable(h_t1_selection_list,'off');
   elseif strcmp(tag_current,'tag_t1_seg')
      batch_set_enable(h_t1_selection_list,'on');
   elseif strcmp(tag_current,'tag_dartel')
      batch_set_enable(h_t1_selection_list,'on');
   else    
       error('the_radiobtn_ui_callback');
   end
   
   
end

end

function batch_set_enable(ui_list,enable_str)
for i=1:length(ui_list)
    set(ui_list(i),'enable',enable_str);
end
end


function the_seg_callback(hObject, eventdata,h_seg_radiobutton_list)
   RadioBtnSet(h_seg_radiobutton_list,hObject);
end


