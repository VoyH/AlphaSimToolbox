function OutputTag=get_GuiTag(AOperation)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



switch AOperation 
    case 'ParameterDisplayListbox'
        OutputTag='ParameterDisplayListbox';
        
    case 'PreDefinedParameterPpmenu'
        OutputTag='PreDefinedParameterPpmenu';
        
    case 'BasicVersionRadioBtn'
        OutputTag='DefaultOrderRadiobutton';        
    case 'AdvancedVersionRadioBtn'
        OutputTag='UserOrderRadiobutton';
        
 
        
        
    case 'WorkDirectoryText'
        OutputTag='WorkDirectoryText';       
    case 'WorkDirectoryEdit'
        OutputTag='WorkDirectoryEdit';
    case 'WorkDirectoryBtn'
        OutputTag='WorkDirectoryBtn';
      
        
        
        
        
    case 'StartDirectoryEpiText'
         OutputTag='StartDirectoryEpiText';
    case 'StartDirectoryEpiEdit'     
        OutputTag='StartDirectoryEpiEdit';
    case 'StartDirectoryT1Text'
        OutputTag='StartDirectoryT1Text';
    case 'StartDirectoryT1Edit'
        OutputTag='StartDirectoryT1Edit';        

        
        
        
        
    case 'TRText' 
        OutputTag='TRText';       
    case 'TREdit' 
        OutputTag='TREdit';
        
     
    case 'DisplayParticipantsBtn'
        OutputTag='DisplayParticipantsBtn';
        
        
%     case 'TimePointsEdit'  %   future will be delete
%         OutputTag='TimePointsEdit';%   future will be delete
        
        
       

        
        
        
    case 'DicomToNiftiChekbox' 
        OutputTag='DicomToNiftiChekbox';
    case 'EpiDicomtoNiftiChekbox'
        OutputTag='EpiDicomtoNiftiChekbox';
    case 'T1DicomToNiftiChekbox'
        OutputTag='T1DicomToNiftiChekbox';

        
    case 'RemoveFirstTimePointsChekbox' 
        OutputTag='RemoveFirstTimePointsChekbox';
        
    case 'SliceTimingChekbox'        
        OutputTag='SliceTimingChekbox';
        
    case 'RealignChekbox' 
        OutputTag='RealignChekbox';
 

% Reorient..........................................................        
    case 'ReorientChekbox'
        OutputTag='ReorientChekbox';
    case 'ReorientFunBeforeCoregChekbox'
        OutputTag='ReorientFunBeforeCoregChekbox';
    case 'ReorientT1BeforeCoregChekbox'
        OutputTag='ReorientT1BeforeCoregChekbox';
    case 'ReorientT1AfterCoregChekbox'
        OutputTag='ReorientT1AfterCoregChekbox';
        
% Normalize.......................................................        
    % Basic version     
    case 'NormalizeChekbox'
        OutputTag='NormalizeChekbox';
    case 'NormalizeEpiRadioBtn'
        OutputTag='NormalizeEpiRadioBtn';
    case 'NormalizeSegRadioBtn'
        OutputTag='NormalizeSegRadioBtn';
    case 'NormalizeSymT1segRadiobutton'
        OutputTag='NormalizeSymT1segRadiobutton';
    case 'Normalize_T1NewSeg_dartel_RadioBtn'
        OutputTag='Normalize_T1NewSeg_dartel_RadioBtn';
    case 'SegEastAsianRadioBtn'
        OutputTag='SegEastAsianRadioBtn';
    case 'SegEuropeanRadioBtn'
        OutputTag='SegEuropeanRadioBtn';
    % Advance version    
    case 'NormalizeEpiChekbox' 
        OutputTag='NormalizeEpiChekbox';
    case 'NormalizeSegChekbox'
        OutputTag='NormalizeSegChekbox';
    case 'Normalize_T1NewSeg_dartel_Chekbox'
        OutputTag='Normalize_T1NewSeg_dartel_Chekbox';
    case 'NormalizeSymT1segChekbox'
        OutputTag='NormalizeSymT1segChekbox';
    case 'T1CoregisterFunChekbox'
        OutputTag='T1CoregisterFunChekbox';
    case 'T1SegmentChekbox'
        OutputTag='T1SegmentChekbox';
        
% Smooth................................................................        
    case 'SmoothChekbox'
        OutputTag='SmoothChekbox';
        
    case 'DetrendChekbox'
        OutputTag='DetrendChekbox';
        
        
        
    case 'RegressOutNuisanceChekbox'
        OutputTag='RegressOutNuisanceChekbox';
    case 'RegressOutOtherCovariatesChekBox'
         OutputTag='RegressOutOtherCovariatesChekBox';
    case 'RegressOutCSFChekbox'  
         OutputTag='RegressOutCSFChekbox';
    case 'RegressOutWhiteMatterChekbox'
        OutputTag='RegressOutWhiteMatterChekbox';
    case 'RegressOutGlobalMeanChekbox'   
        OutputTag='RegressOutGlobalMeanChekbox';
    case 'RegressOut6HeadMotionChekbox'
        OutputTag='RegressOut6HeadMotionChekbox';
        
        
    case 'FilterChekbox'
        OutputTag='FilterChekbox';
        
        
        
        
    case 'DefaultmaskRadioBtn'
        OutputTag='DefaultmaskRadiobutton';
     
    case 'NoMaskRadioBtn'
        OutputTag='NoMaskRadiobutton';
        
    case 'UserDefinedMaskRadioBtn'
        OutputTag='UserDefinedMaskRadiobutton';
        
        
        
        
    case 'AlffRadioBtn'
        OutputTag='AlffRadiobutton';
        
    case 'fALFFRadioBtn'
        OutputTag='fALFFRadiobutton';
        
%     case 'ReHoRadioBtn'
%         OutputTag='ReHoradiobutton';
    case 'KccReHoRadioBtn'
        OutputTag='KccReHoradiobutton';        

    case 'CoheReHoRadioBtn'
        OutputTag='CoheReHoRadioBtn';
     case 'PerAFRadioBtn'
        OutputTag='PerAFRadiobutton';
        
    case 'DegreeCentralityRadioBtn'
        OutputTag='DegreeCentralityRadiobutton';
        

        
    case 'VMHCRadioBtn'
        OutputTag='VMHCRadiobutton';

% FunConnectivity............................................         
    case 'FunConnectivityRadioBtn'
        OutputTag='FunConnectivityRadioBtn';
    case 'FunConnectivityVoxelWiseRadioBtn'    
        OutputTag='FunConnectivityVoxelWiseRadioBtn';
    case 'FunConnectivityROIWiseRadioBtn'
        OutputTag='FunConnectivityROIWiseRadioBtn';
    case 'FunConnectivityDefineROIBtn'
        OutputTag='FunConnectivityDefineROIBtn';
% GCA..............................................        
    case 'GCARadioBtn'
        OutputTag='GCARadiobutton';        
    case 'GCAVoxelWiseRadioBtn'
         OutputTag='GCAVoxelWiseRadioBtn';
    case 'GCAROIWiseRadioBtn'
         OutputTag='GCAROIWiseRadioBtn';
    case 'GCADefineROIBtn'
         OutputTag='GCADefineROIBtn';
    case 'GCACoefficient_basedRadioBtn'
        OutputTag='GCACoefficient_basedRadioBtn';
    case 'GCAResidual_basedRadioBtn'
        OutputTag='GCAResidual_basedRadioBtn';
    case 'GCABivariateCoefficientsRadioBtn'
        OutputTag='GCABivariateCoefficientsRadioBtn';
    case 'GCAMultivariateCofficientsRadioBtn'
        OutputTag='GCAMultivariateCofficientsRadioBtn';
%.........................................................        
    case 'RunPushBtn'
        OutputTag='RunPushbutton';
    case 'SavePushBtn'
        OutputTag='SavePushBtn';
    case 'LoadPushBtn'
        OutputTag='LoadPushBtn';
    case 'StopPushBtn'
        OutputTag='StopPushBtn';

    otherwise
            error('get_GuiTag');
end













