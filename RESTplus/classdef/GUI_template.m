classdef GUI_template < GUI_properties
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



    methods 
        function obj=GUI_template(template_str)
                 if strcmpi(template_str,'pixels_h29')
                     pixels_h29_template(obj);
                 else
                     error('templatename');
                 end
                 
        end
        
    end
        
    
end


function pixels_h29_template(obj)
    if strncmpi(computer,'MAC',3)
       obj.fontsize=14;
    elseif strncmpi(computer,'PC',2)
       obj.fontsize=12;
    else
       obj.fontsize=10;
    end
    obj.afontwidth=8;
    obj.unit='pixels';
    obj.fontunits='pixels'; 
    obj.spacewidth=35;
    obj.text_edit_diff=3;
    obj.fontweight='bold';
    obj.fontname='fixedwidth';
end









