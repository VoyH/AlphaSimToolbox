function run_AVersionCallback(hObject,eventdata)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


handles=guidata(gcf);
   VersionStr='_Advance';


    switch get(hObject,'tag')

          case get_GuiTag('BasicVersionRadioBtn') 
               RadioBtnSet(handles.VersionRadioBtn.Array,hObject);
               close(handles.MainFigure);
               repipl;               
          case get_GuiTag('AdvancedVersionRadioBtn') 
                RadioBtnSet(handles.VersionRadioBtn.Array,hObject);
                
    
        case get_GuiTag('WorkDirectoryBtn')
             run_WorkDirectory(handles);
             RunString='';
             VisibleHandleArray='';
%         case get_GuiTag('DisplayParticipantsBtn');    
%             [RunString,VisibleHandleArray]=run_DisplayParticipants(handles);

        case get_GuiTag('TREdit') 
        case get_GuiTag('ParameterDisplayListbox')
            [RunString,VisibleHandleArray,ProcessType]=run_ParameterDisplayListbox(hObject,handles);            
        case get_GuiTag('EpiDicomtoNiftiChekbox')
             [RunString,VisibleHandleArray,ProcessType]=run_EpiDicomtoNifti(handles);
             
        case get_GuiTag('T1DicomToNiftiChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_T1DicomToNifti(handles);   
            
        case get_GuiTag('RemoveFirstTimePointsChekbox')  
            [RunString,VisibleHandleArray,ProcessType]=run_RemoveFirstTimePoints(handles);  
            
        case get_GuiTag('SliceTimingChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_SliceTiming(handles);   
            
        case get_GuiTag('RealignChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_Realign(handles);   
            
        case get_GuiTag('ReorientFunBeforeCoregChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_ReorientFunBeforeCoreg(handles);
            
        case get_GuiTag('NormalizeEpiChekbox')
             [RunString,VisibleHandleArray,ProcessType]=run_NormalizeEpi(handles);    
             
        case get_GuiTag('ReorientT1BeforeCoregChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_ReorientT1BeforeCoreg(handles);
            
        case get_GuiTag('T1CoregisterFunChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_T1CoregisterFun(handles);

        case get_GuiTag('ReorientT1AfterCoregChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_ReorientT1AfterCoreg(handles);

         case get_GuiTag('T1SegmentChekbox')
              [RunString,VisibleHandleArray,ProcessType]=run_T1Segment(handles);   
              
         case get_GuiTag('NormalizeSegChekbox')
             [RunString,VisibleHandleArray,ProcessType]=run_NormalizeSeg(handles);

        case get_GuiTag('Normalize_T1NewSeg_dartel_Chekbox') 
             [RunString,VisibleHandleArray,ProcessType]=run_NormalizeNewSeg_dartel(handles);
          
        case get_GuiTag('SmoothChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_Smooth(handles);

             
        case get_GuiTag('DetrendChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_Detrend(handles);

            
        case get_GuiTag('FilterChekbox')
             [RunString,VisibleHandleArray,ProcessType]=run_Filter(handles);

            
        case get_GuiTag('RegressOutNuisanceChekbox')
            [RunString,VisibleHandleArray,ProcessType]=run_RegressOutCovariates(handles);




        case get_GuiTag('DefaultmaskRadioBtn')
            [RunString,VisibleHandleArray]=run_DefaultMask(handles,hObject);
        case get_GuiTag('NoMaskRadioBtn')
            [RunString,VisibleHandleArray]=run_NoMask(handles,hObject);
        case get_GuiTag('UserDefinedMaskRadioBtn')
            [RunString,VisibleHandleArray]=run_UserDefinedMask(handles,hObject);

            
            
        case get_GuiTag('AlffRadioBtn')  
            [RunString,VisibleHandleArray,ProcessType]=run_Alff(handles);


        case get_GuiTag('fALFFRadioBtn')
            [RunString,VisibleHandleArray,ProcessType]=run_fALFF(handles);

    
        case get_GuiTag('KccReHoRadioBtn')
            [RunString,VisibleHandleArray,ProcessType]=run_KccReHo(handles);

        case get_GuiTag('CoheReHoRadioBtn')
            [RunString,VisibleHandleArray,ProcessType]=run_CoHeReHo(handles);
            
        case get_GuiTag('DegreeCentralityRadioBtn') 
            [RunString,VisibleHandleArray,ProcessType]=run_DegreeCentrality(handles);

    
        case get_GuiTag('GCARadioBtn')
             [RunString,VisibleHandleArray,ProcessType]=run_GCA(handles);

    
        case get_GuiTag('VMHCRadioBtn')
            [RunString,VisibleHandleArray,ProcessType]=run_VMHC(handles);

    
        case get_GuiTag('PerAFRadioBtn') 
            [RunString,VisibleHandleArray,ProcessType]=run_PerAF(handles);

    
        case get_GuiTag('FunConnectivityRadioBtn') 
             [RunString,VisibleHandleArray,ProcessType]=run_FunctionalConnectivity(handles);

   


        case get_GuiTag('RunPushBtn')
             flaxible_run_pushbutton_callback(handles);
        case get_GuiTag('SavePushBtn')
            restgui_misc('Run_SaveBtn','_Advance',handles);   
        case get_GuiTag('LoadPushBtn')
            restgui_misc('Run_LoadBtn',handles);      
        case get_GuiTag('StopPushBtn')
            run_StopPushBtn(handles,hObject);
        case 'tag_parallel_checkbox'
            parallel_checkbox_callback(hObject,'');
        case 'tag_parallel_text'
        case 'tag_parallel_edit'
            parallel_edit_callback(hObject,'');
        otherwise
            error('Tag is not exist')       
    end

    if (1==exist('RunString','var'))&&(~isempty(RunString)) 
        if strcmp('checkbox',get(hObject,'style'))
           handles=ChekboxValue2ListboxStr(hObject,handles,RunString,ProcessType);
                   Update_AllInOutEdit(handles);
        end
    end
    
    if 1==exist('VisibleHandleArray','var')   
        if strcmp(get(hObject,'style'),'checkbox')||strcmp(get(hObject,'style'),'radiobutton')...
           ||strcmp(get(hObject,'style'),'listbox')     
           updata_GuiVisible(hObject,VisibleHandleArray,handles.hParaAll);
        end
    end
    
if ishghandle(hObject)
    guidata(hObject,handles);
end
end



function handles=ChekboxValue2ListboxStr(hObject,handles,RunString,ProcessType)

    
VersionStr='advance';    
[ListboxPre,ListboxPost]=restgui_misc('Sort_ListboxStr',VersionStr,handles);

    if strcmp('Preprocess',ProcessType)
        ListboxCell=ListboxPre;
    elseif strcmp('Postprocess',ProcessType)
        ListboxCell=ListboxPost;  
    else
        error('error use run_AVersionCallback');

    end


StrIndex=size(ListboxCell,2);
StrIndex=StrIndex+1;

   IsCheked=get(hObject,'value');
   if 1==IsCheked
      ListboxCell{StrIndex}=RunString;
   elseif 0==IsCheked

       for i=1:length(ListboxCell)
           if ~isempty(strfind(ListboxCell{i},RunString))
               ListboxCell(i)=[];
               break;
           end
       end
   else 
       error('ChekboxValue2Listboxstr');
   end


    if strcmp('Preprocess',ProcessType)
        ListboxCellBoth=[ListboxCell ListboxPost];
    elseif strcmp('Postprocess',ProcessType)
        ListboxCellBoth=[ListboxPre ListboxCell ];
    else
        error('error use run_AVersionCallback');

    end  




   ListboxStr=brief_misc('CellArray2Listboxstr',ListboxCellBoth);
   set(handles.UIhandles.ParameterDisplayListbox.handle,...
       'value',1);
   set(handles.UIhandles.ParameterDisplayListbox.handle,...
       'string',ListboxStr);
    
end


function Update_AllInOutEdit(handles)
ParameterDisplayListboxStr=get(handles.UIhandles.ParameterDisplayListbox.handle,'string');
end


function run_WorkDirectory(handles)
     WorkDirectory=uigetdir(pwd,'Please select the work directory');
     set(handles.UIhandles.WorkDirectoryEdit.handle,'string',WorkDirectory);
end





function [RunString,VisibleHandleArray,ProcessType]=run_ParameterDisplayListbox(hObject,handles)
Listindex=get(hObject,'value');
Liststr=get(hObject,'string');
CurrentStr=deblank(Liststr(Listindex,:));
VisibleHandleArray='';
ProcessType='';

if ~isempty(CurrentStr)
    evastring=sprintf('[RunString,VisibleHandleArray,ProcessType]=run_%s(handles);',...
                       get_RunStr(CurrentStr));    
    eval(evastring);    
end
     RunString='';
end




function [RunString,VisibleHandleArray,ProcessType]=run_EpiDicomtoNifti(handles)
             RunString=get_RunStr('EpiDicomtoNifti');
             VisibleHandleArray=handles.hParaArray.EpiDicomToNifti;
             ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_T1DicomToNifti(handles)
             RunString=get_RunStr('T1DicomToNifti');
             VisibleHandleArray=handles.hParaArray.T1DicomToNifti;
             ProcessType='Preprocess'; 
end


function [RunString,VisibleHandleArray,ProcessType]=run_RemoveFirstTimePoints(handles)
             RunString=get_RunStr('RemoveFirstTimePoints');
             VisibleHandleArray=handles.hParaArray.RemoveTimePoints;
             ProcessType='Preprocess';   
end

function [RunString,VisibleHandleArray,ProcessType]=run_SliceTiming(handles)
             RunString=get_RunStr('SliceTiming');
             VisibleHandleArray=handles.hParaArray.SliceTiming;
             ProcessType='Preprocess'; 
end

function [RunString,VisibleHandleArray,ProcessType]=run_Realign(handles)
             RunString=get_RunStr('Realign');  
             VisibleHandleArray=handles.hParaArray.Realign;
              ProcessType='Preprocess';    
end

function [RunString,VisibleHandleArray,ProcessType]=run_ReorientFunBeforeCoreg(handles)
          RunString=get_RunStr('ReorientFunBeforeCoreg');
          VisibleHandleArray=handles.hParaArray.ReorientFunBeforeCoreg;
          ProcessType='Preprocess';              
end

function [RunString,VisibleHandleArray,ProcessType]=run_NormalizeEpi(handles)
             RunString=get_RunStr('NormalizeEpi');
             VisibleHandleArray=handles.hParaArray.NormalizeEpi;
             ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_ReorientT1BeforeCoreg(handles)
          RunString=get_RunStr('ReorientT1BeforeCoreg');
          VisibleHandleArray=handles.hParaArray.ReorientT1BeforeCoreg;
          ProcessType='Preprocess';              
end

function [RunString,VisibleHandleArray,ProcessType]=run_T1CoregisterFun(handles)
            RunString=get_RunStr('T1CoregisterFun');
            VisibleHandleArray=handles.hParaArray.T1CoregisterFun;
             ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_ReorientT1AfterCoreg(handles)
          RunString=get_RunStr('ReorientT1AfterCoreg');
          VisibleHandleArray=handles.hParaArray.ReorientT1AfterCoreg;
          ProcessType='Preprocess'; 
end

function [RunString,VisibleHandleArray,ProcessType]=run_T1Segment(handles)
            RunString=get_RunStr('T1Segment'); 
            VisibleHandleArray=handles.hParaArray.T1Segment;
             ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_NormalizeSeg(handles)
            RunString=get_RunStr('NormalizeSeg'); 
            VisibleHandleArray=handles.hParaArray.NormalizeSeg;
             ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_NormalizeNewSeg_dartel(handles)
 
RunString=get_RunStr('NormalizeNewSeg_dartel'); 
VisibleHandleArray=handles.hParaArray.Normalize_newseg_dartel;
ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_Smooth(handles)
             RunString=get_RunStr('Smooth');
             VisibleHandleArray=handles.hParaArray.Smooth;
             ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_Detrend(handles)
             VisibleHandleArray=handles.hParaArray.Detrend;
             RunString=get_RunStr('Detrend');
              ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_Filter(handles)
             VisibleHandleArray =handles.hParaArray.Filter;
             RunString=get_RunStr('Filter');
              ProcessType='Preprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_RegressOutCovariates(handles)
            VisibleHandleArray=handles.hParaArray.RegressOutNuisance;
             RunString=get_RunStr('RegressOutCovariates');
             ProcessType='Preprocess';

end

function [RunString,VisibleHandleArray]=run_DefaultMask(handles,hObject)        
          VisibleHandleArray='';
          RunString='';
          RadioBtnArray=handles.RadioBtnArray.SetMask;
          RadioBtnSet(RadioBtnArray,hObject);
          updata_GuiVisible(hObject,VisibleHandleArray,handles.hParaAll)
end



function [RunString,VisibleHandleArray]=run_NoMask(handles,hObject)
          VisibleHandleArray='';
          RunString='';
          RadioBtnArray=handles.RadioBtnArray.SetMask;
          RadioBtnSet(RadioBtnArray,hObject);
          updata_GuiVisible(hObject,VisibleHandleArray,handles.hParaAll)

end


function [RunString,VisibleHandleArray]=run_UserDefinedMask(handles,hObject)
          VisibleHandleArray=handles.hParaArray.UserMask;
          RunString='';
          RadioBtnArray=handles.RadioBtnArray.SetMask;
          RadioBtnSet(RadioBtnArray,hObject);
end

function [RunString,VisibleHandleArray,ProcessType]=run_Alff(handles)
              VisibleHandleArray=handles.hParaArray.ALFF;
              RunString=get_RunStr('Alff');
              ProcessType='Postprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_fALFF(handles)
              VisibleHandleArray=handles.hParaArray.fALFF;
              RunString=get_RunStr('fALFF');
              ProcessType='Postprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_KccReHo(handles)
              VisibleHandleArray=handles.hParaArray.KccReHo;
              RunString=get_RunStr('KccReHo');
              ProcessType='Postprocess';              
end

function [RunString,VisibleHandleArray,ProcessType]=run_CoHeReHo(handles)
              VisibleHandleArray=handles.hParaArray.CoHeReHo;
              RunString=get_RunStr('CoHeReHo');
              ProcessType='Postprocess'; 
end

function [RunString,VisibleHandleArray,ProcessType]=run_DegreeCentrality(handles)
              VisibleHandleArray=handles.hParaArray.DegreeCentrality;
              RunString=get_RunStr('DegreeCentrality');
              ProcessType='Postprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_GCA(handles)
              RunString=get_RunStr('GCA');
              ProcessType='Postprocess';
              VisibleHandleArray=handles.hParaArray.GCA;
end

function [RunString,VisibleHandleArray,ProcessType]=run_VMHC(handles)
              VisibleHandleArray=handles.hParaArray.VMHC;
              RunString=get_RunStr('VMHC');
              ProcessType='Postprocess';
end

function [RunString,VisibleHandleArray,ProcessType]=run_PerAF(handles)
              VisibleHandleArray=handles.hParaArray.PerAF;
              RunString=get_RunStr('PerAF');
              ProcessType='Postprocess';
end

function run_StopPushBtn(handles,hObject)
    set(handles.UIhandles.RunBtn.handle,'enable','on',...
        'BackgroundColor',get(hObject,'BackgroundColor'),...
        'ForegroundColor',get(hObject,'ForegroundColor'));
    program_interrupt();
end

function [RunString,VisibleHandleArray,ProcessType]=run_FunctionalConnectivity(handles)
              RunString=get_RunStr('FunctionalConnectivity');
              ProcessType='Postprocess';
              VisibleHandleArray=handles.hParaArray.FunConnectivity;
end








