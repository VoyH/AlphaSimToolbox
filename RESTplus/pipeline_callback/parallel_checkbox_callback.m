function parallel_checkbox_callback(hObject, eventdata)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



handles=guidata(gcf);
if 1==get(hObject,'value')
    set(handles.UIhandles.parallel_edit.handle,'enable','on');
    matlabpool_num=str2double(get(handles.UIhandles.parallel_edit.handle,'string'));
    if (~isempty(matlabpool_num))&&(matlabpool_num>0)&&(matlabpool('size')<=0)
       matlabpool(matlabpool_num); 
    end
else
    set(handles.UIhandles.parallel_edit.handle,'enable','off');
    if matlabpool('size')>0
       matlabpool close
    end
end
end