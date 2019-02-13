function asltbx_3dasl()
% The algorithm of asltbx_3dasl is based on ASLtbx. The GUI is added by Jia Xi-Ze. 
% Ze Wang, Geoffrey K. Aguirre, Hengyi Rao, Jiongjiong Wang, Maria A. Fernandez-Seara, Anna R. Childress, and John A. Detre, Epirical optimization of ASL data analysis using an ASL data processing toolbox: ASLtbx, Magnetic Resonance Imaging, 2008, 26(2):261-9.
% Wang, Z., Improving Cerebral Blood Flow Quantification for Arterial Spin Labeled Perfusion MRI by Removing Residual Motion Artifacts and Global Signal Fluctuations, Magnetic Resonance Imaging, 2012, 30(10):1409-15.
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20160109
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;
%   170201 fix bug about 3d asl help panel (jiaxize)
clear global
asltbx_mutex('3dasl');
asltbx_infor_display('asltbx_3dasl');

if ~strcmpi(spm('ver'),'SPM12')
   uiwait(msgbox({'3D ASL Normalization program only support SPM12';},'Warning'));
end
figure_property.figure_name='3DASL';
handles=init_figure_600x330(figure_property);
handles=init_UserP_600x330(handles);
set(handles.h_fig,'visible','on');
handles=init_ui_input_image_edit_box(handles);
handles=init_uicontrol(handles);
guidata(gcf,handles);
init_callback(handles);


end


function handles=init_ui_input_image_edit_box(handles)
%input work directory
[handles.h_eidt_work_dir,handles.obj_work_dir]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line5.y,450],...
                                      'Working directory','');
                                                                    
end


function handles=init_uicontrol(handles)
ui_property_cell={ {'h_name','h_program_title_text',...
                    'style','text',...
                    'position',[130 275 ...
                                handles.UserP.line1.y 30],...
                    'fontsize',20,...
                    'string','3D ASL Normalization'},...
                    {'h_name','h_run_pushbtn',...
                    'tag','tag_run_pushbtn',...
                    'style','pushbutton',...
                    'position',[425 handles.UserP.line10.y 100 50],...
                    'string','RUN'},...
                    {'h_name','h_help_pushbtn',...
                    'tag','tag_help_pushbtn',...
                    'style','pushbutton',...
                    'position',[300 handles.UserP.line10.y 100 50],...
                    'string','HELP'},...
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
         run_pushbtn_callback_asltbx_3dasl(handles);
elseif strcmp(tag_current,'tag_help_pushbtn')
        callback_help_pushbtn();
end
set(hObject,'enable','on');


end





function callback_help_pushbtn()
uiwait(msgbox({'All the input image should be arranged as follow';...
        '------------------------------------------------';...
        'Please use same directory name as EXAMPLE shows';...
        'You need select ASL_Analysis folder in gui panel';...
        '------------------------------------------------';...
        'ASL direcotry example:';...
        '-----ASL_Analysis\sub001\FUNC\CBF.nii';...
        '-----ASL_Analysis\sub001\FUNC\PerfM0.nii';...
        '-----ASL_Analysis\sub002\FUNC\CBF.nii'
        '-----ASL_Analysis\sub002\FUNC\PerfM0.nii';...
        '------------------------------------------------';...
        'T1 direcotry example:';...
        '-----ASL_Analysis\sub001\STRUC\T1.nii';...
        '-----ASL_Analysis\sub001\STRUC\T1.nii';...
        ' ';},'3D ASL HELP'));
end

