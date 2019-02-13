function varargout=pushbtn_locking(AOperation,varargin)
% raw_property=pushbtn_locking('lock',h_pushbtn)
% pushbtn_locking('unlock',h_pushbtn,raw_property)
% 
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150905
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if strcmpi(AOperation,'lock')
   h_pushbtn=varargin{1};
   raw_property= lock_the_pushbtn(h_pushbtn);
   varargout{1}=raw_property;
   

elseif strcmpi(AOperation,'unlock')
   h_run_btn=varargin{1};
   raw_property=varargin{2};
   unlock_the_pushbtn(h_run_btn,raw_property);
end

end



function raw_property= lock_the_pushbtn(h_pushbtn)
 raw_property.backgroundcolor=get(h_pushbtn ,'BackgroundColor');
 raw_property.foregroundcolor=get(h_pushbtn ,'ForegroundColor');
 
 set(h_pushbtn,'Enable', 'off',...
               'BackgroundColor', 'red',...
               'ForegroundColor','green');
end




function unlock_the_pushbtn(h_pushbtn,raw_property)
 set(h_pushbtn,'Enable', 'on',...
               'BackgroundColor', raw_property.backgroundcolor,...
               'ForegroundColor',raw_property.foregroundcolor);
end


