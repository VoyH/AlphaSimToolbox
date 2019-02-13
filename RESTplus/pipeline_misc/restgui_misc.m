function varargout=restgui_misc(AOperation,varargin)
% restgui_misc('UpdateSaveDisplayListbox',VersionStr,handles);
% restgui_misc('run_SaveDisplayListbox',VersionStr,hObject,handles);
% restgui_misc('Run_SaveBtn',VersionStr,handles);
% ProcessType=restgui_misc('ChekProcessStrType',ProcessString);
% [ListboxPre,ListboxPost]=restgui_misc('Sort_ListboxStr',VersionStr,handles);
% restgui_misc('Run_LoadBtn',handles);                        
% restgui_misc('AutoSavePara',VersionStr,handles);                        
% restgui_misc('AutoSaveLog',VersionStr,handles,ProcessLogCell,ParameterLogCell)
% RadioYesNo=restgui_misc('RadioValue2YesNo',RadioValue)
% restgui_misc('BatchSetVisible',HandlesArray,IfVisible)
% restgui_misc('SetToolbarCorssBtn',TheFig_handle,RunBtn_handle,DefaultColor);
% CurrentSysFontsize=restgui_misc('FontsizeCompatibility',FsizeStruct);
% restgui_misc('check_if_smooth_after',hObject);
% restgui_misc('BatchSetEnable','on');
% auto_time_string=restgui_misc('get_auto_time');
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



    switch upper(AOperation)
%         case upper('UpdateSaveDisplayListbox')
%              VersionStr=varargin{1};
%              handles=varargin{2};
%              UpdateSaveDisplayListbox(VersionStr,handles);
        case upper('ChekProcessStrType')
             ProcessString=varargin{1};
             ProcessType=Chek_ProcessStrType(ProcessString);
             varargout{1}=ProcessType;
        case upper('check_if_smooth_after')
             hObject=varargin{1};
             check_if_smooth_after(hObject);
        case upper('Sort_ListboxStr')
             VersionStr=varargin{1};
             handles=varargin{2};
            [ListboxPre,ListboxPost]=Sort_ListboxStr(VersionStr,handles);
            varargout{1}=ListboxPre;
            varargout{2}=ListboxPost;
        case upper('Run_SaveBtn')  
             run_SaveBtn(varargin{1},varargin{2});
        case upper('Run_LoadBtn')
             run_LoadBtn(varargin{1});
        case upper('AutoSavePara')
             run_AutoSavePara(varargin{1},varargin{2});
        case upper('AutoSaveLog')
             run_AutoSaveLog(varargin{1},varargin{2},varargin{3},varargin{4});
        case upper('RadioValue2YesNo');
             varargout{1}=run_RadioValue2YesNo(varargin{1});
        case upper('BatchSetVisible')
             run_BatchSetVisible(varargin{1},varargin{2});
        case upper('BatchSetEnable')
             run_BatchSetEnable(varargin{1},varargin{2});
        case upper('SetToolbarCorssBtn')
             run_SetToolbarCorssBtn(varargin{1},varargin{2},varargin{3});
        case upper('FontsizeCompatibility')
             varargout{1}=run_FontsizeCompatibility(varargin{1});
        case upper('get_auto_time')
             varargout{1}=get_AutoTime();
        otherwise
             error('restgui_misc');
    end
end


function ProcessType=Chek_ProcessStrType(ProcessString)
handles=guidata(gcf);

Preprocesstype=handles.runstring.Preprocesstype;
Postprocesstype=handles.runstring.Postprocesstype;


ProcessType='';             
for i=1:length(Preprocesstype)
    if strcmpi(deblank(Preprocesstype{i}),ProcessString)
        ProcessType='preprocess';
    end
end

for i=1:length(Postprocesstype)
    if strcmpi(deblank(Postprocesstype{i}),ProcessString)
        ProcessType='postprocess';        
    end
end

if isempty(ProcessType)
   error('Process string is not exist'); 
end
             


end

function check_if_smooth_after(hObject)
handles=guidata(gcf); 
if_smooth_before.handle=handles.function_use_handle.check_if_smooth_after.if_do_smooth_checkbox.handle;
if_smooth_before.value=get(handles.function_use_handle.check_if_smooth_after.if_do_smooth_checkbox.handle,'value');
must_smooth_after_handle_array=handles.function_use_handle.check_if_smooth_after.must_do_smooth_after.handle_array;

if_choosed_any___must_smooth_after=0;
for i=1:length(must_smooth_after_handle_array)
    if_choosed_any___must_smooth_after=get(must_smooth_after_handle_array(i),'value')...
                                       +if_choosed_any___must_smooth_after;
end

if_current_btn_down=get(hObject,'value');

a_tolerance=1e-6;

if (...
       (1==if_smooth_before.value)... %push down smooth
       &&(1==if_current_btn_down)...
       &&(hObject==if_smooth_before.handle)...
       &&(0~=if_choosed_any___must_smooth_after)...
   )...
   ||...
   (...
      (1==if_smooth_before.value)... %push down method
      &&(1==if_current_btn_down)...
      &&(~isempty(find(abs(must_smooth_after_handle_array-hObject)<a_tolerance)))...
   )

   If_still_smooth_before= questdlg('Smooth should run after the postprocess method which you have selected!',...
                                    'Recommend','Yes','No','Yes');  
   switch If_still_smooth_before
          case 'No'
          case 'Yes'
               set(handles.function_use_handle.check_if_smooth_after.if_do_smooth_checkbox.handle,'value',0);
   end
end

end


function [ListboxPre,ListboxPost]=Sort_ListboxStr(VersionStr,handles)
    if strcmpi(VersionStr,'advance')
       Listboxstr=get(handles.UIhandles.ParameterDisplayListbox.handle,'string');
        ListboxPre='';
        ListboxPreIndex=1;
        ListboxPost='';
        ListboxPostIndex=1;
        for i=1:size(Listboxstr,1)
            ProcessStr_tmp=deblank(Listboxstr(i,:));
            ProcessType_tmp=restgui_misc('ChekProcessStrType',ProcessStr_tmp);
            if strcmpi('preprocess',ProcessType_tmp)
               ListboxPre{ListboxPreIndex}=ProcessStr_tmp;
               ListboxPreIndex=ListboxPreIndex+1;
            elseif strcmpi('postprocess',ProcessType_tmp)
               ListboxPost{ListboxPostIndex}=ProcessStr_tmp;
               ListboxPostIndex=ListboxPostIndex+1;
            else
                error('no exist type');
            end
        end  
    end
end


function run_SaveBtn(VersionStr,handles)

[filename ,pathname]=uiputfile({'*.mat','MAT-files(*.mat)'},'path for save');

if 0~=pathname
    GUImat=handles2GUImat_4save(handles);
    save([pathname filename],'GUImat');
end



end

function GUImat=handles2GUImat_4save(handles)

GUImat.Version=get_Parameters('CurrentVersion');

%% GUI UIhandles
all_fieldnames___UIhandles=fieldnames(handles.UIhandles);
for i=1:length(all_fieldnames___UIhandles)
    current_handle=handles.UIhandles.(all_fieldnames___UIhandles{i}).handle;
    current_style=get(current_handle,'style');
    if strcmp('listbox',current_style)...
           ||strcmp('edit',current_style)
       
           GUImat.UIvalue.(all_fieldnames___UIhandles{i}).string...
           =get(current_handle,'string');
       
    elseif strcmp('radiobutton',current_style)...
           ||strcmp('checkbox',current_style)
           GUImat.UIvalue.(all_fieldnames___UIhandles{i}).value...
           =get(current_handle,'value');
    end
    GUImat.UIvalue.(all_fieldnames___UIhandles{i}).style=current_style;    
end



%% GUI parameters
all_fieldnames___hPara=fieldnames(handles.hPara);
for i=1:length(all_fieldnames___hPara)  
    all_sub_fieldnames____hPara=fieldnames(handles.hPara.(all_fieldnames___hPara{i}));
    for j=1:length(all_sub_fieldnames____hPara)        
        current_handle=handles.hPara.(all_fieldnames___hPara{i}).(all_sub_fieldnames____hPara{j});
        current_style=get(current_handle,'style');      
        
        if strcmp('listbox',current_style)...
           ||strcmp('edit',current_style)
       
           GUImat.parameter.(all_fieldnames___hPara{i}).(all_sub_fieldnames____hPara{j}).string...
           =get(current_handle,'string');
       
        elseif strcmp('radiobutton',current_style)...
           ||strcmp('checkbox',current_style)
           GUImat.parameter.(all_fieldnames___hPara{i}).(all_sub_fieldnames____hPara{j}).value...
           =get(current_handle,'value');
        end
        GUImat.parameter.(all_fieldnames___hPara{i}).(all_sub_fieldnames____hPara{j}).style...
        =current_style;    
    end    
end




end

function run_LoadBtn(handles)
    [FileName,PathName]=uigetfile('*.mat','Select the mat file');

    if PathName~=0
    load([PathName filesep FileName]);
    
 if ~strcmpi(GUImat.Version,get_Parameters('CurrentVersion'))
     warning_string=sprintf('[mat file version:\t%s]\n\n[RESTplus version:\t%s]',UImat.Version,get_Parameters('CurrentVersion'));
     warndlg(warning_string);
 end
   

%% UI handle 
all_fieldnames___UIvalue=fieldnames(GUImat.UIvalue);
for i=1:length(all_fieldnames___UIvalue)
    current_struct=GUImat.UIvalue.(all_fieldnames___UIvalue{i});
    current_style=current_struct.style;
    current_handle=handles.UIhandles.(all_fieldnames___UIvalue{i}).handle;
    if strcmp('listbox',current_style)...
       ||strcmp('edit',current_style)
       set(current_handle,'string',current_struct.string);
    elseif strcmp('radiobutton',current_style)...
           ||strcmp('checkbox',current_style)
       set(current_handle,'value',current_struct.value);
    end
end


%% GUI parameters
all_fieldnames___parameter=fieldnames(GUImat.parameter);
for i=1:length(all_fieldnames___parameter)
    all_sub_fieldnames___parameter=fieldnames(GUImat.parameter.(all_fieldnames___parameter{i}));
    for j=1:length(all_sub_fieldnames___parameter)
        
        current_struct=GUImat.parameter.(all_fieldnames___parameter{i}).(all_sub_fieldnames___parameter{j});
        current_style=current_struct.style;
        current_handle=handles.hPara.(all_fieldnames___parameter{i}).(all_sub_fieldnames___parameter{j});

        if strcmp('listbox',current_style)...
           ||strcmp('edit',current_style)
           set(current_handle,'string',current_struct.string);
        elseif strcmp('radiobutton',current_style)...
               ||strcmp('checkbox',current_style)
           set(current_handle,'value',current_struct.value);
        end
    end
end


end
end


function run_AutoSavePara(VersionStr,handles)

Estr=get_Estr(VersionStr);
GUImat=handles2GUImat_4save(handles);
WorkDirectoryEditSTR=get(handles.UIhandles.WorkDirectoryEdit.handle,'string');
save([WorkDirectoryEditSTR,filesep,...
      Estr,'_AutoSave_' get_AutoTime() '.mat'],...
      'GUImat');

end


function run_AutoSaveLog(VersionStr,handles,ProcessLog,ParameterLog)
WorkDirectoryEditSTR=get(handles.UIhandles.WorkDirectoryEdit.handle,'string');
Estr=get_Estr(VersionStr);

LogPath=[WorkDirectoryEditSTR filesep Estr,'_Log_' get_AutoTime() '.txt'];



fid = fopen(LogPath,'a+');
fprintf(fid,'Parameter log\n');
fclose(fid);
brief_misc('Cell2txt',ParameterLog,LogPath,'a+');


fid = fopen(LogPath,'a+');
fprintf(fid,'\n\n\n\nInput and Output log\n');
fclose(fid);
brief_misc('Cell2txt',ProcessLog,LogPath,'a+');

end


function AutoTimeStr=get_AutoTime()
Datetime=fix(clock); 
AutoTimeStr=[num2str(Datetime(1)) ...
             '_',num2str(Datetime(2)) ...
             '_',num2str(Datetime(3)) ...
             '_',num2str(Datetime(4)) ...
             '_',num2str(Datetime(5))];
end

function Estr=get_Estr(VersionStr)
if strcmpi(VersionStr,'basic')  
    Estr='RP_pipeline';
elseif strcmpi(VersionStr,'advance') 
    Estr='RP_flexible';
else
    error('run_AutoSavePara');
end
end


function RadioYesNo=run_RadioValue2YesNo(RadioValue)
if 1==RadioValue
    RadioYesNo='Yes';
elseif 0==RadioValue
    RadioYesNo='No';
else
    error('run_RadioValue2YesNo');
end
end


function run_BatchSetVisible(HandlesArray,IfVisible)
for i=1:length(HandlesArray)
    set(HandlesArray,'visible',IfVisible);
end
end

function run_BatchSetEnable(HandlesArray,IfVisible)
for i=1:length(HandlesArray)
    set(HandlesArray,'enable',IfVisible);
end
end




function run_SetToolbarCorssBtn(TheFig_handle,RunBtn_handle,DefaultColor)
Uitoolbar_handles = uitoolbar(TheFig_handle);
FunRootdir=get_Parameters('MainFunctionPath');
IconsPath=[FunRootdir filesep 'icoCross.png'];

[X map] = imread(IconsPath); 
icon = ind2rgb(X,map); % Convert indexed image and colormap to truecolor
uipushtool(Uitoolbar_handles,'CData',icon,'TooltipString','Make run pushbutton enable on',...
          'ClickedCallback', {@MakeRunBtnEnableon,RunBtn_handle,DefaultColor}); 
end

function MakeRunBtnEnableon(h, evt,RunBtn_handle,DefaultColor)
set(RunBtn_handle,'enable','on','BackgroundColor',DefaultColor);
end


function CurrentSysFontsize=run_FontsizeCompatibility(FsizeStruct)
CurrentSystem=computer;
if strncmpi(CurrentSystem,'MAC',3)
   CurrentSysFontsize=FsizeStruct.Mac;
elseif strncmpi(CurrentSystem,'PC',2)
   CurrentSysFontsize= FsizeStruct.PC;
else
   CurrentSysFontsize=FsizeStruct.Other;
end
end



