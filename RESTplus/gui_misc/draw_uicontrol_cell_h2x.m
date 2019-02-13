function h_uicontrol_struct=draw_uicontrol_cell_h2x(h_fig,ui_property_cell)  
% h2x; height ~20pix
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    ui_property_struct=init_ui_property_struct(ui_property_cell);
    ui_property_struct=redefine_ui_property_struct(ui_property_struct);
    h_uicontrol_struct=draw_ui_property_struct(h_fig,ui_property_struct);
end








function ui_property_struct=init_ui_property_struct(ui_property_cell)
ui_property_struct='';
for i=1:size(ui_property_cell,2)
    for j=1:2:size(ui_property_cell{i},2)
        property_name=ui_property_cell{i}{j};
        property_value=ui_property_cell{i}{j+1};
        ui_property_struct{i}.(property_name)=property_value;
    end    
end
end


function out_ui_property_struct=redefine_ui_property_struct(in_ui_property_struct)
for i=1:length(in_ui_property_struct)
    current_ui_property_struct=in_ui_property_struct{i};
    fieldnames_ui_property_struct=fieldnames(current_ui_property_struct);
    for j=1:length(fieldnames_ui_property_struct)
        current_property_name=fieldnames_ui_property_struct{j};
        current_ui_property_struct=...
                redefine_current_ui_property_struct(current_ui_property_struct,current_property_name);
                           
    end
    out_ui_property_struct{i}=current_ui_property_struct;
end
end



function current_ui_property_struct=...
            redefine_current_ui_property_struct(current_ui_property_struct,current_property_name)
        
d_v=default_value();

if strcmp(current_property_name,'style')...
   &&isfield(current_ui_property_struct,'position_xy')...
   &&(...
      strcmp(current_ui_property_struct.(current_property_name),'radiobutton')...
      ||...
      strcmp(current_ui_property_struct.(current_property_name),'text')...
     )
 
   position_xy=current_ui_property_struct.('position_xy');
   current_ui_property_struct=rmfield(current_ui_property_struct,'position_xy');
   the_string=current_ui_property_struct.('string') ;
   
   radiobutton_width=length(the_string)*d_v.a_font_space+d_v.radiobutton_space;
   radiobutton_height=d_v.radiobutton_height;
   position_array=[position_xy radiobutton_width radiobutton_height];
   current_ui_property_struct.('position')=position_array;     
end 
end



function h_uicontrol_struct=draw_ui_property_struct(h_fig,ui_property_struct)
h_uicontrol_struct='';
for i=1:length(ui_property_struct)
    h_uicontrol_struct=draw_current_ui_property_struct(h_fig,ui_property_struct{i},h_uicontrol_struct);
end

end



function h_uicontrol_struct=draw_current_ui_property_struct(h_fig,a_ui_property_struct,h_uicontrol_struct)
pos='';
d_v=default_value();

evastring=sprintf('uicontrol(h_fig,''fontname'',d_v.fontname,''fontweight'',d_v.fontweight');
% evastring=sprintf('%s,''backgroundcolor'',d_v.default_background_color',evastring);

if ~isfield(a_ui_property_struct,'backgroundcolor')
    evastring=sprintf('%s,''backgroundcolor'',d_v.default_background_color',evastring);    
end


if ~isfield(a_ui_property_struct,'fontsize')
    evastring=sprintf('%s,''fontsize'',d_v.fontsize',evastring);    
end

property_list=fieldnames(a_ui_property_struct);
for i=1:length(property_list)
  the_property_name=property_list{i};
  the_property_value=a_ui_property_struct.(the_property_name);
  
  if strcmp(the_property_name,'position')
     for j=1:length(the_property_value)
         pos{j}=num2str(the_property_value(j));
     end
     evastring=sprintf('%s,''%s'',[%s %s %s %s]',evastring,the_property_name,pos{1},pos{2},pos{3},pos{4});
  elseif strcmp(the_property_name,'fontsize')...
         ||strcmp(the_property_name,'value')
     evastring=sprintf('%s,''%s'',%s',evastring,the_property_name,num2str(the_property_value)); 
  elseif strcmp(the_property_name,'h_name')   
     % do nothing
  elseif strcmp(the_property_name,'backgroundcolor')
     for j=1:length(the_property_value)
         the_color{j}=num2str(the_property_value(j));
     end 
     evastring=sprintf('%s,''%s'',[%s %s %s]',evastring,the_property_name,the_color{1},the_color{2},the_color{3}); 
  elseif ischar(the_property_value)
     evastring=sprintf('%s,''%s'',''%s''',evastring,the_property_name,the_property_value);          
  end
end

evastring=sprintf('%s);',evastring);
name_h_uicontrol=a_ui_property_struct.h_name;
h_uicontrol_struct.(name_h_uicontrol)=eval(evastring);

end


function d_v=default_value()
    d_v.a_font_space=8;
    d_v.fontweight='bold';
    d_v.fontsize=init_fontsize();
    d_v.radiobutton_space=23.5;
    d_v.radiobutton_height=20;
    d_v.fontname='fixedwidth';
    d_v.default_background_color=[240/250,240/250,240/250];
end

function fontsize=init_fontsize()
    TheFontSize.Mac=14;
    TheFontSize.PC=10;
    TheFontSize.Other=10;
    fontsize=restgui_misc('FontsizeCompatibility',TheFontSize);
end








