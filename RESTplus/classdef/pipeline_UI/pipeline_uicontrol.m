classdef pipeline_uicontrol < pipeline_properties_default
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150609
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


properties(SetAccess=private,GetAccess=public)
      h_uicontrol
      string='';
      tag;
end    
    


properties(SetAccess=private,GetAccess=protected)
    pox_x
    pos_y
    pos_height
    pos_width
    
    pos_xy
    pos_xy_width_height
    pos_xy_gap_width
    pos_xy_gap_width_height
    
    
    text_x___text_edit
    text_y___text_edit
    text_width___text_edit
    text_height___text_edit
    edit_x___text_edit
    edit_y___text_edit
    edit_width___text_edit
    edit_height___text_edit
    
    
    
    
    text_x___text_edit_endash_edit
    text_y___text_edit_endash_edit
    text_width___text_edit_endash_edit
    text_height___text_edit_endash_edit
    edit1_x___text_edit_endash_edit
    edit1_y___text_edit_endash_edit
    edit1_width___text_edit_endash_edit
    edit1_height___text_edit_endash_edit
    edit2_x___text_edit_endash_edit
    edit2_y___text_edit_endash_edit
    edit2_width___text_edit_endash_edit
    edit2_height___text_edit_endash_edit
    endash_x___text_edit_endash_edit
    endash_y___text_edit_endash_edit
    
    
    
    text_x___text_listbox
    text_y___text_listbox
    text_width___text_listbox
    text_height___text_listbox
    listbox_x___text_listbox
    listbox_y___text_listbox
    listbox_width___text_listbox
    listbox_height___text_listbox
    
end




properties(Dependent,SetAccess=private,GetAccess=protected)
    pos_vector  
end

properties(Constant)
    %___pos_xy
    x_index___pos_xy=1;
    y_index___pos_xy=2;
    
    %___pos_xy_gap_width
    x_index___pos_xy_gap_width=1
    y_index___pos_xy_gap_width=2
    gap_index___pos_xy_gap_width=3
    width_index___pos_xy_gap_width=4;
    %___pos_xy_width_height
    x_index___pos_xy_width_height=1;
    y_index___pos_xy_width_height=2;
    width_index___pos_xy_width_height=3;
    height_index___pos_xy_width_height=4;
    %___pos_xy_gap_width_height
    x_index___pos_xy_gap_width_height=1;
    y_index___pos_xy_gap_width_height=2;
    gap_index___pos_xy_gap_width_height=3;
    width_index___pos_xy_gap_width_height=4;
    height_index___pos_xy_gap_width_height=5;
    
    %___text_edit
    text_string_index___text_edit=1;
    edit_string_index___text_edit=2;
    
    text_tag_index___text_edit=1;
    edit_tag_index___text_edit=2;    
    
    text_pos_vector_index___text_edit=1;
    edit_pos_vector_index___text_edit=2;
    
    text_h_uicontrol_index___text_edit=1;
    edit_h_uicontrol_index___text_edit=2;
    
    %___text_edit_endash_edit
    text_h_uicontrol_index___text_edit_endash_edit=1;
    edit1_h_uicontrol_index___text_edit_endash_edit=2;
    endash_h_uicontrol_index___text_edit_endash_edit=3;
    edit2_h_uicontrol_index___text_edit_endash_edit=4;

    text_tag_index___text_edit_endash_edit=1;
    edit1_tag_index___text_edit_endash_edit=2;
    endash_tag_index___text_edit_endash_edit=3;
    edit2_tag_index___text_edit_endash_edit=4;    
    
    text_string_index___text_edit_endash_edit=1;
    edit1_string_index___text_edit_endash_edit=2;
    edit2_string_index___text_edit_endash_edit=3;
    
    text_pos_vector_index___text_edit_endash_edit=1;
    edit1_pos_vector_index___text_edit_endash_edit=2;
    endash_pos_vector_index___text_edit_endash_edit=3;
    edit2_pos_vector_index___text_edit_endash_edit=4;
    
    
    %___text_listbox
    text_tag_index___text_listbox=1;
    listbox_tag_index___text_listbox=2;
    
    text_string_index___text_listbox=1;
    listbox_string_index___text_listbox=2;
    
    text_pos_vector_index___text_listbox=1;
    listbox_pos_vector_index___text_listbox=2;
    
    text_h_uicontrol_index___text_listbox=1;
    listbox_h_uicontrol_index___text_listbox=2;
end





methods
   function obj=pipeline_uicontrol(h_figure,stylestr,varargin)
        obj.h_fig=h_figure;
        obj.tag=obj.tag_default; % init default tag string
        obj.style=stylestr;    
        obj.set_default_value();
        obj.set_uicontrol_properties(varargin);
        obj.set_default_tag();
        obj.backgroundcolor=get(gcf,'color');
        obj.calculate_position();
        obj.draw_now();
    end
end




methods (Access=private)    
 
    function set_uicontrol_properties(obj,varargincell)
        for i=1:2:length(varargincell)
            propertyname=varargincell{i};
            propertyvalue=varargincell{i+1};
            obj.(propertyname)=propertyvalue;
        end
    end

    
    function set_default_tag(obj)
        if strcmpi(obj.style,'text')&&strcmpi(obj.tag,obj.tag_default)
           obj.tag=[obj.string '_text']; 
        elseif (~iscell(obj.tag))&&strcmpi(obj.style,'text_edit')&&strcmpi(obj.tag,obj.tag_default)
            set_default_tag___text_edit(obj);
        elseif (~iscell(obj.tag))&&strcmpi(obj.style,'text_edit_endash_edit')&&strcmpi(obj.tag,obj.tag_default)
            set_default_tag_text_edit_endash_edit(obj);
        elseif (~iscell(obj.tag))&&strcmpi(obj.style,'text_listbox')&&strcmpi(obj.tag,obj.tag_default) 
            set_default_tag_text_listbox(obj);
        end
    end
    
    
    function set_default_value(obj)
        obj.value=obj.value_default;
    end
    
    function calculate_position(obj)
        if strcmpi(obj.style,'text')
            calculate_position___text(obj); 
        elseif strcmpi(obj.style,'pushbutton')
            calculate_position___pushbutton(obj); 
        elseif strcmpi(obj.style,'checkbox')
            calculate_position___checkbox(obj);            
        elseif strcmpi(obj.style,'radiobutton')
            calculate_position___radiobutton(obj);
        elseif strcmpi(obj.style,'text_edit') 
            calculate_position___text_edit(obj);            
        elseif strcmpi(obj.style,'text_edit_endash_edit')  
            calculate_position___text_edit_endash_edit(obj);
        elseif strcmpi(obj.style,'text_listbox')
            calculate_position___text_listbox(obj);
        end
    
    end


    

    function draw_now(obj)
        if strcmpi(obj.style,'text_edit')
               draw_text_edit(obj);                 
        elseif strcmpi(obj.style,'text_edit_endash_edit')
               draw_text_edit_endash_edit(obj);  
        elseif strcmpi(obj.style,'text_listbox')
               draw_text_listbox(obj);
        else
               draw_default_uicontrol(obj);
        end
    end
    
    
    
    
    
end


methods             
        function pos_vector=get.pos_vector(obj)
            if strcmpi(obj.style,'text_edit')
               pos_vector=get_pos_vector___text_edit(obj);      
            elseif strcmpi(obj.style,'text_edit_endash_edit')
               pos_vector=get_pos_vector___text_edit_endash_edit(obj); 
            elseif strcmpi(obj.style,'text_listbox')
               pos_vector=get_pos_vector___text_listbox(obj);                 
            else
               pos_vector=[obj.pox_x,obj.pos_y,obj.pos_width,obj.pos_height]; 
            end
        end       
end


end
    
    








%-----------------------------------------------------------------------
%-----------------------------------------------------------------------
%-----------------------------------------------------------------------


function set_default_tag___text_edit(obj)
   obj.tag='';
   obj.tag{obj.text_tag_index___text_edit}=obj.tag_default;
   obj.tag{obj.edit_tag_index___text_edit}=obj.tag_default;
end

function set_default_tag_text_edit_endash_edit(obj)
   obj.tag='';
   obj.tag{obj.text_tag_index___text_edit_endash_edit}=obj.tag_default;
   obj.tag{obj.edit1_tag_index___text_edit_endash_edit}=obj.tag_default;
   obj.tag{obj.endash_tag_index___text_edit_endash_edit}=obj.tag_default;
   obj.tag{obj.edit2_tag_index___text_edit_endash_edit}=obj.tag_default;
end

function set_default_tag_text_listbox(obj)
   obj.tag='';
   obj.tag{obj.text_tag_index___text_listbox}=obj.tag_default;
   obj.tag{obj.listbox_tag_index___text_listbox}=obj.tag_default;
   
end

 
function calculate_position___text(obj)
    obj.pox_x=obj.pos_xy(obj.x_index___pos_xy);
    obj.pos_y=obj.pos_xy(obj.y_index___pos_xy);
    obj.pos_width=length(obj.string)*obj.afontwidth;
    obj.pos_height=obj.text_pos_height;
end

function calculate_position___pushbutton(obj)
    obj.pox_x=obj.pos_xy_width_height(obj.x_index___pos_xy_width_height);
    obj.pos_y=obj.pos_xy_width_height(obj.y_index___pos_xy_width_height);
    obj.pos_width=obj.pos_xy_width_height(obj.width_index___pos_xy_width_height);
    obj.pos_height=obj.pos_xy_width_height(obj.height_index___pos_xy_width_height);    
end
    
function calculate_position___checkbox(obj)
    obj.pox_x=obj.pos_xy(obj.x_index___pos_xy);
    obj.pos_y=obj.pos_xy(obj.y_index___pos_xy);
    obj.pos_width=obj.checkbox_ico_width+length(obj.string)*obj.afontwidth;
    obj.pos_height=obj.checkbox_pos_height;
end


function calculate_position___radiobutton(obj)
    obj.pox_x=obj.pos_xy(obj.x_index___pos_xy);
    obj.pos_y=obj.pos_xy(obj.y_index___pos_xy);
    obj.pos_width=obj.radiobutton_ico_width+length(obj.string)*obj.afontwidth;
    obj.pos_height=obj.radiobutton_pos_height;
end


function calculate_position___text_edit(obj)
    obj.text_x___text_edit=obj.pos_xy_gap_width(obj.x_index___pos_xy_gap_width);
    obj.text_y___text_edit=obj.pos_xy_gap_width(obj.y_index___pos_xy_gap_width)-obj.text_edit_diff;
    obj.text_width___text_edit=length(obj.string{obj.text_string_index___text_edit})...
                               *obj.afontwidth;
    obj.text_height___text_edit=obj.text_pos_height;

    obj.edit_x___text_edit=obj.text_x___text_edit...
                           +obj.pos_xy_gap_width(obj.gap_index___pos_xy_gap_width)...
                           +obj.text_width___text_edit;
    obj.edit_y___text_edit=obj.pos_xy_gap_width(obj.y_index___pos_xy_gap_width);
    obj.edit_width___text_edit=obj.pos_xy_gap_width(obj.width_index___pos_xy_gap_width)...
                              -obj.text_width___text_edit...
                              -obj.pos_xy_gap_width(obj.gap_index___pos_xy_gap_width);
    obj.edit_height___text_edit=obj.edit_pos_height;
end


function calculate_position___text_edit_endash_edit(obj)
   obj.text_x___text_edit_endash_edit=obj.pos_xy_gap_width(obj.x_index___pos_xy_gap_width);
   obj.text_y___text_edit_endash_edit=obj.pos_xy_gap_width(obj.y_index___pos_xy_gap_width)...
                                      -obj.text_edit_diff;
   obj.text_width___text_edit_endash_edit=length(obj.string{obj.text_string_index___text_edit_endash_edit})...
                                          *obj.afontwidth;
   obj.text_height___text_edit_endash_edit=obj.text_pos_height;

   obj.edit1_x___text_edit_endash_edit=obj.text_x___text_edit_endash_edit...
                                       +obj.text_width___text_edit_endash_edit...
                                       +obj.pos_xy_gap_width(obj.gap_index___pos_xy_gap_width);
   obj.edit1_y___text_edit_endash_edit=obj.pos_xy_gap_width(obj.y_index___pos_xy_gap_width);
   obj.edit1_width___text_edit_endash_edit=obj.pos_xy_gap_width(obj.width_index___pos_xy_gap_width);
   obj.edit1_height___text_edit_endash_edit=obj.edit_pos_height;

   obj.endash_x___text_edit_endash_edit=obj.edit1_x___text_edit_endash_edit...
                                        +obj.edit1_width___text_edit_endash_edit...
                                        +obj.endash_gap;
   obj.endash_y___text_edit_endash_edit=obj.pos_xy_gap_width(obj.y_index___pos_xy_gap_width)...
                                        -obj.text_edit_diff;
   %obj.endash_width is constant
   %obj.obj.endash_height is constant

   obj.edit2_x___text_edit_endash_edit=obj.endash_x___text_edit_endash_edit...
                                      +obj.endash_width...
                                      +obj.endash_gap;
   obj.edit2_y___text_edit_endash_edit=obj.pos_xy_gap_width(obj.y_index___pos_xy_gap_width);
   obj.edit2_width___text_edit_endash_edit=obj.pos_xy_gap_width(obj.width_index___pos_xy_gap_width);
   obj.edit2_height___text_edit_endash_edit=obj.edit_pos_height;
end
    


function calculate_position___text_listbox(obj)

    
    obj.listbox_x___text_listbox=obj.pos_xy_gap_width_height(obj.x_index___pos_xy_gap_width_height);
    obj.listbox_y___text_listbox=obj.pos_xy_gap_width_height(obj.y_index___pos_xy_gap_width_height);
    obj.listbox_width___text_listbox=obj.pos_xy_gap_width_height(obj.width_index___pos_xy_gap_width_height);
    obj.listbox_height___text_listbox=obj.pos_xy_gap_width_height(obj.height_index___pos_xy_gap_width_height)...
                                      -obj.pos_xy_gap_width_height(obj.gap_index___pos_xy_gap_width_height)...
                                      -obj.text_pos_height;
    
    
    obj.text_width___text_listbox=length(obj.string{obj.text_string_index___text_listbox})...
                                  *obj.afontwidth;
    obj.text_height___text_listbox=obj.text_pos_height; 
    obj.text_y___text_listbox=obj.listbox_y___text_listbox...
                              +obj.listbox_height___text_listbox...
                              +obj.pos_xy_gap_width_height(obj.gap_index___pos_xy_gap_width_height);
    obj.text_x___text_listbox=obj.pos_xy_gap_width_height(obj.x_index___pos_xy_gap_width_height)...
                              + ...
                              ( ...
                              obj.pos_xy_gap_width_height(obj.width_index___pos_xy_gap_width_height)/2 ...
                              - ...
                              obj.text_width___text_listbox/2 ...
                              );    
end



function draw_text_edit(obj)
          text_obj_pipeline_default_uicontrol=pipeline_default_uicontrol(obj.h_fig,...
                                                    'style','text',...
                                                    'tag',obj.tag{obj.text_tag_index___text_edit},...
                                                    'string',obj.string{obj.text_string_index___text_edit},...
                                                    'visible',obj.visible,...
                                                    'enable',obj.enable,...
                                                    'position',obj.pos_vector{obj.text_pos_vector_index___text_edit},...
                                                    'horizontalalignment','left',...
                                                    'backgroundcolor',obj.backgroundcolor,...
                                                    'value',obj.value ...
                                                    );
         obj.h_uicontrol(obj.text_h_uicontrol_index___text_edit)=text_obj_pipeline_default_uicontrol.h_uicontrol;
         
         
         
         edit_obj_pipeline_default_uicontrol=pipeline_default_uicontrol(obj.h_fig,...
                                                    'style','edit',...
                                                    'tag',obj.tag{obj.edit_tag_index___text_edit},...
                                                    'string',obj.string{obj.edit_string_index___text_edit},...
                                                    'visible',obj.visible,...
                                                    'enable',obj.enable,...
                                                    'position',obj.pos_vector{obj.edit_pos_vector_index___text_edit},...
                                                    'backgroundcolor',obj.edit_backgroundcolor,...
                                                    'value',obj.value ...
                                                    );
         obj.h_uicontrol(obj.edit_h_uicontrol_index___text_edit)=edit_obj_pipeline_default_uicontrol.h_uicontrol;
end







function draw_text_edit_endash_edit(obj)
  text_obj_pipeline_default_uicontrol=...
           pipeline_default_uicontrol(obj.h_fig,...
                                    'style','text',...
                                    'tag',obj.tag{obj.text_tag_index___text_edit_endash_edit},...
                                    'string',obj.string{obj.text_string_index___text_edit_endash_edit},...
                                    'visible',obj.visible,...
                                    'position',obj.pos_vector{obj.text_pos_vector_index___text_edit_endash_edit},...
                                    'backgroundcolor',obj.backgroundcolor,...
                                    'value',obj.value ...
                                     );
 obj.h_uicontrol(obj.text_h_uicontrol_index___text_edit_endash_edit)=...
                                                text_obj_pipeline_default_uicontrol.h_uicontrol;
         
         
          
 edit1_obj_pipeline_default_uicontrol=...
           pipeline_default_uicontrol(obj.h_fig,...
                                    'style','edit',...
                                    'tag',obj.tag{obj.edit1_tag_index___text_edit_endash_edit},...
                                    'string',obj.string{obj.edit1_string_index___text_edit_endash_edit},...
                                    'visible',obj.visible,...
                                    'position',obj.pos_vector{obj.edit1_pos_vector_index___text_edit_endash_edit},...
                                    'backgroundcolor',obj.edit_backgroundcolor,...
                                    'value',obj.value ...
                                     );
 obj.h_uicontrol(obj.edit1_h_uicontrol_index___text_edit_endash_edit)=...
                                                 edit1_obj_pipeline_default_uicontrol.h_uicontrol;
         
                                                             
 endash_obj_pipeline_default_uicontrol=...
           pipeline_default_uicontrol(obj.h_fig,...
                                    'style','text',...
                                    'tag',obj.tag{obj.endash_tag_index___text_edit_endash_edit},...
                                    'string',obj.endash_string,...
                                    'visible',obj.visible,...
                                    'position',obj.pos_vector{obj.endash_pos_vector_index___text_edit_endash_edit},...
                                    'backgroundcolor',obj.backgroundcolor,...
                                    'value',obj.value ...
                                     );
 obj.h_uicontrol(obj.endash_h_uicontrol_index___text_edit_endash_edit)=...
                                                 endash_obj_pipeline_default_uicontrol.h_uicontrol;
         
 
         
 edit2_obj_pipeline_default_uicontrol=...
           pipeline_default_uicontrol(obj.h_fig,...
                                    'style','edit',...
                                    'tag',obj.tag{obj.edit2_tag_index___text_edit_endash_edit},...
                                    'string',obj.string{obj.edit2_string_index___text_edit_endash_edit},...
                                    'visible',obj.visible,...
                                    'backgroundcolor',obj.edit_backgroundcolor,...
                                    'position',obj.pos_vector{obj.edit2_pos_vector_index___text_edit_endash_edit},...
                                    'value',obj.value ...
                                     );
 obj.h_uicontrol(obj.edit2_h_uicontrol_index___text_edit_endash_edit)=...
                                                edit2_obj_pipeline_default_uicontrol.h_uicontrol;
end



function draw_text_listbox(obj)
 text_obj_pipeline_default_uicontrol=...
           pipeline_default_uicontrol(obj.h_fig,...
                                    'style','text',...
                                    'tag',obj.tag{obj.text_tag_index___text_listbox},...
                                    'string',obj.string{obj.text_string_index___text_listbox},...
                                    'visible',obj.visible,...
                                    'position',obj.pos_vector{obj.text_pos_vector_index___text_listbox},...
                                    'backgroundcolor',obj.backgroundcolor...
                                     );
 obj.h_uicontrol(obj.text_h_uicontrol_index___text_listbox)=...
                                                text_obj_pipeline_default_uicontrol.h_uicontrol;
 
  listbox_obj_pipeline_default_uicontrol=...
           pipeline_default_uicontrol(obj.h_fig,...
                                    'style','listbox',...
                                    'tag',obj.tag{obj.listbox_tag_index___text_listbox},...
                                    'string',obj.string{obj.listbox_string_index___text_listbox},...
                                    'visible',obj.visible,...
                                    'position',obj.pos_vector{obj.listbox_pos_vector_index___text_listbox},...
                                    'value',obj.listbox_value_default,...
                                    'fontsize',obj.fontsize,...
                                    'backgroundcolor',obj.listbox_backgroundcolor_default...
                                     );
 obj.h_uicontrol(obj.listbox_h_uicontrol_index___text_listbox)=...
                                                listbox_obj_pipeline_default_uicontrol.h_uicontrol;                                           
end



function draw_default_uicontrol(obj)

 default_uicontrol_obj_pipeline_default_uicontrol=...
           pipeline_default_uicontrol(obj.h_fig,...
                                    'style',obj.style,...
                                    'tag',obj.tag,...
                                    'string',obj.string,...
                                    'visible',obj.visible,...
                                    'position',obj.pos_vector,...
                                    'backgroundcolor',obj.backgroundcolor,...
                                    'enable',obj.enable,...
                                    'value',obj.value ...
                                     );
 obj.h_uicontrol=default_uicontrol_obj_pipeline_default_uicontrol.h_uicontrol;
                                
end


function pos_vector=get_pos_vector___text_edit(obj)
       pos_vector{obj.text_pos_vector_index___text_edit}=[obj.text_x___text_edit,...
                                                          obj.text_y___text_edit,...
                                                          obj.text_width___text_edit,...
                                                          obj.text_height___text_edit];
       pos_vector{obj.edit_pos_vector_index___text_edit}=[obj.edit_x___text_edit,...
                                                          obj.edit_y___text_edit,...
                                                          obj.edit_width___text_edit,...
                                                          obj.edit_height___text_edit];
end


function pos_vector=get_pos_vector___text_edit_endash_edit(obj)
       pos_vector{obj.text_pos_vector_index___text_edit_endash_edit}=...
                  [obj.text_x___text_edit_endash_edit,...
                   obj.text_y___text_edit_endash_edit,...
                   obj.text_width___text_edit_endash_edit,...
                   obj.text_height___text_edit_endash_edit];

       pos_vector{obj.edit1_pos_vector_index___text_edit_endash_edit}=...
                  [obj.edit1_x___text_edit_endash_edit,...
                   obj.edit1_y___text_edit_endash_edit,...
                   obj.edit1_width___text_edit_endash_edit,...
                   obj.edit1_height___text_edit_endash_edit];

       pos_vector{obj.endash_pos_vector_index___text_edit_endash_edit}=...
                  [obj.endash_x___text_edit_endash_edit,...
                   obj.endash_y___text_edit_endash_edit,...
                   obj.endash_width,...
                   obj.endash_height];

       pos_vector{obj.edit2_pos_vector_index___text_edit_endash_edit}=...
                  [obj.edit2_x___text_edit_endash_edit,...
                   obj.edit2_y___text_edit_endash_edit,...
                   obj.edit2_width___text_edit_endash_edit,...
                   obj.edit2_height___text_edit_endash_edit];
end


function pos_vector=get_pos_vector___text_listbox(obj)
    pos_vector{obj.text_pos_vector_index___text_listbox}= ...
              [obj.text_x___text_listbox,...
               obj.text_y___text_listbox,...
               obj.text_width___text_listbox,...
               obj.text_height___text_listbox];
           
    pos_vector{obj.listbox_pos_vector_index___text_listbox}=...
              [obj.listbox_x___text_listbox,...
               obj.listbox_y___text_listbox,...
               obj.listbox_width___text_listbox,...
               obj.listbox_height___text_listbox];
    
end

