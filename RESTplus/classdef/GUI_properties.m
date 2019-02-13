classdef GUI_properties < handle
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    properties(SetAccess=protected,GetAccess=public)
        fontsize;
        fontweight;
        fontname;
        unit;
        fontunits;
        backgroundcolor;
        afontwidth;
        spacewidth;
        tag;
        visible;
        string;
        text_edit_diff;
    end
    
    
    methods 
        function obj=GUI_properties()
            obj.backgroundcolor=[240/250,240/250,240/250];
        end        
    end 
    
    

end