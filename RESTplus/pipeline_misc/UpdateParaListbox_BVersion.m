function handles=UpdateParaListbox_BVersion(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



ParametersListboxArray=InitStruct_BasicVersion('ParametersListboxArray',handles);           
ProcessStr=ParametersListboxArray(:,1);
ProcessLogical=cell2mat(ParametersListboxArray(:,2));           
ProcessQueue=ProcessStr(logical(ProcessLogical));
ListboxStr=brief_misc('CellArray2Listboxstr',ProcessQueue);

set(handles.UIhandles.ParameterDisplayListbox.handle,'value',1);
set(handles.UIhandles.ParameterDisplayListbox.handle,...
       'string',ListboxStr);

   
end