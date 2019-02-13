function image_snr_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150726
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles=init_quality_assurance_gui();
set(handles.h_fig,'visible','on');
set(handles.h_radiobtn_ui_struct.h_image_snr_radiobutton,'value',1);

handles=init_ui_input_image_edit_box(handles);
handles=init_uicontrol(handles);
handles=h_29_section_module(handles,40,handles.UserP.line8.y);
init_callback(handles);



guidata(gcf,handles);


end


function handles=init_ui_input_image_edit_box(handles)
%input image
[handles.h_eidt_input_image,handles.obj_input_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line5.y,450],...
                                      'Input brain image:','');
% Within Brain ROI position                                   
[handles.h_edit_in_brain_roi_pos,handles.obj_in_brain_roi_pos]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.line6.y,450],...
                                   'ROI radius within brain:','10');   
% Out of brain  ROI position                                   
[handles.h_edit_out_brain_roi_pos,handles.obj_out_brain_roi_pos]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.line7.y,450],...
                                   'ROI radius out of brain:','10');  
                               
% result                                  
[handles.h_text2_result,handles.obj_result]=...
         h_29_text_text_pushbtnoff(handles.h_fig,[55,handles.UserP.line9.y,250],...
                                   'Image SNR:',''); 
                                  
                                  
                                  
end


function handles=init_uicontrol(handles)
ui_property_cell={ {'h_name','h_run_pushbtn',...
                    'tag','tag_run_pushbtn',...
                    'style','pushbutton',...
                    'position',[220 handles.UserP.line10.y-20 310 40],...
                    'string','View ROI and calculate image SNR'},...
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

[h_figure_roi,ref_slice_data,in_brain_pos,out_brain_pos]=init_callback_run_pushbtn(handles);
[roi_data_in_brain roidata_out_brain]=get_2_ROIs_data(h_figure_roi,ref_slice_data,in_brain_pos,out_brain_pos);

if 1==get(handles.h_radiobtn_ui_struct.h_image_snr_radiobutton,'value')
    image_snr=mean(roi_data_in_brain(:))/std(roidata_out_brain(:));
    handles.obj_result.set_edit_string(num2str(image_snr));
end



end


function [h_figure_roi,ref_slice_data,in_brain_pos,out_brain_pos]=init_callback_run_pushbtn(handles)

brainimage_path=get(handles.h_eidt_input_image,'string');
ref_slice_data=get_ref_section_data(handles,brainimage_path);
[in_brain_pos,out_brain_pos]=get_roi_pos(handles);
h_figure_roi=figure;
end


function [in_brain_pos,out_brain_pos]=get_roi_pos(handles)

in_brain_pos_str=get(handles.h_edit_in_brain_roi_pos,'string');
out_brain_pos_str=get(handles.h_edit_out_brain_roi_pos,'string');
in_brain_pos_num=eval(in_brain_pos_str);
out_brain_pos_num=eval(out_brain_pos_str);

in_brain_pos=[35,30,in_brain_pos_num*2,in_brain_pos_num*2];
out_brain_pos=[5,5,out_brain_pos_num*2,out_brain_pos_num*2];


% in_brain_pos=[in_brain_pos_num(1),in_brain_pos_num(2),in_brain_pos_num(3)*2,in_brain_pos_num(3)*2];
% out_brain_pos=[out_brain_pos_num(1),out_brain_pos_num(2),out_brain_pos_num(3)*2,out_brain_pos_num(3)*2];

end


function [roi_data_in_brain roidata_out_brain]=...
          get_2_ROIs_data(h_figure_roi,ref_slice_data,in_brain_pos,out_brain_pos)

ref_slice_data=imrotate(ref_slice_data,90);   

imshow_h=show_the_image(h_figure_roi,ref_slice_data);
uiwait(msgbox('please select the ROI within brain','ROI selection','help'));
[ref_slice_data roi_data_in_brain]=draw_roi(ref_slice_data,h_figure_roi,imshow_h,in_brain_pos);


              
imshow_h=show_the_image(h_figure_roi,ref_slice_data);
uiwait(msgbox('please select the ROI out of brain','ROI selection','help'));
[ref_slice_data roidata_out_brain]=draw_roi(ref_slice_data,h_figure_roi,imshow_h,out_brain_pos);
              
show_the_image(h_figure_roi,ref_slice_data);
close(h_figure_roi);

end

function h_imshow=show_the_image(figure_h,slice_data)
figure(figure_h);
h_imshow=imshow(slice_data,[],'InitialMagnification','fit');
end


function [data_in_slice data_in_roi]=draw_roi(data_in_slice,figure_h,h_imshow,roi_pos)

figure(figure_h);
h_imellipse=imellipse(gca, roi_pos);
wait(h_imellipse);
imellipse___mask=h_imellipse.createMask(h_imshow);     
data_in_roi=data_in_slice(imellipse___mask);
data_in_slice(imellipse___mask)=0;


end

