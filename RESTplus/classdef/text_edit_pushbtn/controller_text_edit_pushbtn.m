classdef controller_text_edit_pushbtn < handle
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    properties(Access=private)
        obj_view;
        obj_model;
    end
    
    
    methods
        function obj=controller_text_edit_pushbtn(viewobj,modelobj)
            obj.obj_view=viewobj;
            obj.obj_model=modelobj;
        end
        
        
        function callback_pushbtn(obj,scr,event)
            dialogtype=obj.obj_view.get_selectdialogtype();
            filedialog_ext=obj.obj_view.get_selectdialog_fileext();
            dialogtitle=obj.obj_view.get_dialogtitle();
            
            if strcmpi(dialogtype,'file')
                if ~isempty(filedialog_ext)
                   [FileName,PathName,FilterIndex] =uigetfile(filedialog_ext,dialogtitle);
                else
                   [FileName,PathName,FilterIndex] =uigetfile(dialogtitle); 
                end
                pathstring=[PathName FileName];
                cd_the_directory(PathName);
            elseif strcmpi(dialogtype,'dir')
                pathstring=uigetdir(pwd,dialogtitle);
                cd_the_directory(pathstring);
            else
                error('callback_pushbtn');
            end
            
            if 0~=pathstring
               obj.obj_model.updatestring(pathstring);  
            end
        end
    end
end



function cd_the_directory(PathName)
if 0~=PathName
   cd(PathName);
end
end