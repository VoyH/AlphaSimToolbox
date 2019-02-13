function asltbx_pcasl()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


   h_figure_asltbx_pcasl=500;
   clear global
   asltbx_mutex('pcasl')
   asltbx_infor_display('asltbx_pcasl');

    try
        thePos =get(h_figure_asltbx_pcasl, 'Position');
        if numel(thePos)==4,
                figure(h_figure_asltbx_pcasl);
        end	
    catch
        handles=init_asltbx_pcasl(h_figure_asltbx_pcasl);
        handles=init_asltbx_pcasl_gui(handles);
    end
end


function handles=init_asltbx_pcasl(h_figure_asltbx_pcasl)
    handles.MainFigure=figure(h_figure_asltbx_pcasl);
    set(handles.MainFigure,'visible','off','MenuBar','none','NumberTitle','off');
    set(handles.MainFigure,'color',[240/250,240/250,240/250]);
    set(handles.MainFigure,'unit','pixels','position',[520 145 1000 670]);
    set(handles.MainFigure,'Name','asltbx:pcasl');
    movegui(handles.MainFigure,'center');
    guidata(gcf, handles);
    set(handles.MainFigure,'visible','on');  
end