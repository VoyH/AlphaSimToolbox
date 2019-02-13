function orig2norm_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150720
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles=init_coordinate_convert_gui('orig-norm');
handles=init_uicontrol(handles);
handles=init_ui_text_edit_pushbtn(handles);
handles=init_norm_method_selection(handles);
set(handles.h_fig,'visi','on ');

init_callback(handles);
guidata(handles.h_fig,handles);
end


function handles=init_uicontrol(handles)                            
set(handles.h_radiobtn_ui_struct.h_orig2norm_radiobutton,'value',1);

ui_property_cell={{'h_name','h_define_ROI_pushbutton',...
                     'tag','tag_define_ROI_pushbutton',...
                     'style','pushbutton',...
                     'visible','on',...
                     'position',[300 handles.UserP.close_line43.y 155 35],...
                     'string','Define coordinate'},...
                  {'h_name','h_convert_pushbutton',...
                     'tag','tag_convert_pushbutton',...
                     'style','pushbutton',...
                     'visible','on',...
                     'position',[460 handles.UserP.close_line43.y 100 35],...
                     'string','Convert'}
                   };

handles.h_uicontrol_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_property_cell);    
end




function handles=init_ui_text_edit_pushbtn(handles)   
%input image
[handles.h_eidt_input_image,handles.obj_input_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line4.y,450],...
                                      'Input brain image:','');
                                  
                                                          
%output directory
[handles.h_eidt_output_dir,handles.obj_output_dir]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line5.y,450],...
                                      'Output directory:',pwd);
                                  
                                 
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
if strcmp(tag_current,'tag_convert_pushbutton')
       convert_pushbutton_callback(handles);
elseif strcmp(tag_current,'tag_define_ROI_pushbutton')
       define_ROI_pushbutton_callback(hObject,handles);
end
set(hObject,'enable','on');   


end


function convert_pushbutton_callback(handles)
output_dir=get(handles.h_eidt_output_dir,'string');
input_image=get(handles.h_eidt_input_image,'string');

[pathstr, image_name, image_ext]=fileparts(input_image);


coordinate_mask=[output_dir filesep image_name '_coordinate_mask_org.nii'];
coordinate2mask(input_image,...
                coordinate_mask,...
                handles.input_coordinate);

output_image=[output_dir filesep image_name '_coordinate_mask_norm.nii'];  
[normalized_method,affine_regu,bounding_box,voxel_size]=get_normalized_parameter(handles);
normalized_coordinate_mask(coordinate_mask,...
                           input_image,...
                           output_image,...
                           normalized_method,affine_regu,bounding_box,voxel_size,handles);
            
            
end

function define_ROI_pushbutton_callback(hObject,handles)
input_image=get(handles.h_eidt_input_image,'string');
handles.input_coordinate=get_coordinate(input_image);                                    
guidata(hObject,handles);
end



function the_coordinate=get_coordinate(input_image)
global spm_image_setroi_Parameters
uiwait(spm_image_setroi('init',input_image));
          the_coordinate=[spm_image_setroi_Parameters.pos(1),...
                          spm_image_setroi_Parameters.pos(2),...
                          spm_image_setroi_Parameters.pos(3)];
end


function [normalized_method,affine_regu,bounding_box,voxel_size]=get_normalized_parameter(handles)

if 1==get(handles.h_norm_radiobtn_ui_struct.h_epi,'value')
   normalized_method='EPI'; 
elseif 1==get(handles.h_norm_radiobtn_ui_struct.h_t1_seg,'value')
   normalized_method='Norm_seg'; 
elseif 1==get(handles.h_norm_radiobtn_ui_struct.h_dartel,'value')
    normalized_method='Dartel';
end


if 1==get(handles.h_seg_radiobtn_ui_struct.h_east_asian,'value')
   affine_regu='eastern'; 
elseif 1==get(handles.h_seg_radiobtn_ui_struct.h_european,'value')
   affine_regu='mni'; 
end


bounding_box=eval(get(handles.h_eidt_bounding_box,'string'));
voxel_size=eval(get(handles.h_eidt_voxel_size,'string'));




end

function normalized_coordinate_mask(image_to_write,source_image,normalized_image,...
                                    normalized_method,affine_regu,bounding_box,voxel_size,...
                                    handles)
Parameter.BoundingBox=bounding_box;
Parameter.VoxSize=voxel_size;
Parameter.AffineRegularisation=affine_regu;
in_t1_file=get(handles.h_eidt_t1_img,'string');
output_dir=get(handles.h_eidt_output_dir,'string');
if strcmpi(normalized_method,'EPI')
    in3dfile_NormalizeEPI(image_to_write,source_image,normalized_image,Parameter);
elseif strcmpi(normalized_method,'Norm_seg')
    run_Norm_seg(in_t1_file,output_dir,source_image,normalized_image,image_to_write,Parameter);
elseif strcmpi(normalized_method,'Dartel')
    run_Dartel(in_t1_file,output_dir,source_image,image_to_write,normalized_image,Parameter); 
end


end


function run_Norm_seg(in_t1_file,output_dir,source_image,normalized_image,image_to_write,Parameter)
    [in_t1_pathstr, in_t1_name, in_t1_ext]=fileparts(in_t1_file);
%     [img2write_pathstr, img2write_name, img2write_ext] =fileparts(image_to_write);
%     [norm_pathstr, norm_name, norm_ext] =fileparts(normalized_image);
    out_core_file=[output_dir filesep 'coreg_' in_t1_name in_t1_ext];
    in3dfile_Coregister(in_t1_file,source_image,out_core_file);
    
    out_seg_file=[output_dir filesep 'coreg_' in_t1_name '_4seg' in_t1_ext];
    in3dfile_segmentation(out_core_file,out_seg_file,Parameter);
    
    mat_file=dir([output_dir filesep '*_seg_sn.mat']);
    mat_file_path=[output_dir filesep mat_file(1).name];
%     normalized_image=[norm_pathstr filesep norm_name img2write_ext];
    
    in3dfile_normalize_seg(image_to_write,normalized_image,mat_file_path,Parameter);  
end



function run_Dartel(in_t1_file,output_dir,source_image,image_to_write,normalized_image,Parameter)

parameters.bb=Parameter.BoundingBox;
parameters.vox=Parameter.VoxSize;
parameters.AffineRegularisation=Parameter.AffineRegularisation;

    [in_t1_pathstr, in_t1_name, in_t1_ext]=fileparts(in_t1_file);
    out_t1_new_segment=[output_dir filesep in_t1_name '_coreg_new_seg' in_t1_ext];
    out_t1_coregister=[output_dir filesep in_t1_name '_coreg' in_t1_ext];
    
in3dfile_Normalize_newsegment_dartel_module...
        (image_to_write,        in_t1_file,          source_image,...
         normalized_image,out_t1_new_segment,out_t1_coregister,...
         parameters);
     
end










