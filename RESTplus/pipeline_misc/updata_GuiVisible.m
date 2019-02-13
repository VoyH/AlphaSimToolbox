function updata_GuiVisible(hObject,VisibleHandleArray,AllHandleArray)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



     for i=1:length(AllHandleArray)
          set(AllHandleArray(i), 'Visible', 'off');
     end


       if 0~=get(hObject,'Value')
           IfVisible='on';
       else
           IfVisible='off';
       end
   
       for i=1:length(VisibleHandleArray)
           set(VisibleHandleArray(i), 'Visible', IfVisible);
       end
           
  
