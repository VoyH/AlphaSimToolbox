classdef pipeline_default_uicontrol < pipeline_properties_default
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150611
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    properties
        h_uicontrol
    end

    
    
    properties(SetAccess=protected,GetAccess=protected)
           tag='defaulttag'
           string=''
           position=[0 0 0 0]
    end
    
    
    
    methods 
        function obj=pipeline_default_uicontrol(input_h_fig,varargin)
                 obj.h_fig=input_h_fig;
                 obj.set_properties(varargin);
                 obj.draw_default_uicontrol()
        end
    end
    
    
    
    methods(Access=protected)             
        function set_properties(obj,varargincell)
            for i=1:2:length(varargincell)
                  propertyname=varargincell{i};
                  propertyvalue=varargincell{i+1};
            
                 if strcmpi(propertyname,'tag')
                     obj.tag=propertyvalue;
                 elseif strcmpi(propertyname,'string')
                     obj.string=propertyvalue;
                 elseif strcmpi(propertyname,'position')
                     obj.position=propertyvalue;
                 elseif strcmpi(propertyname,'visible')
                     obj.visible=propertyvalue;
                 elseif strcmpi(propertyname,'style')
                     obj.style=propertyvalue;
                 elseif strcmpi(propertyname,'enable')
                     obj.enable=propertyvalue;
                 elseif strcmpi(propertyname,'value')
                     obj.value=propertyvalue;
                 elseif strcmpi(propertyname,'backgroundcolor')
                     obj.backgroundcolor=propertyvalue;
                 elseif strcmpi(propertyname,'fontsize')
                     obj.fontsize=propertyvalue;
                 elseif strcmpi(propertyname,'horizontalalignment')
                     obj.horizontalalignment=propertyvalue;
                 end
            
            end
        end
        
        
    function draw_default_uicontrol(obj)
             obj.h_uicontrol =  uicontrol(obj.h_fig,...
                                  'style',obj.style,...
                                  'units',obj.units,...
                                  'fontunits',obj.fontunits,...
                                  'fontsize',obj.fontsize,...
                                  'fontweight',obj.fontweight,...
                                  'fontname',obj.fontname,...
                                  'tag',obj.tag,...
                                  'visible',obj.visible,...
                                  'string',obj.string,...
                                  'enable',obj.enable,...
                                  'position',obj.position,...
                                  'horizontalalignment',obj.horizontalalignment,...
                                  'backgroundcolor',obj.backgroundcolor,...
                                  'value',obj.value);
    end
        
    end
end










