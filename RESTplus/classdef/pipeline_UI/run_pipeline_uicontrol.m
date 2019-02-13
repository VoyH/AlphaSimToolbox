function h_uicontrol=run_pipeline_uicontrol(h_fig,stylestr,ui_struct)
%20150609
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201506
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

if strcmp(stylestr,'text_radiobutton_horiz_line')
    evastring=sprintf('pipeline_text_radiobutton(h_fig,stylestr');
else
    evastring=sprintf('pipeline_uicontrol(h_fig,stylestr');  
end
ui_struct_fieldnames=fieldnames(ui_struct);
for i=1:length(ui_struct_fieldnames)
    if (~strcmpi(ui_struct_fieldnames{i},'module_name'))&&...
       (~strcmpi(ui_struct_fieldnames{i},'module_para'))
        evastring=sprintf('%s,''%s'',ui_struct.(''%s'')',...
                           evastring,ui_struct_fieldnames{i},ui_struct_fieldnames{i});   
    end
end      

evastring=sprintf('%s)',evastring);         
h_uicontrol=eval(evastring);

end 