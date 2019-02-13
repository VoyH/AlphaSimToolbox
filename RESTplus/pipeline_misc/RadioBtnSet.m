function RadioBtnSet(HandlesArray,h_object,radiobutton_group_type)
%radiobutton_group_type
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



if nargin<=2
    radiobutton_group_type='default_one_selected';
end



h_object_value=get(h_object,'value');
RHandleInd=find(HandlesArray==h_object);

if strcmp(radiobutton_group_type,'default_one_selected')
   set_radiobutton_group___default_one_selected(HandlesArray,RHandleInd);    
elseif strcmp(radiobutton_group_type,'default_zero_selected')
   set_radiobutton_group___default_zero_selected(HandlesArray,RHandleInd,h_object_value); 
end

end


function set_radiobutton_group___default_one_selected(HandlesArray,RHandleInd)
    for i=1:length(HandlesArray)
        if i==RHandleInd
           set(HandlesArray(i),'Value',1);
        else
           set(HandlesArray(i),'Value',0)
        end
    end 
end


function set_radiobutton_group___default_zero_selected(HandlesArray,RHandleInd,h_object_value)
    for i=1:length(HandlesArray)
        if (i==RHandleInd)&&(0==h_object_value)
             set(HandlesArray(i),'Value',0);
        elseif (i==RHandleInd)&&(1==h_object_value)
             set(HandlesArray(i),'Value',1);
        else
             set(HandlesArray(i),'Value',0)
        end
    end
end