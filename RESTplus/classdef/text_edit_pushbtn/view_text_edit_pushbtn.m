classdef view_text_edit_pushbtn < handle
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    properties(Access=protected)
        h_fig;
        h_text;
        h_edit;
        h_pushbtn;
        templatetype; %pixels_h29
        obj_GUI_template;
        module_y;
        module_x;
        textstring; 
        modulewidth;
        obj_control;
        obj_model;
        editstring;
        selectdialogtype='dir'; %dir|file
        dialogfileext='';
        dialogtitle='please select your file or folder';
    end
    


    
   properties(Dependent)
       pos_vector;
   end
    
    methods
        function obj=view_text_edit_pushbtn(inputvalue,templatetype_str,input_obj_model)
            obj.templatetype=templatetype_str;
            obj.obj_GUI_template=GUI_template(templatetype_str);
            obj.h_fig=inputvalue.h_fig;
            obj.module_y=inputvalue.module_y;
            obj.module_x=inputvalue.module_x;
            obj.textstring=inputvalue.textstring;
            obj.modulewidth=inputvalue.modulewidth;
            
            obj.obj_model=input_obj_model;
            obj.obj_model.addlistener('editstring_changed',@obj.update_editstring);
            obj.buildUI();
            
            obj.obj_control=obj.makeController();
            obj.attachToController(obj.obj_control);
                        
            
        end
        
         function pos_vector=get.pos_vector(obj)     
                  if strcmpi(obj.templatetype,'pixels_h29')
                     pushbtnwidth=45; 
                     h29=29;
                     
                     text_x=obj.module_x;
                     text_y=obj.module_y;
                     textwidth=length(obj.textstring)*obj.obj_GUI_template.afontwidth;
                     textheight=h29-9;
                     
                     edit_x=1.3*obj.module_x+textwidth;
                     edit_y=obj.module_y-3;
                     editwidth=obj.modulewidth-textwidth-pushbtnwidth;
                     editheight=h29-1;
                     
                     pushbtn_x=1.5*obj.module_x+textwidth+editwidth;
                     pushbtn_y=obj.module_y-4;
                     pushbtnheight=h29;
                    
                     pos_vector.text=[text_x text_y textwidth textheight];
                     pos_vector.edit=[edit_x edit_y editwidth editheight];
                     pos_vector.pushbtn=[pushbtn_x pushbtn_y pushbtnwidth pushbtnheight];
                  end
         end
         
         function set_text_string(obj,text_string)
             obj.textstring=text_string;
             set(obj.h_text,'string',text_string);
             obj.update_position;
         end
         
         function set_edit_string(obj,edit_string)
            obj.editstring=edit_string;
            set(obj.h_edit,'string',edit_string);
            obj.update_position;
         end
         
         function update_position(obj)
             set(obj.h_text,'position',obj.pos_vector.text);
             set(obj.h_edit,'position',obj.pos_vector.edit);
             set(obj.h_pushbtn,'position',obj.pos_vector.pushbtn);
         end
                  
         
         function set_selectdialogtype(obj,var)
             if strcmpi(var,'dir')||strcmpi(var,'file')
                obj.selectdialogtype=var;
             else
                 error('selectbox input is wrong');
             end
         end
         
         
         function dialogtype=get_selectdialogtype(obj)
             dialogtype=obj.selectdialogtype;
         end
         
         
         
         function set_selectdialog_fileext(obj,var)
             if strcmpi(var,'matlabfile')
                 obj.dialogfileext={'*.m;*.mat'};
             elseif strcmpi(var,'matfile')
                 obj.dialogfileext={'*.mat'};
             elseif strcmpi(var,'brainimage')
                 obj.dialogfileext={'*.nii;*.img','brain image (*.nii;*.img)'}; 
             else
                 error('set_selectdialog_fileext error');
             end
             
         end
         
         
         function fileext=get_selectdialog_fileext(obj)
             fileext=obj.dialogfileext;
         end
         
         function h_edit=get_h_edit(obj)
             h_edit=obj.h_edit;
         end
         
         function h_text1=get_h_text1(obj)
             h_text1=obj.h_text;
         end
         
         function h_text2=get_h_text2(obj)
             h_text2=obj.h_edit;
         end
         
         function set_dialogtitle(obj,var)
             obj.dialogtitle=var;
         end
         
         function output_h_pushbtn=get_h_pushbtn(obj)
             output_h_pushbtn=obj.h_pushbtn;
         end
         
         function output_dialogtitle=get_dialogtitle(obj)
             output_dialogtitle=obj.dialogtitle;
         end
         
         function set_pushbuton_visible(obj,if_visible)
             set(obj.h_pushbtn,'visible',if_visible);
         end
         
         function set_text_edit_pushbtn_visible(obj,if_visible)
             set(obj.h_text,'visible',if_visible);
             set(obj.h_edit,'visible',if_visible);
             set(obj.h_pushbtn,'visible',if_visible);             
         end
         
         function convert_edit_to_text(obj)
             set(obj.h_edit,'style','text');
         end
         
         function set_module_enable(obj,enable_str)
             set(obj.h_edit,'enable',enable_str);
             set(obj.h_pushbtn,'enable',enable_str);
         end
         
         
    end
    
    methods(Access = private)

        function buildUI(obj)
             obj.h_text=uicontrol(obj.h_fig,...
                              'Style','text',...
                              'unit',obj.obj_GUI_template.unit,...
                              'Position',obj.pos_vector.text,...
                              'FontUnits',obj.obj_GUI_template.fontunits,...                              
                              'FontSize',obj.obj_GUI_template.fontsize,...
                              'string',obj.textstring,...
                              'fontweight',obj.obj_GUI_template.fontweight,...
                              'tag','thetext',...
                              'backgroundcolor',obj.obj_GUI_template.backgroundcolor,...
                              'fontname',obj.obj_GUI_template.fontname);
                          
            obj.h_edit=uicontrol(obj.h_fig,...
                                 'style','edit',...
                                 'unit',obj.obj_GUI_template.unit,...                                 
                                 'position',obj.pos_vector.edit,...
                                 'FontUnits',obj.obj_GUI_template.fontunits,...
                                 'FontSize',obj.obj_GUI_template.fontsize,...
                                 'fontweight',obj.obj_GUI_template.fontweight,...
                                 'string',obj.obj_model.editstring,...
                                 'tag','theedit',...
                                 'backgroundcolor',[1 1 1],...
                                 'fontname',obj.obj_GUI_template.fontname);              
                          
            obj.h_pushbtn=uicontrol(obj.h_fig,...
                                    'style','pushbutton',...
                                    'unit',obj.obj_GUI_template.unit,... 
                                    'position',obj.pos_vector.pushbtn,...
                                    'FontUnits',obj.obj_GUI_template.fontunits,...                                   
                                    'string','...',...
                                    'FontSize',obj.obj_GUI_template.fontsize,...
                                    'fontweight',obj.obj_GUI_template.fontweight,...
                                    'tag','thepushbtn',...
                                    'backgroundcolor',obj.obj_GUI_template.backgroundcolor,...
                                    'fontname',obj.obj_GUI_template.fontname);  
                                    
 
        end
        
        function update_editstring(obj,scr,data)
            set(obj.h_edit,'string',obj.obj_model.editstring);
        end
        
        function controlObj=makeController(obj)
            controlObj=controller_text_edit_pushbtn(obj,obj.obj_model);
        end
        
        
        function attachToController(obj,controller)
            funcH=@controller.callback_pushbtn;
            set(obj.h_pushbtn,'callback',funcH);
        end
        
        

    end
end


