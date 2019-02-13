function UIhandles=draw_pipeline_UI(Preprocess_UIlist,UIhandles,h_fig,style_string)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

text_h_uicontrol=1;
edit_h_uicontrol=2;
    

text_h_uicontrol_text_edit_endash_edit=1;
edit1_h_uicontrol_text_edit_endash_edit=2;
endash_h_uicontrol_text_edit_endash_edit=3;
edit2_h_uicontrol_text_edit_endash_edit=4;

text_h_uicontrol_index___text_listbox=1;
listbox_h_uicontrol_index___text_listbox=2;
                 
for i=1:size(Preprocess_UIlist,2)
    obj_index=['obj_' num2str(i)];
    [ui_struct]=creat_pipeline_ui_struct(Preprocess_UIlist{i});   
    
    if isfield(ui_struct,'style')
       style_string=ui_struct.style;  
    end
    
    
    objlist.(obj_index)=run_pipeline_uicontrol(h_fig,style_string,ui_struct);

    

    if isfield(ui_struct,'module_para')&&((strcmpi(style_string,'text')||...
                                          strcmpi(style_string,'checkbox')||...
                                          strcmpi(style_string,'radiobutton'))||...
                                          strcmpi(style_string,'pushbutton'))
        UIhandles.(ui_struct.module_name).(ui_struct.module_para)=objlist.(obj_index).h_uicontrol;
           
    elseif (~isfield(ui_struct,'module_para'))&&((strcmpi(style_string,'text')||...
                                                 strcmpi(style_string,'checkbox')||...
                                                 strcmpi(style_string,'radiobutton'))||...
                                                 strcmpi(style_string,'pushbutton'))
        UIhandles.(ui_struct.module_name).handle=objlist.(obj_index).h_uicontrol; 
        
    elseif isfield(ui_struct,'module_para')&&strcmpi(style_string,'text_edit')
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{text_h_uicontrol})=...
                                                            objlist.(obj_index).h_uicontrol(text_h_uicontrol);
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{edit_h_uicontrol})=...
                                                            objlist.(obj_index).h_uicontrol(edit_h_uicontrol);
        
    elseif (~isfield(ui_struct,'module_para'))&&strcmpi(style_string,'text_edit')
        UIhandles.(ui_struct.module_name{text_h_uicontrol}).handle=...
                                                 objlist.(obj_index).h_uicontrol(text_h_uicontrol); 
        UIhandles.(ui_struct.module_name{edit_h_uicontrol}).handle=...
                                                 objlist.(obj_index).h_uicontrol(edit_h_uicontrol); 
    elseif isfield(ui_struct,'module_para')&&strcmpi(style_string,'text_edit_endash_edit')
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{text_h_uicontrol_text_edit_endash_edit})=...
                                objlist.(obj_index).h_uicontrol(text_h_uicontrol_text_edit_endash_edit);
                            
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{edit1_h_uicontrol_text_edit_endash_edit})=...
                                objlist.(obj_index).h_uicontrol(edit1_h_uicontrol_text_edit_endash_edit);
                                                       
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{endash_h_uicontrol_text_edit_endash_edit})=...
                                objlist.(obj_index).h_uicontrol(endash_h_uicontrol_text_edit_endash_edit); 
                            
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{edit2_h_uicontrol_text_edit_endash_edit})=...
                                objlist.(obj_index).h_uicontrol(edit2_h_uicontrol_text_edit_endash_edit); 
    elseif (~isfield(ui_struct,'module_para'))&&strcmpi(style_string,'text_listbox')
        UIhandles.(ui_struct.module_name{text_h_uicontrol_index___text_listbox}).handle=...
                             objlist.(obj_index).h_uicontrol(text_h_uicontrol_index___text_listbox); 
        UIhandles.(ui_struct.module_name{listbox_h_uicontrol_index___text_listbox}).handle=...
                              objlist.(obj_index).h_uicontrol(listbox_h_uicontrol_index___text_listbox);        
    elseif isfield(ui_struct,'module_para')&&strcmpi(style_string,'text_listbox')
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{text_h_uicontrol_index___text_listbox})=...
                                objlist.(obj_index).h_uicontrol(text_h_uicontrol_index___text_listbox);
        UIhandles.(ui_struct.module_name).(ui_struct.module_para{listbox_h_uicontrol_index___text_listbox})=...
                                objlist.(obj_index).h_uicontrol(listbox_h_uicontrol_index___text_listbox);                            
    end
end



end



