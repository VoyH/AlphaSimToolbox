function handles=init_UserP_600x330(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


handles.UserP.start_line.y=350;
line_amount=15;
for i=1:line_amount
  handles.UserP.(['line' num2str(i)]).y=handles.UserP.start_line.y-35*(i-1); 
end

for i=1:line_amount*4
    handles.UserP.(['close_line' num2str(i)]).y=handles.UserP.start_line.y-8*(i-1); 
end





end