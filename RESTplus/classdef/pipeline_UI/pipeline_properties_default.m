classdef pipeline_properties_default < handle
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150611
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

    properties(Access=protected)
        h_fig
        style
        visible='on'
        value
        enable='on' 
        backgroundcolor='';
        fontsize=0.5
        horizontalalignment='center'
    end
        
    
    properties(Constant)
        fontunits='normalized'
        units='normalized'
        fontweight='bold'
        afontwidth=0.00897
        fontname='fixedwidth'
    end
    
    
    
    properties(Constant)
        value_default=0
        tag_default='defaulttag';
    %listbox default
        listbox_value_default=1;
%     listbox_fontsize_default=0.065;
        listbox_backgroundcolor_default=[1 1 1];
    
        checkbox_ico_width=0.0255;
        radiobutton_ico_width=0.0233;
        text_edit_diff=0.01;
        text_radiobtn_diff=0.008;
        
        text_pos_height=0.04;
        checkbox_pos_height=0.04;
        radiobutton_pos_height=0.04;
        edit_pos_height=0.035; %for win is ok, mac is small

        edit_backgroundcolor=[1 1 1];

        endash_gap=0.002;
        endash_width=0.035;
        endash_height=0.04;
        endash_string='~';
    end
    
    methods
        function obj=pipeline_properties_default()
            if isempty(obj.backgroundcolor)
               obj.backgroundcolor=get(gcf,'color');
            end
            
        end

    end
end