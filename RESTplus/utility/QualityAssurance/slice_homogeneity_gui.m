function slice_homogeneity_gui()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150726
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles=init_quality_assurance_gui();
set(handles.h_fig,'visible','on');
set(handles.h_radiobtn_ui_struct.h_slice_homogeneity_radiobutton,'value',1);
handles=init_ui_input_image_edit_box(handles);
handles=init_uicontrol(handles);
handles=h_29_section_module(handles,40,handles.UserP.line6.y);
init_callback(handles);

guidata(gcf,handles);

end



function handles=init_ui_input_image_edit_box(handles)
%input image
[handles.h_eidt_input_image,handles.obj_input_image]=...
         image_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line5.y,450],...
                                      'Input brain image:','');
                                  
% Rectangle size                                   
[handles.h_edit_rect_roi_pos,handles.obj_rect_roi_pos]=...
         h_29_text_edit_pushbtnoff(handles.h_fig,[55,handles.UserP.line7.y,270],...
                                   'Rectangle size:','[150 20]'); 
                               
%output directory
[handles.h_eidt_output_directory,handles.obj_output_directory]=...
         dir_h_29_text_edit_pushbtn(handles.h_fig,[55,handles.UserP.line8.y,450],...
                                      'Output directory:','');                               
end

function handles=init_uicontrol(handles)
ui_property_cell={ {'h_name','h_run_pushbtn',...
                    'tag','tag_run_pushbtn',...
                    'style','pushbutton',...
                    'position',[210 handles.UserP.line10.y-20 340 40],...
                    'string','Set ROI and calculate slice homogeneity'},...
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
         callback_run_pushbtn(handles);
end
set(hObject,'enable','on');


end


function callback_run_pushbtn(handles)
    [h_figure_roi,ref_section_data,rect_pos,brainimage_path]=init_callback_run_pushbtn(handles);
    imrect_mask=get_2d_ROI_mask(h_figure_roi,ref_section_data,rect_pos);
    the_3d_ROI_mask=make_3d_ROI_mask(handles,imrect_mask);   
    
    [slice_homogeneity_data]=claculate_slice_homogeneity(brainimage_path,the_3d_ROI_mask,handles);
end

function [h_figure_roi,ref_section_data,rect_pos,brainimage_path]=init_callback_run_pushbtn(handles)
    brainimage_path=get(handles.h_eidt_input_image,'string');
    fprintf('input: %s\n',brainimage_path);
    ref_section_data=get_ref_section_data(handles,brainimage_path);
    [rect_pos]=get_roi_pos(handles);
    h_figure_roi=figure;

end

function [rect_pos]=get_roi_pos(handles)
rect_pos_num=eval(get(handles.h_edit_rect_roi_pos,'string'));
rect_pos=[35,30,rect_pos_num(1),rect_pos_num(2)];
end

function [imrect_mask]=get_2d_ROI_mask(h_figure_roi,ref_section_data,rect_pos)

ref_section_data=imrotate(ref_section_data,90);   
imshow_h=show_the_image(h_figure_roi,ref_section_data);
uiwait(msgbox('please select the ROI','ROI selection','help'));

imrect_mask=draw_roi(h_figure_roi,imshow_h,rect_pos);
imrect_mask=imrotate(imrect_mask,-90);   

close(h_figure_roi);
end


function the_3d_ROI_mask=make_3d_ROI_mask(handles,imrect_mask)

    brainimage_path=get(handles.h_eidt_input_image,'string');
    output_directory=get(handles.h_eidt_output_directory,'string');
    [pathstr, name, ext]=fileparts(brainimage_path);
    
    [in_image_data,VoxDim,Header]=read_To3d(brainimage_path);
    the_3d_ROI_mask=zeros(size(in_image_data));

    
    if 1==get(handles.h_section_ui_struct.h_i_radiobtn,'value');
        for i=1:size(in_image_data,1)
            the_3d_ROI_mask(i,:,:)=imrect_mask;
        end
    elseif 1==get(handles.h_section_ui_struct.h_j_radiobtn,'value');
        for i=1:size(in_image_data,2)
            for j=1:size(in_image_data,3)
                the_3d_ROI_mask(:,i,j)=imrect_mask(:,j);
            end
        end
    elseif 1==get(handles.h_section_ui_struct.h_k_radiobtn,'value');
        for i=1:size(in_image_data,3)
            the_3d_ROI_mask(:,:,i)=imrect_mask;
        end
    end
    
    display_mask=in_image_data;
    display_mask(logical(the_3d_ROI_mask))=0;
    
    image_data_within_mask=zeros(size(in_image_data));
    image_data_within_mask(logical(the_3d_ROI_mask))=in_image_data(logical(the_3d_ROI_mask));

    
    write_To3dNifti(display_mask,[output_directory filesep name '_mask_in_brain.nii'],size(the_3d_ROI_mask),VoxDim,Header,'single');
    write_To3dNifti(the_3d_ROI_mask,[output_directory filesep name '_mask.nii'],size(the_3d_ROI_mask),VoxDim,Header,'single');
    write_To3dNifti(image_data_within_mask,[output_directory filesep name '_within_mask.nii'],size(the_3d_ROI_mask),VoxDim,Header,'single');


    
end

function h_imshow=show_the_image(figure_h,slice_data)
figure(figure_h);
h_imshow=imshow(slice_data,[],'InitialMagnification','fit');
end


function imrect_mask=draw_roi(figure_h,h_imshow,roi_pos)

figure(figure_h);
h_rect=imrect(gca, roi_pos);
wait(h_rect);
imrect_mask=h_rect.createMask(h_imshow);     
end





function [slice_homogeneity_data]=claculate_slice_homogeneity(brainimage_path,the_3d_ROI_mask,handles)
fprintf('\nrunning slice homogeneity...\n');

[in_image_data,VoxDim,Header]=read_To3d(brainimage_path);
[dim_x,dim_y,slice_number]=size(in_image_data);


zind=1;
for i=1:size(the_3d_ROI_mask,3)
    [row,col]=find(the_3d_ROI_mask(:,:,i));
    if ~isempty(row)
        new_data(1:max(row)-min(row)+1,1:max(col)-min(col)+1,zind)...
            =in_image_data(min(row):max(row),min(col):max(col),i);
        zind=zind+1;
    end
end


zind=zind-1;

if 1==mod(zind,2) %odd
   zind=zind-1; 
end

odd_slice_array=1:2:zind;
even_slice_array=2:2:zind;

diff_image_data=double(new_data(:,:,odd_slice_array))-double(new_data(:,:,even_slice_array));

average_diff=mean(diff_image_data,3);
average_in_image_data=mean(new_data,3);
slice_homogeneity_data=average_diff./average_in_image_data;
 
 brainimage_path=get(handles.h_eidt_input_image,'string');
 output_directory=get(handles.h_eidt_output_directory,'string');
 [pathstr, name, ext]=fileparts(brainimage_path);
 slice_homogeneity_dcm_path=[output_directory filesep 'slice_homogeneity_' name '.dcm'];
 slice_homogeneity_tif_path=[output_directory filesep 'slice_homogeneity_' name '.tiff'];

  
 figure_h=figure;
 show_the_image(figure_h,slice_homogeneity_data);
 saveas(figure_h,slice_homogeneity_tif_path,'tif');
 dicomwrite(slice_homogeneity_data,slice_homogeneity_dcm_path);
     

end


