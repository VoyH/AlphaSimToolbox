classdef pipeline_text_radiobutton < pipeline_properties_default
%-----------------------------------------------------------
%   Copyright(c) 20150714
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


properties(SetAccess=private,GetAccess=public)
      h_uicontrol
end    
    
properties(SetAccess=private,GetAccess=protected)
    tag;
    string=''
    radiobutton_amount
end


properties(SetAccess=private,GetAccess=protected)    
    pos_x_y_gap1_gap2
    
    text_x___text_radiobutton_horiz_line
    text_y___text_radiobutton_horiz_line
    text_width___text_radiobutton_horiz_line
    text_height___text_radiobutton_horiz_line
    radiobutton_x_list___text_radiobutton_horiz_line
    radiobutton_y_list___text_radiobutton_horiz_line
    radiobutton_width_list___text_radiobutton_horiz_line
    radiobutton_height_list___text_radiobutton_horiz_line
    
end

properties(Dependent,SetAccess=private,GetAccess=protected)
    pos_vector  
end

properties(Constant)
    text_tag_index____text_radiobutton_horiz_line=1
    radiobutton_tag_start_index___text_radiobutton_horiz_line=2
    
    
    x_index___pos_x_y_gap1_gap2=1
    y_index___pos_x_y_gap1_gap2=2
    gap1_index___pos_x_y_gap1_gap2=3
    gap2_index___pos_x_y_gap1_gap2=4
    
    text_string_index___text_radiobutton_horiz_line=1
    radiobtn_str_index_start___text_radiobutton_horiz_line=2
    
    
    text_pos_vector_index___text_radiobutton_horiz_line=1
    radiobtn_pos_vector_start_index___text_radiobutton_horiz_line=2
    
    
    
    text_h_uicontrol_index___text_radiobutton_horiz_line=1
    radiobtn_h_uicontrol_start_index___text_radiobutton_horiz_line=2

    
end


methods
    function obj= pipeline_text_radiobutton(h_figure,stylestr,varargin)
        obj.h_fig=h_figure;
        obj.tag=obj.tag_default; % init default tag string
        obj.style=stylestr;        
        obj.set_uicontrol_properties(varargin); 
        obj.radiobutton_amount=length(obj.string)-1;
        obj.set_default_tag();
        obj.init_value()
        obj.backgroundcolor=get(gcf,'color');
        obj.horizontalalignment='left';
        obj.calculate_position();
        obj.draw_now();
        
    end
    
    function set_uicontrol_properties(obj,varargincell)
        for i=1:2:length(varargincell)
            propertyname=varargincell{i};
            propertyvalue=varargincell{i+1};
            obj.(propertyname)=propertyvalue;
        end
        
    end
    
    
    
    
    function set_default_tag(obj)
        if (~iscell(obj.tag))...
           &&...
           strcmpi(obj.style,'text_radiobutton_horiz_line')...
           &&...
           strcmpi(obj.tag,obj.tag_default)
       
           set_default_tag___text_radiobutton_horiz_line(obj);
        end
    end
    
    
    function init_value(obj)
        
        if (~iscell(obj.value))...
           &&(isempty(obj.value))...
           &&strcmpi(obj.style,'text_radiobutton_horiz_line')
       
           set_default_value___text_radiobutton_horiz_line(obj);
        end
           
            
    end
    
    
     function calculate_position(obj)
        if strcmpi(obj.style,'text_radiobutton_horiz_line')
            calculate_position___text_radiobutton_horiz_line(obj); 
        end
     end
    
    function draw_now(obj)
        if strcmpi(obj.style,'text_radiobutton_horiz_line')
               draw_text_radiobutton_horiz_line(obj);                 
        end
    end
    
    

end



methods             
        function pos_vector=get.pos_vector(obj)
            if strcmpi(obj.style,'text_radiobutton_horiz_line')
               pos_vector=get_pos_vector___text_radiobutton_horiz_line(obj);      
            end
        end       
end



end



function set_default_tag___text_radiobutton_horiz_line(obj)
   obj.tag='';
   obj.tag{obj.text_tag_index____text_radiobutton_horiz_line}=obj.tag_default;

   for i=obj.radiobutton_tag_start_index___text_radiobutton_horiz_line...
         :...
         (obj.radiobutton_amount+1)
         obj.tag{i}=obj.tag_default;
   end
end


function set_default_value___text_radiobutton_horiz_line(obj)
   obj.value='';

   for i=1:(obj.radiobutton_amount+1)
         obj.value{i}=obj.value_default;
   end
   
end



function calculate_position___text_radiobutton_horiz_line(obj)   

obj.text_x___text_radiobutton_horiz_line=...
                            obj.pos_x_y_gap1_gap2(obj.x_index___pos_x_y_gap1_gap2);
obj.text_y___text_radiobutton_horiz_line=...
                            obj.pos_x_y_gap1_gap2(obj.y_index___pos_x_y_gap1_gap2)...
                            -...
                            obj.text_radiobtn_diff;
obj.text_width___text_radiobutton_horiz_line=...
                              length(obj.string{obj.text_string_index___text_radiobutton_horiz_line})...
                              *obj.afontwidth;
obj.text_height___text_radiobutton_horiz_line=obj.text_pos_height;


for i=obj.radiobtn_str_index_start___text_radiobutton_horiz_line:(obj.radiobutton_amount+1)
    
    if i==obj.radiobtn_str_index_start___text_radiobutton_horiz_line %the first radiobutton using gap1
    obj.radiobutton_x_list___text_radiobutton_horiz_line{i}=...
            obj.text_x___text_radiobutton_horiz_line...
            +...
            obj.text_width___text_radiobutton_horiz_line...
            +...
            obj.pos_x_y_gap1_gap2(obj.gap1_index___pos_x_y_gap1_gap2);
    end

    
    
    if i>obj.radiobtn_str_index_start___text_radiobutton_horiz_line % after second radiobutton using gap2
        obj.radiobutton_x_list___text_radiobutton_horiz_line{i}=...
            obj.radiobutton_x_list___text_radiobutton_horiz_line{i-1}...
            +...
            obj.radiobutton_width_list___text_radiobutton_horiz_line{i-1}...
            +...
            obj.pos_x_y_gap1_gap2(obj.gap2_index___pos_x_y_gap1_gap2);
    end
      
    
   obj.radiobutton_y_list___text_radiobutton_horiz_line{i}=...
           obj.pos_x_y_gap1_gap2(obj.y_index___pos_x_y_gap1_gap2);
       
   obj.radiobutton_width_list___text_radiobutton_horiz_line{i}=...
           obj.radiobutton_ico_width...
           +...
               length(obj.string{i})...
                *...
                obj.afontwidth;
       
   obj.radiobutton_height_list___text_radiobutton_horiz_line{i}=...
       obj.radiobutton_pos_height;

end
end




function draw_text_radiobutton_horiz_line(obj)

    

      text_obj_pipeline_default_uicontrol=pipeline_default_uicontrol(obj.h_fig,...
                            'style','text',...
                            'tag',obj.tag{obj.text_tag_index____text_radiobutton_horiz_line},...
                            'string',obj.string{obj.text_string_index___text_radiobutton_horiz_line},...
                            'visible',obj.visible,...
                            'position',obj.pos_vector{obj.text_pos_vector_index___text_radiobutton_horiz_line},...
                            'backgroundcolor',obj.backgroundcolor,...
                            'horizontalalignment',obj.horizontalalignment,...
                            'enable',obj.enable,...
                            'value',obj.value{1} ...
                                                );
     obj.h_uicontrol(obj.text_h_uicontrol_index___text_radiobutton_horiz_line)=...
                            text_obj_pipeline_default_uicontrol.h_uicontrol;
         
                        
     % loop for radiobutton h_uicontrol                   
     for i=obj.radiobtn_h_uicontrol_start_index___text_radiobutton_horiz_line:(obj.radiobutton_amount+1)

         radiobtn_uicontrol_obj_pipeline_default_uicontrol=...
                   pipeline_default_uicontrol(obj.h_fig,...
                                            'style','radiobutton',...
                                            'tag',obj.tag{i},...
                                            'string',obj.string{i},...
                                            'visible',obj.visible,...
                                            'position',obj.pos_vector{i},...
                                            'backgroundcolor',obj.backgroundcolor,...
                                            'horizontalalignment',obj.horizontalalignment,...
                                            'enable',obj.enable,...
                                            'value',obj.value{i} ...
                                             );
         obj.h_uicontrol(i)=radiobtn_uicontrol_obj_pipeline_default_uicontrol.h_uicontrol;
     end

end



function pos_vector=get_pos_vector___text_radiobutton_horiz_line(obj)

    
pos_vector{obj.text_pos_vector_index___text_radiobutton_horiz_line}...
      =...
        [obj.text_x___text_radiobutton_horiz_line,...
         obj.text_y___text_radiobutton_horiz_line,...
         obj.text_width___text_radiobutton_horiz_line,...
         obj.text_height___text_radiobutton_horiz_line];
     
     
for i=obj.radiobtn_pos_vector_start_index___text_radiobutton_horiz_line:obj.radiobutton_amount+1
    pos_vector{i}=...
        [obj.radiobutton_x_list___text_radiobutton_horiz_line{i},...
         obj.radiobutton_y_list___text_radiobutton_horiz_line{i},...
         obj.radiobutton_width_list___text_radiobutton_horiz_line{i},...
         obj.radiobutton_height_list___text_radiobutton_horiz_line{i}];
end
    

end










