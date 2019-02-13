function varargout=run_BVersionCallback(AOperation,varargin)
% [RunString,VisibleHandleArray,ProcessType]=...
%                          run_BVersionCallback('GUIparaVisible',...
%                                                    'hObject',hObject,...
%                                                    'handles',handles,...
%                                                    'VersionStr',VersionStr,...
%                                                    'CallbackString',CallbackString);
% run_BVersionCallBack('Generate_IOParameter',)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


%
CB_value=InitCallbackValueStruct(varargin);
CallbackString=CB_value.CallbackString;



% Pipleline Version RadioButton............
if strcmp(get_GuiTag('BasicVersionRadioBtn'),CallbackString) 
       run_BasicVersionRadioBtn(CB_value);

elseif strcmp(get_GuiTag('AdvancedVersionRadioBtn'),CallbackString)
       run_AdvancedVersionRadioBtn(CB_value);

       
       
% Display Listbox Callback......       
elseif strcmp(get_GuiTag('ParameterDisplayListbox'),CallbackString)
       [VisibleHandleArray,ProcessType,RunString]=run_ParameterDisplayListbox(CB_value);       
         
elseif strcmp(get_GuiTag('PreDefinedParameterPpmenu'),CallbackString)
        VisibleHandleArray=run_PreDefinedParameterPpmenu(CB_value);

     
        
% Push button and Edit Callback...........                
elseif strcmp(get_GuiTag('WorkDirectoryBtn'),CallbackString)
       run_WorkDirectoryBtn(CB_value);  

elseif strcmp(get_GuiTag('DisplayParticipantsBtn'),CallbackString)
       run_DisplayParticipantsBtn(CB_value);

elseif strcmp(get_GuiTag('StartDirectoryEpiEdit'),CallbackString)     
       run_StartDirectoryEpiEdit(CB_value);        

elseif strcmp(get_GuiTag('StartDirectoryT1Edit'),CallbackString)   
       run_StartDirectoryT1Edit(CB_value);   
       
elseif strcmp(get_GuiTag('SavePushBtn'),CallbackString)   
       run_SavePushBtn(CB_value);
      
elseif strcmp(get_GuiTag('LoadPushBtn'),CallbackString)
       run_LoadPushBtn(CB_value);
           
      
elseif strcmp(get_GuiTag('RunPushBtn'),CallbackString)
    pipeline_run_pushbutton_callback(CB_value);
     
%Preprocess..................................................................             
elseif strcmp(get_GuiTag('DicomToNiftiChekbox'),CallbackString)...
     ||strcmp(get_RunStr('DicomToNifti'),CallbackString)             
     [RunString,VisibleHandleArray,ProcessType]=run_DicomToNifti(CB_value);

elseif strcmp(get_GuiTag('RemoveFirstTimePointsChekbox'),CallbackString)...
      ||strcmp(get_RunStr('RemoveFirstTimePoints'),CallbackString)              
     [RunString,VisibleHandleArray,ProcessType]=run_RemoveFirstTimePointsChekbox(CB_value);

elseif strcmp(get_GuiTag('SliceTimingChekbox'),CallbackString)...
      ||strcmp(get_RunStr('SliceTiming'),CallbackString)
    [RunString,VisibleHandleArray,ProcessType]=run_SliceTimingChekbox(CB_value);

elseif strcmp(get_GuiTag('RealignChekbox'),CallbackString)...
      ||strcmp(get_RunStr('Realign'),CallbackString)
    [RunString,VisibleHandleArray,ProcessType]=run_RealignChekbox(CB_value);

elseif strcmp(get_GuiTag('ReorientChekbox'),CallbackString)...
      ||strcmp(get_RunStr('Reorient'),CallbackString)
    [RunString,VisibleHandleArray,ProcessType]=run_ReorientChekbox(CB_value);

elseif strcmp(get_GuiTag('NormalizeChekbox'),CallbackString)...
      ||strcmp(get_RunStr('Normalize'),CallbackString)
    [RunString,VisibleHandleArray,ProcessType]=run_NormalizeChekbox(CB_value);

elseif strcmp(get_GuiTag('SmoothChekbox'),CallbackString)...
      ||strcmp(get_RunStr('Smooth'),CallbackString)
    [RunString,VisibleHandleArray,ProcessType]=run_SmoothChekbox(CB_value);

elseif strcmp(get_GuiTag('DetrendChekbox'),CallbackString)...
      ||strcmp(get_RunStr('Detrend'),CallbackString)
    [RunString,VisibleHandleArray,ProcessType]=run_DetrendChekbox(CB_value);

elseif strcmp(get_GuiTag('FilterChekbox'),CallbackString)...
      ||strcmp(get_RunStr('Filter'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_FilterChekbox(CB_value);

elseif strcmp(get_GuiTag('RegressOutNuisanceChekbox'),CallbackString)...
     ||strcmp(get_RunStr('RegressOutCovariates'),CallbackString);
     [RunString,VisibleHandleArray,ProcessType]=run_RegressOutNuisanceChekbox(CB_value);  
     
     
     
%Mask................................................................................          
elseif strcmp(get_GuiTag('DefaultmaskRadioBtn'),CallbackString)
       run_DefaultmaskRadioBtn(CB_value);
elseif strcmp(get_GuiTag('NoMaskRadioBtn'),CallbackString)
      run_NoMaskRadioBtn(CB_value);
elseif strcmp(get_GuiTag('UserDefinedMaskRadioBtn'),CallbackString)
     run_UserDefinedMaskRadioBtn(CB_value);      
     
     
     
%Post process..................................................................
elseif strcmp(get_GuiTag('AlffRadioBtn'),CallbackString)...
      ||strcmp(get_RunStr('Alff'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_AlffRadioBtn(CB_value);

elseif strcmp(get_GuiTag('fALFFRadioBtn'),CallbackString)...
      ||strcmp(get_RunStr('fALFF'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_fALFFRadioBtn(CB_value);

elseif strcmp(get_GuiTag('KccReHoRadioBtn'),CallbackString)....
      ||strcmp(get_RunStr('KccReHo'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_KccReHoRadioBtn(CB_value);

elseif strcmp(get_GuiTag('CoheReHoRadioBtn'),CallbackString)...
      ||strcmp(get_RunStr('CoHeReHo'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_CoheReHoRadioBtn(CB_value);

elseif strcmp(get_GuiTag('DegreeCentralityRadioBtn'),CallbackString)...
      ||strcmp(get_RunStr('DegreeCentrality'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_DegreeCentralityRadioBtn(CB_value);

elseif strcmp(get_GuiTag('VMHCRadioBtn'),CallbackString)...
      ||strcmp(get_RunStr('VMHC'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_VMHCRadioBtn(CB_value);

elseif strcmp(get_GuiTag('PerAFRadioBtn'),CallbackString)...
      ||strcmp(get_RunStr('PerAF'),CallbackString)
 [RunString,VisibleHandleArray,ProcessType]=run_PerAFRadioBtn(CB_value);

elseif strcmp(get_GuiTag('FunConnectivityRadioBtn'),CallbackString)...
     ||strcmp(get_RunStr('FunctionalConnectivity'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_FunConnectivityRadioBtn(CB_value);  

elseif strcmp(get_GuiTag('GCARadioBtn'),CallbackString)...
      ||strcmp(get_RunStr('GCA'),CallbackString)
     [RunString,VisibleHandleArray,ProcessType]=run_GCARadioBtn(CB_value);
     
%.....................................................................
else
     error('Tag or RunStr is not exist')
end




if strcmp('GUIparaVisible',AOperation) 
    if 0==exist('RunString','var')
       RunString=''; 
    end     
    
    if 0==exist('VisibleHandleArray','var')
       VisibleHandleArray=''; 
    end   

    if 0==exist('ProcessType','var')
       ProcessType=''; 
    end
    varargout{1}=RunString;
    varargout{2}=VisibleHandleArray;
    varargout{3}=ProcessType;
end    
    
end


function CB_value=InitCallbackValueStruct(vararginCell)

for i=1:2:length(vararginCell)
    AOperationName=vararginCell{i};
    AOperationValue=vararginCell{i+1};
    switch upper(AOperationName)
        case upper('hObject')
            CB_value.hObject=AOperationValue;
        case upper('handles')
            CB_value.handles=AOperationValue;
        case upper('VersionStr')
            CB_value.VersionStr=AOperationValue;
        case upper('CallbackString')
            CB_value.CallbackString=AOperationValue;
        case upper('IOListIn')
            CB_value.IOListIn=AOperationValue;
        case upper('InputParameter')
            CB_value.InputParameter=AOperationValue;
        case upper('AnalysisDir')
            CB_value.AnalysisDir=AOperationValue;            
    end
end
end





function run_BasicVersionRadioBtn(CB_value)
    hObject=CB_value.hObject;
    handles=CB_value.handles;
    RadioBtnSet(handles.VersionRadioBtn.Array,hObject);
end

function run_AdvancedVersionRadioBtn(CB_value)
   hObject=CB_value.hObject;
   handles=CB_value.handles;
   RadioBtnSet(handles.VersionRadioBtn.Array,hObject);
   close(handles.MainFigure);
   repipla;
end


function [VisibleHandleArray,ProcessType,RunString]=run_ParameterDisplayListbox(CB_value)
hObject=CB_value.hObject;
handles=CB_value.handles;
VersionStr=CB_value.VersionStr;

 Listindex=get(hObject,'value');
 Liststr=get(hObject,'string');
 CurrentStr=deblank(Liststr(Listindex,:));
 if ~isempty(CurrentStr)
    [RunString,VisibleHandleArray,ProcessType]=...
                 run_BVersionCallback('GUIparaVisible',...
                                      'hObject',hObject,...
                                      'handles',handles,...
                                      'VersionStr',VersionStr,...
                                       'CallbackString',CurrentStr);  
 else
     VisibleHandleArray='';
     ProcessType='';   
 end
 RunString='';
end


function run_SaveDisplayListbox(CB_value)
    VersionStr=CB_value.VersionStr;
    hObject=CB_value.hObject;
    handles=CB_value.handles;
    restgui_misc('run_SaveDisplayListbox',VersionStr,hObject,handles); 
end


function VisibleHandleArray=run_PreDefinedParameterPpmenu(CB_value)
hObject=CB_value.hObject;
handles=CB_value.handles;

Ppmenustr=get(hObject,'string');
Ppmenuindex=get(hObject,'value');
[OperationList,InputParameter,GuiParameter]=...
                                  repipl_PreDefinedParameter(deblank(Ppmenustr(Ppmenuindex,:)));
UpdateGUI_BasicVersion(OperationList,handles,InputParameter,GuiParameter);
set(handles.UIhandles.DefaultmaskRadioBtn.handle,'value',1);

VisibleHandleArray='';

end


function run_WorkDirectoryBtn(CB_value)
    handles=CB_value.handles;
    handles.UIvalue.WorkDirectory.value=uigetdir(pwd);
    if 0~=handles.UIvalue.WorkDirectory.value
        cd(handles.UIvalue.WorkDirectory.value);
        set(handles.UIhandles.WorkDirectoryEdit.handle,...
            'string',handles.UIvalue.WorkDirectory.value);
    end
end

function run_DisplayParticipantsBtn(CB_value)
   handles=CB_value.handles;
   hObject=CB_value.hObject;
   
   WorkDirectory=get(handles.UIhandles.WorkDirectoryEdit.handle,'string');
   StartFunImg=get(handles.UIhandles.StartDirectoryEpiEdit.handle,'string');
   StartT1Img=get(handles.UIhandles.StartDirectoryT1Edit.handle,'string');
   if isdir([WorkDirectory filesep StartFunImg])
          SubfodrList=dir_NameList([WorkDirectory filesep StartFunImg]);
   elseif isdir([WorkDirectory filesep StartT1Img])
          SubfodrList=dir_NameList([WorkDirectory filesep StartT1Img]);
   else
       msgbox('Folder is not exist!');
       return;
       
   end
   ListboxStr=brief_misc('CellArray2Listboxstr',SubfodrList);
   set(handles.hPara.ParticipantsListInput.DisplayListbox,...
       'string',ListboxStr)

   VisibleHandleArray=handles.hParaArray.ParticipantsList;
    updata_GuiVisible(hObject,VisibleHandleArray,handles.hParaAll); 
end


function run_StartDirectoryEpiEdit(CB_value)
  handles=CB_value.handles;

   WorkDirectory=get(handles.UIhandles.WorkDirectoryEdit.handle,'string');
   StartFunImg=get(handles.UIhandles.StartDirectoryEpiEdit.handle,'string');
   
   AllHandleArray=handles.hParaAll;
   for i=1:length(AllHandleArray)
          set(AllHandleArray(i), 'Visible', 'off');
   end
      
   if isdir([WorkDirectory filesep StartFunImg])...
      &&~isempty(StartFunImg)     
      SubfodrList=dir_NameList([WorkDirectory filesep StartFunImg]);
      ListboxStr=brief_misc('CellArray2Listboxstr',SubfodrList);
      set(handles.hPara.ParticipantsListInput.DisplayListbox,...
          'string',ListboxStr)
      VisibleHandleArray=handles.hParaArray.ParticipantsList;
      
     
      for i=1:length(VisibleHandleArray)
          set(VisibleHandleArray(i), 'Visible', 'on');
      end       
   end

end

function run_StartDirectoryT1Edit(CB_value)
   handles=CB_value.handles;

   WorkDirectory=get(handles.UIhandles.WorkDirectoryEdit.handle,'string');
   StartT1Img=get(handles.UIhandles.StartDirectoryT1Edit.handle,'string');
   
   AllHandleArray=handles.hParaAll;
   for i=1:length(AllHandleArray)
          set(AllHandleArray(i), 'Visible', 'off');
   end
      
   if isdir([WorkDirectory filesep StartT1Img])...
      &&~isempty(StartT1Img)     
      SubfodrList=dir_NameList([WorkDirectory filesep StartT1Img]);
      ListboxStr=brief_misc('CellArray2Listboxstr',SubfodrList);
      set(handles.hPara.ParticipantsListInput.DisplayListbox,...
          'string',ListboxStr)
      VisibleHandleArray=handles.hParaArray.ParticipantsList;
      
     
      

      for i=1:length(VisibleHandleArray)
          set(VisibleHandleArray(i), 'Visible', 'on');
      end
   end
end


function run_SavePushBtn(CB_value)
    VersionStr=CB_value.VersionStr;
    handles=CB_value.handles;
    restgui_misc('Run_SaveBtn',VersionStr,handles);
end


function  run_LoadPushBtn(CB_value)
    handles=CB_value.handles;
    restgui_misc('Run_LoadBtn',handles);       
end

function [RunString,VisibleHandleArray,ProcessType]=run_DicomToNifti(CB_value)
       handles=CB_value.handles;
       RunString=get_RunStr('DicomToNifti');
       VisibleHandleArray=handles.hParaArray.DicomToNifti;
       ProcessType='Preprocess';

end

 function [RunString,VisibleHandleArray,ProcessType]=run_RemoveFirstTimePointsChekbox(CB_value)
       handles=CB_value.handles;
       RunString=get_RunStr('RemoveFirstTimePoints');
       VisibleHandleArray=handles.hParaArray.RemoveTimePoints;
       ProcessType='Preprocess';

 end
 
    function [RunString,VisibleHandleArray,ProcessType]=run_SliceTimingChekbox(CB_value)
       handles=CB_value.handles;
       RunString=get_RunStr('SliceTiming');
       VisibleHandleArray=handles.hParaArray.SliceTiming;       
       ProcessType='Preprocess';
    end

    function [RunString,VisibleHandleArray,ProcessType]=run_RealignChekbox(CB_value)
       RunString=get_RunStr('Realign');
       VisibleHandleArray='';
       ProcessType='Preprocess';
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_ReorientChekbox(CB_value)
        handles=CB_value.handles;
        RunString=get_RunStr('Reorient');    
        VisibleHandleArray=handles.hParaArray.Reorient;    
        ProcessType='Preprocess';
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_NormalizeChekbox(CB_value)
        handles=CB_value.handles;
        RunString=get_RunStr('Normalize');
        VisibleHandleArray=handles.hParaArray.NormalizePara;    
        ProcessType='Preprocess';
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_SmoothChekbox(CB_value)
        handles=CB_value.handles;
        hObject=CB_value.hObject;
        RunString=get_RunStr('Smooth');    
        VisibleHandleArray=handles.hParaArray.Smooth;    
        ProcessType='Preprocess';
        restgui_misc('check_if_smooth_after',hObject);
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_DetrendChekbox(CB_value)
        handles=CB_value.handles;
        RunString=get_RunStr('Detrend');
        VisibleHandleArray='';
        ProcessType='Preprocess';
        
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_FilterChekbox(CB_value)
        handles=CB_value.handles;
        RunString=get_RunStr('Filter');
        VisibleHandleArray=handles.hParaArray.Filter;    
        ProcessType='Preprocess';

    end
    
    
    
    function [RunString,VisibleHandleArray,ProcessType]=run_RegressOutNuisanceChekbox(CB_value)
        handles=CB_value.handles;
        VisibleHandleArray=handles.hParaArray.RegressOutNuisance;    
        RunString=get_RunStr('RegressOutCovariates');
        ProcessType='Preprocess';
    end
    
    
    
    
    
    
    
    
    function [RunString,VisibleHandleArray]=run_DefaultmaskRadioBtn(CB_value)
       hObject=CB_value.hObject;
       handles=CB_value.handles;
       VisibleHandleArray='';
       RunString='';
       RadioBtnSet(handles.hParaArray.ChooseMask,hObject);
       AllHandleArray=handles.hParaAll;        
       updata_GuiVisible(hObject,'',AllHandleArray);
    end
    
    function [RunString,VisibleHandleArray]=run_NoMaskRadioBtn(CB_value)
        hObject=CB_value.hObject;
        handles=CB_value.handles;
        VisibleHandleArray='';
        RunString='';
        RadioBtnSet(handles.hParaArray.ChooseMask,hObject);
        AllHandleArray=handles.hParaAll;
        updata_GuiVisible(hObject,'',AllHandleArray);
    end
    
    function [RunString,VisibleHandleArray]=run_UserDefinedMaskRadioBtn(CB_value)
        hObject=CB_value.hObject;
        handles=CB_value.handles;
        RunString='';
        RadioBtnSet(handles.hParaArray.ChooseMask,hObject);
        AllHandleArray=handles.hParaAll;
        VisibleHandleArray=handles.hParaArray.Usermask;    
        updata_GuiVisible(hObject,VisibleHandleArray,AllHandleArray);
    end
    
    
    
    
    
    
    
    
    function [RunString,VisibleHandleArray,ProcessType]=run_AlffRadioBtn(CB_value)    
        handles=CB_value.handles;
        RunString=get_RunStr('Alff');
        ProcessType='Postprocess';
        VisibleHandleArray=handles.hParaArray.ALFF;    
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_fALFFRadioBtn(CB_value)
        handles=CB_value.handles;
        RunString=get_RunStr('fALFF');
        ProcessType='Postprocess';    
        VisibleHandleArray=handles.hParaArray.fALFF;    
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_KccReHoRadioBtn(CB_value)
        hObject=CB_value.hObject;
        handles=CB_value.handles;
        RunString=get_RunStr('KccReHo');
        ProcessType='Postprocess';    
        VisibleHandleArray=handles.hParaArray.KccReHo; 
        restgui_misc('check_if_smooth_after',hObject);
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_CoheReHoRadioBtn(CB_value)
        handles=CB_value.handles;
        hObject=CB_value.hObject;
        RunString=get_RunStr('CoHeReHo');
        ProcessType='Postprocess';
        VisibleHandleArray=handles.hParaArray.CoheReHo;
        restgui_misc('check_if_smooth_after',hObject);
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_DegreeCentralityRadioBtn(CB_value)
        handles=CB_value.handles;
        hObject=CB_value.hObject;
        RunString=get_RunStr('DegreeCentrality');
        ProcessType='Postprocess';    
        VisibleHandleArray=handles.hParaArray.DegreeCentrality;
        restgui_misc('check_if_smooth_after',hObject);
    end
    
    
    function [RunString,VisibleHandleArray,ProcessType]=run_VMHCRadioBtn(CB_value)
        handles=CB_value.handles;
        RunString=get_RunStr('VMHC');
        ProcessType='Postprocess';
        VisibleHandleArray='';
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_PerAFRadioBtn(CB_value)
       handles=CB_value.handles;
       RunString=get_RunStr('PerAF');
       ProcessType='Postprocess';
       VisibleHandleArray='';
    end
    
    function [RunString,VisibleHandleArray,ProcessType]=run_FunConnectivityRadioBtn(CB_value)
       handles=CB_value.handles;
       RunString=get_RunStr('FunctionalConnectivity');
       ProcessType='Postprocess';
       VisibleHandleArray=handles.hParaArray.FunConnectivity;    
    end


    function [RunString,VisibleHandleArray,ProcessType]=run_GCARadioBtn(CB_value)
       handles=CB_value.handles;
       RunString=get_RunStr('GCA');
       ProcessType='Postprocess';
       VisibleHandleArray=handles.hParaArray.GCA_AwaysVisible; 
    end

