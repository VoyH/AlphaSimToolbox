function ref_section_data=get_ref_section_data(handles,brainimage_path)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150727
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;


 [section_direction,section_num]=get_section_info(handles);
 ref_section_data=get_ref_slice_data(brainimage_path,section_direction,section_num);
    
    
end


function ref_slice_data=get_ref_slice_data(brainimage_path,section_direction,ref_slice_num)
    [brainimage_data,brainimage_voxdim,brainimage_header]=read_To3d(brainimage_path);
    if strcmpi(section_direction,'i')
           ref_slice_data=squeeze(brainimage_data(ref_slice_num,:,:));
    elseif strcmpi(section_direction,'j')
           ref_slice_data=squeeze(brainimage_data(:,ref_slice_num,:));
    elseif strcmpi(section_direction,'k')
           ref_slice_data=brainimage_data(:,:,ref_slice_num);
    end

end


function [direction,num]=get_section_info(handles)

if 1==get(handles.h_section_ui_struct.h_i_radiobtn,'value');
    direction='i';
end
if 1==get(handles.h_section_ui_struct.h_j_radiobtn,'value');
    direction='j';
end
if 1==get(handles.h_section_ui_struct.h_k_radiobtn,'value');
    direction='k';
end

num=eval(get(handles.h_section_ui_struct.h_section_edit,'string'));

end


