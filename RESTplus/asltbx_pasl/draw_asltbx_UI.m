function h_UI=draw_asltbx_UI(Preprocess_UIlist,h_UI,h_fig,style_string)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    
   for i=1:size(Preprocess_UIlist,2)
       obj_index=['obj_' num2str(i)];    
       [ui_struct]=creat_pipeline_ui_struct(Preprocess_UIlist{i});
       if isfield(ui_struct,'style')
           style_string=ui_struct.style;  
       end
        objlist.(obj_index)=run_pipeline_uicontrol(h_fig,style_string,ui_struct);
        current_obj=objlist.(obj_index);
        current_module_name=ui_struct.module_name;
        if isfield(ui_struct,'module_para')
            current_module_para=ui_struct.module_para;
        else
            current_module_para='';
        end
        h_UI=add_field_2_h_UI(h_UI,style_string,current_obj,current_module_name,current_module_para);       
   end
    
   
   
   
   
end


function h_UI=add_field_2_h_UI(h_UI,style_string,current_obj,current_module_name,current_module_para)

index_h_text____text_edit=1;
index_h_edit____text_edit=2;



if strcmpi(style_string,'text')...
   ||strcmpi(style_string,'checkbox')...
   ||strcmpi(style_string,'radiobutton')...
   ||strcmpi(style_string,'pushbutton')
    h_UI.(current_module_name)=current_obj.h_uicontrol; 
elseif strcmpi(style_string,'text_edit')
    h_UI.(current_module_name{index_h_text____text_edit})=...
                                current_obj.h_uicontrol(index_h_text____text_edit); 
    h_UI.(current_module_name{index_h_edit____text_edit})=...
                                current_obj.h_uicontrol(index_h_edit____text_edit); 
elseif strcmpi(style_string,'text_radiobutton_horiz_line')
    text_h_uicontrol_index=1;
    radiobtn_h_uicontrol_start_index=2;

    h_UI.(current_module_name).h_text.(current_module_para{text_h_uicontrol_index})=...
                               current_obj.h_uicontrol(text_h_uicontrol_index); 
    for i=radiobtn_h_uicontrol_start_index...
          :...
          length(current_obj.h_uicontrol)
    h_UI.(current_module_name).h_radiobtn.(current_module_para{i})=...
          current_obj.h_uicontrol(i);
    end
    
end


end
