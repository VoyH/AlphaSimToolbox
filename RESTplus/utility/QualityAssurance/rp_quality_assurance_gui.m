function rp_quality_assurance_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150712
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;


handles=init_quality_assurance_gui();

handles=init_uicontrol(handles);
handles=init_ui_input_image_edit_box(handles);

init_callback(handles);
guidata(handles.h_fig,handles);
update_gui(handles);

set(handles.h_fig,'Visible','on');
guidata(gcf,handles);


end









function handles=init_uicontrol(handles)                            

ui_property_cell={ {'h_name','h_define_roi_pushbutton',...
                    'tag','tag_define_roi_pushbutton',...
                    'style','pushbutton',...
                    'position',[220 handles.UserP.line10.y 310 50],...
                    'string','define ROI and calculate image SNR'},...
                    {'h_name','h_run_pushbutton',...
                     'tag','tag_run_pushbutton',...
                     'style','pushbutton',...
                     'position',[440 handles.UserP.line10.y 100 50],...
                     'string','Run'}
                   };

handles.h_uicontrol_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_property_cell);    
end


function handles=init_ui_input_image_edit_box(handles)



%input
[handles.h_eidt___input_brain_image___module,...
handles.obj___input_brain_image___module]=...
                                 image_h_29_text_edit_pushbtn(handles.h_fig,...
                                                              [55,handles.UserP.line6.y,450],...
                                                              'Input brain image:',...
                                                              '');
%output       
[handles.h_eidt___output_direcotry___module,...
 handles.obj___output_direcotry___module]=...
                                 dir_h_29_text_edit_pushbtn(handles.h_fig,...
                                                              [55,handles.UserP.line7.y,450],...
                                                              'Output directory:',...
                                                              pwd);
                                                          

                                                          
       
% result display
[handles.h_eidt___result_value_display___module,...
 handles.obj___result_value_display___module]=...
                                 image_h_29_text_edit_pushbtn(handles.h_fig,...
                                                              [55,handles.UserP.line8.y,250],...
                                                              'Out put value:',...
                                                              '');                                                          
handles.obj___result_value_display___module.convert_edit_to_text();
    
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
h_radiobutton_list=[h_uicontrol_struct.h_image_snr_radiobutton;
                    h_uicontrol_struct.h_temporal_snr_radiobutton;
                    h_uicontrol_struct.h_slice_homogeneity_radiobutton;
                    h_uicontrol_struct.h_detrend_value_radiobutton];
                
if strcmp(get(hObject,'style'),'radiobutton')                
   RadioBtnSet(h_radiobutton_list,hObject);
end

tag_current=get(hObject,'tag');
set(hObject,'enable','off');
if strcmp(tag_current,'tag_run_pushbutton')
         callback_run_pushbutton(handles);
elseif strcmp(tag_current,'tag_define_roi_pushbutton')
         callback_define_roi_pushbutton(handles);
end
set(hObject,'enable','on');


update_gui(handles);

end




function update_gui(handles)


if 1==get(handles.h_radiobtn_ui_struct.h_image_snr_radiobutton,'value')
   handles.obj___output_direcotry___module.set_text_edit_pushbtn_visible('off');
   handles.obj___result_value_display___module.set_text_string('Image SNR value:');
   handles.obj___result_value_display___module.set_text_edit_pushbtn_visible('on');
   set(handles.h_uicontrol_struct.h_run_pushbutton,'visible','off');  
   set(handles.h_uicontrol_struct.h_define_roi_pushbutton,'visible','on');
   set(handles.h_uicontrol_struct.h_run_pushbutton,'visible','off');
   handles.obj___result_value_display___module.set_pushbuton_visible('off');
elseif 1==get(handles.h_radiobtn_ui_struct.h_temporal_snr_radiobutton,'value')
   handles.obj___output_direcotry___module.set_text_edit_pushbtn_visible('on'); 
   handles.obj___result_value_display___module.set_text_edit_pushbtn_visible('off');
   set(handles.h_uicontrol_struct.h_define_roi_pushbutton,'visible','off');
   set(handles.h_uicontrol_struct.h_run_pushbutton,'visible','on');
elseif 1==get(handles.h_radiobtn_ui_struct.h_slice_homogeneity_radiobutton,'value')
   handles.obj___output_direcotry___module.set_text_edit_pushbtn_visible('on'); 
   handles.obj___result_value_display___module.set_text_edit_pushbtn_visible('off');
   set(handles.h_uicontrol_struct.h_define_roi_pushbutton,'visible','off');
   set(handles.h_uicontrol_struct.h_run_pushbutton,'visible','on');    
end

end


function callback_run_pushbutton(handles)
input_image_path=get(handles.h_eidt___input_brain_image___module,'string');
[pathstr, image_name, ext]=fileparts(input_image_path);
output_directory_path=get(handles.h_eidt___output_direcotry___module,'string');
if ~isdir(output_directory_path)
        mkdir(output_directory_path);
end
    

if 1==get(handles.h_uicontrol_struct.h_temporal_snr_radiobutton,'value')
           
elseif 1==get(handles.h_uicontrol_struct.h_slice_homogeneity_radiobutton,'value')

     
%      write_To3dNifti(slice_homogeneity_data,slice_homogeneity_image_path,size(slice_homogeneity_data),...
%                     VoxDim,Header,'single');
                
end            
end




















