function handles=init_coordinate_convert_gui(figure_name)
% Written by Jia Xi-ze 150725.
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



figure_property.figure_name=figure_name;
handles=init_figure_600x330(figure_property);
handles=init_UserP_600x330(handles);
handles=init_radiobtn_gui(handles);
init_h_radiobtn_ui_callback(handles);
guidata(gcf,handles);
end



function handles=init_radiobtn_gui(handles)
%0724
ui_property_cell={ {'h_name','h_reorient',...
                    'style','radiobutton',...
                    'position_xy',[25 handles.UserP.line2.y-10],...
                    'string','Reorient',...
                    'tag','tag_reorient'},...
                   {'h_name','h_orig2norm_radiobutton',...
                   'style','radiobutton',...
                   'position_xy',[135 handles.UserP.line2.y-10],...
                   'string','ori-norm',...
                   'tag','tag_orig2norm_radiobutton',...
                   },...
                   {'h_name','h_norm2orig_radiobutton',...
                   'style','radiobutton',...
                   'position_xy',[235 handles.UserP.line2.y-10],...
                   'string','norm-orig',...
                   'tag','tag_norm2orig_radiobutton'},...
                   };


handles.h_radiobtn_ui_struct=draw_uicontrol_cell_h2x(handles.h_fig,ui_property_cell);    
end


function init_h_radiobtn_ui_callback(handles)
h_fieldname_list=fieldnames(handles.h_radiobtn_ui_struct);
for i=1:length(h_fieldname_list)
    set(handles.h_radiobtn_ui_struct.(h_fieldname_list{i}),...
        'callback',{@the_radiobtn_ui_callback,handles.h_radiobtn_ui_struct}); 
end
end


function the_radiobtn_ui_callback(hObject, eventdata,h_radiobtn_ui_struct)
handles=guidata(hObject);

h_radiobutton_list=init_radiobutton_list(h_radiobtn_ui_struct);                
tag_current=get(hObject,'tag');                
                
if strcmp(get(hObject,'style'),'radiobutton')                
   RadioBtnSet(h_radiobutton_list,hObject);
   
   
   close(handles.h_fig);
   
   if strcmp(tag_current,'tag_reorient')
          rp_reorient_gui();
   elseif strcmp(tag_current,'tag_orig2norm_radiobutton')
          orig2norm_gui();
   elseif strcmp(tag_current,'tag_norm2orig_radiobutton')
          norm2orig_gui();
   else    
       error('the_radiobtn_ui_callback');
   end   
end
    
    


end




