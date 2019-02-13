function  repipla()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201407
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


try
	thePos =get(100, 'Position');
	if numel(thePos)==4,
			figure(100);
    end	
catch
handles.MainFigure=figure(100);
set(handles.MainFigure,'visible','off','MenuBar','none','NumberTitle','off');
[handles UserP]=InitGUI_AllVersions(handles);
handles=InitGUI_AdvancedVersion(handles,UserP);
handles=InitHandles_AdvancedVersion(handles);

for i=1:length(handles.AllUIhandles)
    set(handles.AllUIhandles(i).handle,'callback',@run_AVersionCallback);
end

guidata(gcf, handles);
set(handles.MainFigure,'visible','on');    
    
    
end
    



end



