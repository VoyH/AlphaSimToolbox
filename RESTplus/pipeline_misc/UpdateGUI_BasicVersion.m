function UpdateGUI_BasicVersion(OperationList,handles,InputParameter,GuiParameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



    clean_AllGUIvalue(handles);
    for i=1:length(OperationList)
        updata_gui(OperationList{i},handles,InputParameter);
    end
    UpdateParaListbox_BVersion(handles);
    
    

end
function clean_AllGUIvalue(handles)
  set(handles.UIhandles.ParameterDisplayListbox.handle,'string','');
  for j=1:length(handles.AllValueHandles)
            set(handles.AllValueHandles(j),'value',0);
  end
end

function updata_gui(AOperation,handles,InputParameter)

switch AOperation
    case get_RunStr('EpiDicomtoNifti')
        set(handles.hPara.DicomToNifti.EpiChekbox,'value',1);
        set(handles.UIhandles.DicomToNiftiChekbox.handle,'value',1);
    case get_RunStr('T1DicomToNifti')
        set(handles.hPara.DicomToNifti.T1Chekbox,'value',1);
        set(handles.UIhandles.DicomToNiftiChekbox.handle,'value',1);
    case get_RunStr('RemoveFirstTimePoints')
        set(handles.UIhandles.RemoveFirstTimePointsChekbox.handle,'value',1);
        set(handles.hPara.RemoveTimePoints.AmountEdit,'string',num2str(InputParameter.RemoveFirstTimePoints.TimePointsAmount));
    case get_RunStr('SliceTiming')
        set(handles.UIhandles.SliceTimingChekbox.handle,'value',1);
        set(handles.hPara.SliceTiming.SliceNumberEdit,'string',num2str(InputParameter.SliceTiming.SliceNumber));
        set(handles.hPara.SliceTiming.SliceOrderEdit,'string',num2str(InputParameter.SliceTiming.SliceOrder));
        set(handles.hPara.SliceTiming.ReferenceSliceEdit,'string',num2str(InputParameter.SliceTiming.ReferenceSlice))        
    case get_RunStr('Realign')
        set(handles.UIhandles.RealignChekbox.handle,'value',1);
    case get_RunStr('ReorientFunBeforeCoreg')
        set(handles.UIhandles.ReorientChekbox.handle,'value',1);
        set(handles.hPara.Reorient.BeforeCoregiser,'value',1);
    case get_RunStr('ReorientT1BeforeCoreg')
        set(handles.UIhandles.ReorientChekbox.handle,'value',1);   
        set(handles.hPara.Reorient.BeforeCoregiser,'value',1);        
    case get_RunStr('ReorientT1AfterCoreg')
        set(handles.UIhandles.ReorientChekbox.handle,'value',1);
        set(handles.hPara.Reorient.AfterCoregiser,'value',1);
    case get_RunStr('NormalizeEpi')
        set(handles.UIhandles.NormalizeChekbox.handle,'value',1);
        set(handles.hPara.Normalize.EpiRadiobutton,'value',1);
        set(handles.hPara.Normalize.BoundingBoxEdit,'string',num2str(InputParameter.Normalize.EPI.BoundingBox));
        set(handles.hPara.Normalize.VoxSizeEdit,'string',num2str(InputParameter.Normalize.EPI.VoxSize));
    case get_RunStr('T1CoregisterFun')
        set(handles.UIhandles.NormalizeChekbox.handle,'value',1);   
        set(handles.hPara.Normalize.T1segRadiobutton,'value',1);
        
    case get_RunStr('T1Segment')
        set(handles.UIhandles.NormalizeChekbox.handle,'value',1);  
        set(handles.hPara.Normalize.T1segRadiobutton,'value',1);
        if strcmp(InputParameter.AffineRegularisation,'mni')
            set(handles.hPara.Normalize.SegmentEuropeanRadio,'value',1);
        elseif strcmp(InputParameter.AffineRegularisation,'eastern')
            set(handles.hPara.Normalize.SegmentEastAsianRadio,'value',1);
        else
            error('wrong UpdataGUI_BasicVersion');
        end
        
    case get_RunStr('NormalizeSeg')
        set(handles.UIhandles.NormalizeChekbox.handle,'value',1); 
        set(handles.hPara.Normalize.T1segRadiobutton,'value',1);
    case get_RunStr('Smooth')
        set(handles.UIhandles.SmoothChekbox.handle,'value',1);
        set(handles.hPara.Smooth.FWHMEdit,'string',num2str(InputParameter.Smooth.Gaussian.FWHM));
    case get_RunStr('Detrend')
        set(handles.UIhandles.DetrendChekbox.handle,'value',1);
    case get_RunStr('Filter')
        set(handles.UIhandles.FilterChekbox.handle,'value',1);
    case get_RunStr('RegressOutCovariates')
        
        set(handles.UIhandles.RegressOutCovariatesChekbox.handle,'value',1);
        
        if 1==InputParameter.RegressOutCovariates.IsWholeBrain   
            set(handles.hPara.RegressOutNuisance.GlobalMean,'value',1);
        elseif 1==InputParameter.RegressOutCovariates.IsCSF;
            set(handles.hPara.RegressOutNuisance.CSF,'value',1);
        elseif 1==InputParameter.RegressOutCovariates.IsWhiteMatter;
            set(handles.hPara.RegressOutNuisance.WhiteMatter,'value',1);
        elseif 1==InputParameter.RegressOutCovariates.IsHeadMotion_Rigidbody6;
            set(handles.hPara.RegressOutNuisance.HeadMotion6Para,'value',1);
        elseif  1==InputParameter.RegressOutCovariates.IsOtherCovariatesROI;
            set(handles.hPara.RegressOutNuisance.OtherCovariatesChekbox,'value',1);
            OtherCovariatesROIList=InputParameter.RegressOutCovariates.OtherCovariatesROIList;
            OtherCovariatesROIListboxStr=brief_misc('CellArray2Listboxstr',OtherCovariatesROIList);
            set(handles.hPara.RegressOutNuisance.OtherCovariatesListbox,OtherCovariatesROIListboxStr);
        end


        
    case get_RunStr('Alff')
        set(handles.UIhandles.AlffRadioBtn.handle,'value',1);
        set(handles.hPara.ALFF.BandLowEdit,'string',num2str(InputParameter.alff.HighPass_LowCutoff));
        set(handles.hPara.ALFF.BandHighEdit,'string',num2str(InputParameter.alff.LowPass_HighCutoff));
    case get_RunStr('fALFF')
        set(handles.UIhandles.fALFFRadioBtn.handle,'value',1);
        set(handles.hPara.fALFF.BandLowEdit,'string',num2str(InputParameter.fALFF.HighPass_LowCutoff));
        set(handles.hPara.fALFF.BandHighEdit,'string',num2str(InputParameter.fALFF.LowPass_HighCutoff));       
    case get_RunStr('KccReHo')
        set(handles.UIhandles.KccReHoRadioBtn.handle,'value',1);
        if 27==InputParameter.KccReHo.NVoxel
            set(handles.hPara.KccReHo.Cluster27RadioBtn,'value',1);
        elseif 19==InputParameter.KccReHo.NVoxel
            set(handles.hPara.KccReHo.Cluster19RadioBtn,'value',1);
        elseif 7==InputParameter.KccReHo.NVoxel
            set(handles.hPara.KccReHo.Cluster7RadioBtn,'value',1);
        end
        
        if 1==InputParameter.KccReHo.IsSmooth
            set(handles.hPara.KccReHo.SmKccReHoChekbox,'value',1);
            set(handles.hPara.KccReHo.SmKccReHoFWHMedit,'string',num2str(InputParameter.KccReHo.SmoothFWHM),...
                'Enable','on');
        end
    case get_RunStr('PerAF')
        set(handles.UIhandles.PerAFRadioBtn.handle,'value',1);
    case get_RunStr('DegreeCentrality')
         set(handles.UIhandles.DegreeCentralityRadioBtn.handle,'value',1); 
         set(handles.hPara.DegreeCentrality.RCorrThreEdit,'string',num2str(InputParameter.DegreeCentrality.rThreshold));
    case get_RunStr('VMHC')
        set( handles.UIhandles.VMHCRadioBtn.handle,'value',1);
        
end

end