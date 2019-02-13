classdef model_text_edit_pushbtn < handle
    %-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

    properties
        editstring
    end
    
    events
        editstring_changed
    end
    
    methods
        function obj=model_text_edit_pushbtn(input_editstring)
            obj.editstring=input_editstring;
        end
        
        function updatestring(obj,newstring)
            obj.editstring=newstring;
            obj.notify('editstring_changed');
        end
    end
end