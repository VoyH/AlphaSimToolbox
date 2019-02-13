function [OperationList,InputParameter,GuiParameter]=repipl_PreDefinedParameter(AOperation)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201407
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



InputParameter=Init_InputParameter();  
switch AOperation
    case get_PreParaStr('blank')
        OperationList='';
        GuiParameter='';
    case get_PreParaStr('KccReHo')
        OperationList={'EpiDicomtoNifti','T1DicomToNifti','RemoveFirstTimePoints',...
                       'SliceTiming','Realign','T1CoregisterFun','T1Segment',...
                       'NormalizeSeg','Detrend','Filter','KccReHo'};
         GuiParameter='';
    case get_PreParaStr('ALFF')
        OperationList={'EpiDicomtoNifti','T1DicomToNifti','RemoveFirstTimePoints',...
                       'SliceTiming','Realign','T1CoregisterFun','T1Segment',...
                       'NormalizeSeg','Smooth','Detrend','Alff'};
         GuiParameter='';        
    case get_PreParaStr('fALFF')
         OperationList={'EpiDicomtoNifti','T1DicomToNifti','RemoveFirstTimePoints',...
                       'SliceTiming','Realign','T1CoregisterFun','T1Segment',...
                       'NormalizeSeg','Smooth','Detrend','fALFF'};       
        GuiParameter='';                  
    case get_PreParaStr('PerAF')
        OperationList={'EpiDicomtoNifti','T1DicomToNifti','RemoveFirstTimePoints',...
                       'SliceTiming','Realign','T1CoregisterFun','T1Segment',...
                       'NormalizeSeg','Smooth','Detrend','Filter','PerAF'};  
         GuiParameter='';                                    
    case get_PreParaStr('DegreeCentrality')
        OperationList={'EpiDicomtoNifti','T1DicomToNifti','RemoveFirstTimePoints',...
                       'SliceTiming','Realign','T1CoregisterFun','T1Segment',...
                       'NormalizeSeg','Smooth','Detrend','Filter','RegressOutCovariates','DegreeCentrality'}; 
         GuiParameter='';                                    
    case get_PreParaStr('VMHC')
        OperationList={'EpiDicomtoNifti','T1DicomToNifti','RemoveFirstTimePoints',...
                       'SliceTiming','Realign','T1CoregisterFun','T1Segment',...
                       'NormalizeSeg','Smooth','Detrend','Filter','RegressOutCovariates','VMHC'};    
        GuiParameter='';                                     
    otherwise
            error('wrong repipl_PredefinedParameter');
        

end
end



function InputParameter=Init_InputParameter()

    InputParameter.RemoveFirstTimePoints.TimePointsAmount=10;
    InputParameter.SliceTiming.SliceNumber=33;
    InputParameter.SliceTiming.SliceOrder=[1:2:33 2:2:32];
    InputParameter.SliceTiming.ReferenceSlice=33;
    InputParameter.Normalize.EPI.BoundingBox=[-90 -126 -72;90 90 108];
    InputParameter.Normalize.EPI.VoxSize=[3 3 3];
    InputParameter.AffineRegularisation='mni';
    InputParameter.NormalizeSeg.BoundingBox=[-90 -126 -72;90 90 108];
    InputParameter.NormalizeSeg.VoxSize=[3 3 3];
    InputParameter.Smooth.Gaussian.FWHM=[6 6 6];
    InputParameter.Filter.LowPass_HighCutoff=0.08;
    InputParameter.Filter.HighPass_LowCutoff=0.01;
    InputParameter.RegressOutCovariates.OtherCovariatesROIList='';
    InputParameter.RegressOutCovariates.IsWholeBrain=0; 
    InputParameter.RegressOutCovariates.IsCSF=0;
    InputParameter.RegressOutCovariates.IsWhiteMatter=0;
    InputParameter.RegressOutCovariates.IsHeadMotion_Rigidbody6=0;
    InputParameter.RegressOutCovariates.IsOtherCovariatesROI=0;
    
    InputParameter.alff.LowPass_HighCutoff=0.08;
    InputParameter.alff.HighPass_LowCutoff=0.01;
    InputParameter.fALFF.LowPass_HighCutoff=0.08;
    InputParameter.fALFF.HighPass_LowCutoff=0.01;
    InputParameter.KccReHo.NVoxel=27;
    InputParameter.KccReHo.IsSmooth=1;
    InputParameter.KccReHo.SmoothFWHM=[6 6 6];
    InputParameter.DegreeCentrality.rThreshold=0.5;


end