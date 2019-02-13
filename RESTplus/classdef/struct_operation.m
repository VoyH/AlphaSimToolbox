classdef struct_operation < handle
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    properties(Access=private)
       init_struct
    end
    
    
    methods 
        function obj=struct_operation(input_struct)
            obj.init_struct=input_struct;
        end
        
        function cell_array___all_subfield_value=spread_to_cell_array___all_subfield_value(obj)
            all_sub_fieldnames=fieldnames(obj.init_struct);
            cell_array___all_subfield_value=cell(length(all_sub_fieldnames),1);
            
            for i=1:length(all_sub_fieldnames)
                cell_array___all_subfield_value{i}=...
                        obj.init_struct.(all_sub_fieldnames{i});                
            end
        end
        
        function number_array___all_subfield_value=spread_to_number_array___all_subfield_value(obj)
            cell_array___all_subfield_value=obj.spread_to_cell_array___all_subfield_value;
            number_array___all_subfield_value=cell2mat(cell_array___all_subfield_value);
            
        end
        

    end
    
end