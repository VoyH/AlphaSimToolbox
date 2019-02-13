classdef draw_text1_text2_h29 < handle
    % did not finished
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    
    properties
        h_fig
        module_y
        module_x
        textstring
        modulewidth
    end
    
    methods
        function obj=draw_text1_text2_h29(h_fig,inputvalue)
            obj.h_fig=h_fig;
            inputvalue_fieldname_list=fieldnames(inputvalue);
            for i=1:length(inputvalue_fieldname_list)
                obj.(inputvalue_fieldname_list{i})=inputvalue.(inputvalue_fieldname_list{i});
            end

        end
    end
end