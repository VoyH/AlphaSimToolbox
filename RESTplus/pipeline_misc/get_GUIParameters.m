function [InputParameter PListOut]=get_GUIParameters(AOperation,InputParameter,handles)

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


% handles.PostProcessMaskfile
LabelIndex=1;
ParaIndex=2;

TR=str2double(get(handles.UIhandles.TREdit.handle,'string'));

if (1==get(handles.UIhandles.BasicVersionRadioBtn.handle,'value'))&&...
   (0==get(handles.UIhandles.AdvancedVersionRadioBtn.handle,'value'))
    ProgramVersion='BasicVersion';
elseif (0==get(handles.UIhandles.BasicVersionRadioBtn.handle,'value'))&&...
   (1==get(handles.UIhandles.AdvancedVersionRadioBtn.handle,'value'))
    ProgramVersion='AdvancedVersion';
else
    error('run use get_GUIParameters');
end



switch AOperation
    case 'EpiDicomtoNifti'
          PListOut='';
    case 'T1DicomToNifti'
          PListOut='';
    case 'RemoveFirstTimePoints'  
          [InputParameter,PListOut]=getGUIPara_RemoveFirstTimePoints(InputParameter,handles,LabelIndex,ParaIndex);       
    case 'SliceTiming'  
          [InputParameter,PListOut]=getGUIPara_SliceTiming(InputParameter,handles,TR,LabelIndex,ParaIndex);            
    case 'Realign'       
         PListOut='';
    case 'ReorientFunBeforeCoreg'
         PListOut='';
    case 'ReorientT1BeforeCoreg'
         PListOut='';
    case 'NormalizeEpi'  
          [InputParameter,PListOut]=getGUIPara_NormalizeEpi(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex);        
    case 'T1CoregisterFun'   
         PListOut='';
    case 'ReorientT1AfterCoreg'
        PListOut='';        
    case 'T1Segment'   
         [InputParameter,PListOut]=getGUIPara_T1Segment(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex);        
    case 'NormalizeSeg'
         [InputParameter,PListOut]=getGUIPara_NormalizeSeg(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex);  
    case 'NormalizeNewSeg_dartel'
         [InputParameter,PListOut]=getGUIPara_NormalizeNewSeg_dartel(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex);
    case 'NormalizeSymSeg'
         [InputParameter,PListOut]=getGUIPara_NormalizeSymSeg(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex);  
    case 'Smooth'
        [InputParameter,PListOut]=getGUIPara_Smooth(InputParameter,handles,LabelIndex,ParaIndex);
    case 'Detrend'
          InputParameter.Detrend.CutNumber=10;
          PListOut='';
    case 'Filter'       
        [InputParameter,PListOut]=getGUIPara_Filter(InputParameter,handles,TR,LabelIndex,ParaIndex);           
    case 'RegressOutCovariates'        
        [InputParameter,PListOut]=getGUIPara_RegressOutCovariates(InputParameter,handles,LabelIndex,ParaIndex);          
    case 'Alff'
        [InputParameter,PListOut]=getGUIPara_Alff(InputParameter,handles,TR,LabelIndex,ParaIndex);                 
    case 'fALFF'
        [InputParameter,PListOut]=getGUIPara_fALFF(InputParameter,handles,TR,LabelIndex,ParaIndex);                 
    case 'KccReHo'
        [InputParameter,PListOut]=getGUIPara_KccReHo(InputParameter,handles,LabelIndex,ParaIndex);
    case 'CoHeReHo'
        [InputParameter,PListOut]=getGUIPara_CoheReHo(InputParameter,handles,TR,LabelIndex,ParaIndex);
    case 'FunctionalConnectivity'
        [InputParameter,PListOut]=getGUIPara_FunctionalConnectivity(InputParameter,handles,LabelIndex,ParaIndex);
    case 'VMHC'
        [InputParameter,PListOut]=getGUIPara_VMHC(InputParameter,handles);
    case 'PerAF'
        [InputParameter,PListOut]=getGUIPara_PerAF(InputParameter,handles);
    case 'DegreeCentrality'
       [InputParameter,PListOut]=getGUIPara_DegreeCentrality(InputParameter,handles,LabelIndex,ParaIndex);             
    case 'GCA'
       [InputParameter,PListOut]=getGUIPara_GCA(InputParameter,handles,LabelIndex,ParaIndex);          
    otherwise
        error('wrong get_GUIParameters %s is not exist',AOperation);
end   

% end

end



function [InputParameter,PListOut]=getGUIPara_RemoveFirstTimePoints(InputParameter,handles,LabelIndex,ParaIndex)

   InputParameter.RemoveFirstTimePoints.TimePointsAmount=str2double(get(handles.hPara.RemoveTimePoints.AmountEdit,'string'));
   PListOut{1,LabelIndex}='Remove Time Points Amount:';
   PListOut{1,ParaIndex}=get(handles.hPara.RemoveTimePoints.AmountEdit,'string');
end


function [InputParameter,PListOut]=getGUIPara_SliceTiming(InputParameter,handles,TR,LabelIndex,ParaIndex)

         InputParameter.SliceTiming.SliceNumber=str2double(get(handles.hPara.SliceTiming.SliceNumberEdit,'string'));
         SliceOrder=get( handles.hPara.SliceTiming.SliceOrderEdit,'string');
         InputParameter.SliceTiming.SliceOrder=eval(['[',SliceOrder,']']);        
         InputParameter.SliceTiming.ReferenceSlice=str2double(get(handles.hPara.SliceTiming.ReferenceSliceEdit ,'string'));
         InputParameter.SliceTiming.TR=TR;
         
         PListOut{1,LabelIndex}='Slice Number:';
         PListOut{1,ParaIndex}=get(handles.hPara.SliceTiming.SliceNumberEdit,'string');
         PListOut{2,LabelIndex}='Slice Order:';
         PListOut{2,ParaIndex}=num2str(InputParameter.SliceTiming.SliceOrder);
         PListOut{3,LabelIndex}='Reference Slice:';
         PListOut{3,ParaIndex}=get(handles.hPara.SliceTiming.ReferenceSliceEdit ,'string');
         PListOut{4,LabelIndex}='TR:';
         PListOut{4,ParaIndex}=num2str(TR);      
end




function [InputParameter,PListOut]=getGUIPara_NormalizeEpi(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex)


         
         [BoundingBox,VoxelSize]=get_boundingbox_voxelsize(ProgramVersion,handles);
         
         InputParameter.Normalize.EPI.BoundingBox=eval(['[',BoundingBox,']']); 
         InputParameter.Normalize.EPI.VoxSize=eval(['[',VoxelSize,']']);
         PListOut{1,LabelIndex}='BoundingBox:';
         PListOut{1,ParaIndex}=BoundingBox;
         PListOut{2,LabelIndex}='VoxelSize:';
         PListOut{2,ParaIndex}=VoxelSize;

end





function [InputParameter,PListOut]=getGUIPara_T1Segment(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex)

       [run_string_affine_regularisation,log_string_affine_regularisation]...
                                =get_affine_regularisation(ProgramVersion,handles);
        InputParameter.AffineRegularisation=run_string_affine_regularisation;
        PListOut{1,LabelIndex}='Segment Template:';
        PListOut{1,ParaIndex}=log_string_affine_regularisation;
end




function [InputParameter,PListOut]=getGUIPara_NormalizeSeg(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex)

         
         [BoundingBox,VoxelSize]=get_boundingbox_voxelsize(ProgramVersion,handles);
         InputParameter.NormalizeSeg.BoundingBox=eval(['[',BoundingBox,']']);
         InputParameter.NormalizeSeg.VoxSize=eval(['[',VoxelSize,']']); 
                
         PListOut{1,LabelIndex}='BoundingBox:';
         PListOut{1,ParaIndex}=BoundingBox;
         PListOut{2,LabelIndex}='VoxelSize:';
         PListOut{2,ParaIndex}=VoxelSize;     
         
end

function [InputParameter,PListOut]=getGUIPara_NormalizeNewSeg_dartel(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex)
    if strcmp(ProgramVersion,'BasicVersion')
        [BoundingBox,VoxelSize]=get_boundingbox_voxelsize(ProgramVersion,handles);
        [run_string_affine_regularisation,log_string_affine_regularisation]...
                                    =get_affine_regularisation(ProgramVersion,handles);
    elseif strcmp(ProgramVersion,'AdvancedVersion')
            BoundingBox=get(handles.hPara.Normalize_newseg_dartel.BoundingBoxEdit,'string');
            VoxelSize=get(handles.hPara.Normalize_newseg_dartel.VoxSizeEdit,'string');    
         
          if 1==get(handles.hPara.Normalize_newseg_dartel.SegmentEuropeanRadio,'value')
             run_string_affine_regularisation='mni';
             log_string_affine_regularisation='European';              
          elseif 1==get(handles.hPara.T1Segment.SegmentEastAsianRadio,'value')
             run_string_affine_regularisation='eastern';
             log_string_affine_regularisation='EastAsian';                 
          else
              error('get_GUIParameters');
          end
    end
          
                            
    InputParameter.Normalize.dartel.BoundingBox=eval(['[',BoundingBox,']']);
    InputParameter.Normalize.dartel.VoxSize=eval(['[',VoxelSize,']']);
    InputParameter.Normalize.dartel.AffineRegularisation=run_string_affine_regularisation;
    
    PListOut{1,LabelIndex}='BoundingBox:';
    PListOut{1,ParaIndex}=BoundingBox;
    PListOut{2,LabelIndex}='VoxelSize:';
    PListOut{2,ParaIndex}=VoxelSize;
    PListOut{3,LabelIndex}='AffineRegularisation:';
    PListOut{3,ParaIndex}=log_string_affine_regularisation;
         
end

function [InputParameter,PListOut]=getGUIPara_NormalizeSymSeg(InputParameter,handles,ProgramVersion,LabelIndex,ParaIndex)
        
        [BoundingBox,VoxelSize]=get_boundingbox_voxelsize(ProgramVersion,handles);
        [run_string_affine_regularisation,log_string_affine_regularisation]...
                                =get_affine_regularisation(ProgramVersion,handles);
        
        InputParameter.Normalize.Seg_Sym.BoundingBox=eval(['[',BoundingBox,']']);
        InputParameter.Normalize.Seg_Sym.VoxSize=eval(['[',VoxelSize,']']); 
        InputParameter.Normalize.Seg_Sym.AffineRegularisation=run_string_affine_regularisation;

        PListOut{1,LabelIndex}='BoundingBox:';
        PListOut{1,ParaIndex}=BoundingBox;
        PListOut{2,LabelIndex}='VoxelSize:';
        PListOut{2,ParaIndex}=VoxelSize;
        PListOut{3,LabelIndex}='AffineRegularisation:';
        PListOut{3,ParaIndex}=log_string_affine_regularisation;
end


function [InputParameter,PListOut]=getGUIPara_Smooth(InputParameter,handles,LabelIndex,ParaIndex)
          SmoothFWHM=get(handles.hPara.Smooth.FWHMEdit,'string');
          InputParameter.Smooth.Gaussian.FWHM=eval(['[',SmoothFWHM,']']);
          PListOut{1,LabelIndex}='FWHM:';
          PListOut{1,ParaIndex}=SmoothFWHM;
end




function [InputParameter,PListOut]=getGUIPara_Filter(InputParameter,handles,TR,LabelIndex,ParaIndex)

          InputParameter.Filter.InFileMask=0;
          InputParameter.Filter.SamplePeriod=TR;
          InputParameter.Filter.LowPass_HighCutoff=str2double(get(handles.hPara.Filter.BandHighEdit ,'string'));
          InputParameter.Filter.HighPass_LowCutoff=str2double(get(handles.hPara.Filter.BandLowEdit ,'string'));
          InputParameter.Filter.IsAddMeanBack='Yes';
          InputParameter.Filter.CutNumber=10;   
          PListOut{1,LabelIndex}='Filter band:';
          PListOut{1,ParaIndex}=[num2str(InputParameter.Filter.HighPass_LowCutoff) ...
                                '~' ...
                                num2str(InputParameter.Filter.LowPass_HighCutoff)]; 
end



function [InputParameter,PListOut]=getGUIPara_RegressOutCovariates(InputParameter,handles,LabelIndex,ParaIndex)
            InputParameter.RegressOutCovariates.IsWholeBrain=get( handles.hPara.RegressOutNuisance.GlobalMean,'value');
            InputParameter.RegressOutCovariates.IsCSF=get(handles.hPara.RegressOutNuisance.CSF,'value');
            InputParameter.RegressOutCovariates.IsWhiteMatter=get( handles.hPara.RegressOutNuisance.WhiteMatter,'value');
            InputParameter.RegressOutCovariates.IsHeadMotion_Rigidbody6=get( handles.hPara.RegressOutNuisance.HeadMotion6Para ,'value');
            InputParameter.RegressOutCovariates.IsOtherCovariatesROI=get(handles.hPara.RegressOutNuisance.OtherCovariatesChekbox,'value');
            InputParameter.RegressOutCovariates.IsRemoveIntercept=get(handles.hPara.RegressOutNuisance.not_add_mean_back_RadioBtn,'value');
            InputParameter.RegressOutCovariates.PolynomialTrend=str2double(get(handles.hPara.RegressOutNuisance.PolynomialTrendEdit,'string'));
            if 1==InputParameter.RegressOutCovariates.IsOtherCovariatesROI
                OtherCovariatesListboxStr=get(handles.hPara.RegressOutNuisance.OtherCovariatesListbox,'string');
                OtherCovariatesROIList=brief_misc('ListboxStr2CellArray',OtherCovariatesListboxStr);
            else
                OtherCovariatesROIList='';
            end
           InputParameter.RegressOutCovariates.OtherCovariatesROIList=OtherCovariatesROIList;
          PListOut{1,LabelIndex}='If remove global mean signal';
          PListOut{1,ParaIndex}=restgui_misc('RadioValue2YesNo',InputParameter.RegressOutCovariates.IsWholeBrain);
          PListOut{2,LabelIndex}='If remove CSF signal';
          PListOut{2,ParaIndex}=restgui_misc('RadioValue2YesNo',InputParameter.RegressOutCovariates.IsCSF);
          PListOut{3,LabelIndex}='If remove WhiteMatter signal';
          PListOut{3,ParaIndex}=restgui_misc('RadioValue2YesNo',InputParameter.RegressOutCovariates.IsWhiteMatter);
          PListOut{4,LabelIndex}='If remove head motion(Rigidbody6)';
          PListOut{4,ParaIndex}=restgui_misc('RadioValue2YesNo',InputParameter.RegressOutCovariates.IsHeadMotion_Rigidbody6); 
          PListOut{5,LabelIndex}='If add mean back?';
          PListOut{5,ParaIndex}=restgui_misc('RadioValue2YesNo',~InputParameter.RegressOutCovariates.IsRemoveIntercept);
          PListOut{6,LabelIndex}='Polynomial Trend';
          PListOut{6,ParaIndex}=num2str(InputParameter.RegressOutCovariates.PolynomialTrend);
          PListOut{7,LabelIndex}='OtherCovariatesList';
          PListOut{7,ParaIndex}=brief_misc('CellArray2Listboxstr',OtherCovariatesROIList);
end



function [InputParameter,PListOut]=getGUIPara_Alff(InputParameter,handles,TR,LabelIndex,ParaIndex)
            InputParameter.alff.SamplePeriod=TR;
            InputParameter.alff.LowPass_HighCutoff=str2double(get(handles.hPara.ALFF.BandHighEdit ,'string'));
            InputParameter.alff.HighPass_LowCutoff=str2double(get(handles.hPara.ALFF.BandLowEdit ,'string'));
            InputParameter.alff.CutNumber=10;
            PListOut{1,LabelIndex}='ALFF band';
            PListOut{1,ParaIndex}=[num2str(InputParameter.alff.HighPass_LowCutoff)...
                                   '~' ...
                                   num2str(InputParameter.alff.LowPass_HighCutoff)];
end



function [InputParameter,PListOut]=getGUIPara_fALFF(InputParameter,handles,TR,LabelIndex,ParaIndex)
            InputParameter.fALFF.SamplePeriod=TR;
            InputParameter.fALFF.LowPass_HighCutoff=str2double(get(handles.hPara.fALFF.BandHighEdit ,'string'));
            InputParameter.fALFF.HighPass_LowCutoff=str2double(get(handles.hPara.fALFF.BandLowEdit ,'string'));
            InputParameter.fALFF.CutNumber=10;
            PListOut{1,LabelIndex}='fALFF band';
            PListOut{1,ParaIndex}= [num2str(InputParameter.fALFF.HighPass_LowCutoff) ...
                                    '~' ...
                                    num2str(InputParameter.fALFF.LowPass_HighCutoff)];
end



function [InputParameter,PListOut]=getGUIPara_KccReHo(InputParameter,handles,LabelIndex,ParaIndex)
        
           if 1==get(handles.hPara.KccReHo.Cluster7RadioBtn,'value')
                NVoxel=7;
           elseif 1==get(handles.hPara.KccReHo.Cluster19RadioBtn,'value')
               NVoxel=19;
           elseif 1==get(handles.hPara.KccReHo.Cluster27RadioBtn,'value')
               NVoxel=27;
           else
               error('KccReHo Run_HandlesCallback');
           end
           
           InputParameter.KccReHo.IsSmooth=get(handles.hPara.KccReHo.SmKccReHoChekbox,'value');
           SmoothFWHM=get(handles.hPara.KccReHo.SmKccReHoFWHMedit,'string');
           InputParameter.KccReHo.SmoothFWHM=eval(['[',SmoothFWHM,']']);
           InputParameter.KccReHo.NVoxel=NVoxel;
           InputParameter.KccReHo.CutNumber=10; 
           
            PListOut{1,LabelIndex}='NVoxels';
            PListOut{1,ParaIndex}=num2str(NVoxel);
            PListOut{2,LabelIndex}='If Smooth KCC-ReHo results?';
            PListOut{2,ParaIndex}=restgui_misc('RadioValue2YesNo',InputParameter.KccReHo.IsSmooth);
            if 1==InputParameter.KccReHo.IsSmooth
                PListOut{3,LabelIndex}='FWHM for KCC-ReHo:';
                PListOut{3,ParaIndex}=SmoothFWHM;
            end
end


function [InputParameter,PListOut]=getGUIPara_CoheReHo(InputParameter,handles,TR,LabelIndex,ParaIndex)
        % Did not use
        %     InputParameter.CoHeReHo.NVoxel;
        %     InputParameter.CoHeReHo.Auto;
        %     InputParameter.CoHeReHo.TimeP;
        %     InputParameter.CoHeReHo.Overlap;
        
        LowPass_HighCutoff=get(handles.hPara.CoHeReHo.BandHighEdit,'string');
        HighPass_LowCutoff=get(handles.hPara.CoHeReHo.BandLowEdit,'string');
        SmoothFWHM=get(handles.hPara.CoHeReHo.SmCoHeReHoFWHMedit,'string');
        
        InputParameter.CoHeReHo.SamplePeriod=TR;
        InputParameter.CoHeReHo.LowPass_HighCutoff=str2double(LowPass_HighCutoff);
        InputParameter.CoHeReHo.HighPass_LowCutoff=str2double(HighPass_LowCutoff);
        InputParameter.CoHeReHo.IsSmooth=get(handles.hPara.CoHeReHo.SmCoHeReHoChekbox,'value');
        InputParameter.CoHeReHo.SmoothFWHM=eval(['[',SmoothFWHM,']']);
        
        PListOut{1,LabelIndex}='CoHeReHo band:';
        PListOut{1,ParaIndex}=[HighPass_LowCutoff '~' LowPass_HighCutoff];
        PListOut{2,LabelIndex}='NVoxel(default):';
        PListOut{2,ParaIndex}='27';
        PListOut{3,LabelIndex}='If Smooth Cohe-ReHo results?';
        PListOut{3,ParaIndex}=restgui_misc('RadioValue2YesNo',InputParameter.CoHeReHo.IsSmooth);
        if 1==InputParameter.CoHeReHo.IsSmooth
                PListOut{4,LabelIndex}='FWHM for Cohe-ReHo:';
                PListOut{4,ParaIndex}=SmoothFWHM;
        end

end


function [InputParameter,PListOut]=getGUIPara_FunctionalConnectivity(InputParameter,handles,LabelIndex,ParaIndex)
        if get(handles.hPara.FunConnectivity.VoxelWiseRadioBtn,'value')
           InputParameter.FunctionalConnectivity.VorR_tag='Voxel';
           FcType='Voxel wise';
        elseif get(handles.hPara.FunConnectivity.ROIWiseRadioBtn,'value')
           InputParameter.FunctionalConnectivity.VorR_tag='ROI';   
           FcType='ROI wise';
        else
            error('FunctionalConnectivity Run_HandlesCallback');
        end
        
        
        FC_ROIlistListboxStr=get(handles.hPara.FunConnectivity.ROIlistListbox,'string');
        FC_ROIlistCells=brief_misc('ListboxStr2CellArray',FC_ROIlistListboxStr);
        InputParameter.FunctionalConnectivity.ROIDef=FC_ROIlistCells;
        
        PListOut{1,LabelIndex}='Functional connectivity type:';
        PListOut{1,ParaIndex}=FcType;
        PListOut{2,LabelIndex}='ROI list:';
        ROIListStrOut='';
        for i=1:size(FC_ROIlistCells,1)
            ROIListStrOut=sprintf('%s \t\n ROI%s:%s',ROIListStrOut,num2str(i),FC_ROIlistCells{i,1});
        end
        PListOut{2,ParaIndex}=ROIListStrOut;
end

function [InputParameter,PListOut]=getGUIPara_VMHC(InputParameter,handles)
         InputParameter.VMHC.CutNumber=10;
         PListOut='';
end


function [InputParameter,PListOut]=getGUIPara_PerAF(InputParameter,handles)
             PListOut='';
end


function [InputParameter,PListOut]=getGUIPara_DegreeCentrality(InputParameter,handles,LabelIndex,ParaIndex)
              InputParameter.DegreeCentrality.rThreshold=str2double(get(handles.hPara.DegreeCentrality.RCorrThreEdit,'string'));
              InputParameter.DegreeCentrality.CutNumber=10;
              InputParameter.DegreeCentrality.IsSmooth=...
                                          get(handles.hPara.DegreeCentrality.SmDegreeCentralityChekbox,'value');
              SmoothFWHM=get(handles.hPara.DegreeCentrality.SmDegreeCentralityFWHMedit,'string');
              InputParameter.DegreeCentrality.SmoothFWHM=eval(['[',SmoothFWHM,']']);
              
              
              PListOut{1,LabelIndex}='rThreshold:';
              PListOut{1,ParaIndex}=num2str(InputParameter.DegreeCentrality.rThreshold);
              PListOut{2,LabelIndex}='If Smooth DegreeCentrality results?';
              PListOut{2,ParaIndex}=restgui_misc('RadioValue2YesNo',InputParameter.DegreeCentrality.IsSmooth);
              if 1==InputParameter.DegreeCentrality.IsSmooth
                PListOut{4,LabelIndex}='FWHM for DegreeCentrality:';
                PListOut{4,ParaIndex}=SmoothFWHM;
              end
              
end


function [InputParameter,PListOut]=getGUIPara_GCA(InputParameter,handles,LabelIndex,ParaIndex)
          if 1==get(handles.hPara.GCA.Coefficient_basedRadioBtn,'value')
             InputParameter.GCA.GCAtype= 'coefficient';
             if 1==get(handles.hPara.GCA.BivariateCoefficientsRadioBtn,'value')
                InputParameter.GCA.CoefficientMode='BivariateMode'; 
             elseif 1==get(handles.hPara.GCA.MultivariateCofficientsRadioBtn,'value')
                InputParameter.GCA.CoefficientMode='MulivariateMode'; 
             end
          elseif 1==get(handles.hPara.GCA.Residual_basedRadioBtn,'value')
             InputParameter.GCA.GCAtype='residual';
          end
          
          OrderString=get(handles.hPara.GCA.OrderEdit,'string');
          InputParameter.GCA.Order=str2double(OrderString);
          
          GCA_ROIlistListboxStr=get(handles.hPara.GCA.ROIlistListbox,'string');
          GCA_ROIlistCells=brief_misc('ListboxStr2CellArray',GCA_ROIlistListboxStr);
          
          if 1==get(handles.hPara.GCA.VoxelWiseRadioBtn,'value')
              InputParameter.GCA.AROIDef=GCA_ROIlistCells{1}; 
          elseif 1==get(handles.hPara.GCA.ROIWiseRadioBtn,'value')
              InputParameter.GCA.AROIDef=GCA_ROIlistCells; 
          end
          
          
          %log GCA type
          if 1==get(handles.hPara.GCA.VoxelWiseRadioBtn,'value')
              PListOut_Voxelwise_ROIwise='Voxel wise';
              if 1==get(handles.hPara.GCA.Coefficient_basedRadioBtn,'value')
                 PListOut_GCAtype='->Coefficient-based'; 
              elseif 1==get(handles.hPara.GCA.Residual_basedRadioBtn,'value')
                 PListOut_GCAtype='->Residual-based'; 
              end
              PListOut_CoefficientMode='';
          elseif 1==get(handles.hPara.GCA.ROIWiseRadioBtn,'value')
              PListOut_Voxelwise_ROIwise='ROI wise';
              if 1==get(handles.hPara.GCA.Coefficient_basedRadioBtn,'value')
                 PListOut_GCAtype='->Coefficient-based'; 
                 if 1==get(handles.hPara.GCA.BivariateCoefficientsRadioBtn,'value')
                    PListOut_CoefficientMode='->Bivariate coefficients';
                 elseif 1==get(handles.hPara.GCA.MultivariateCofficientsRadioBtn,'value')
                    PListOut_CoefficientMode='->Multivariate coefficients';
                 end
              elseif 1==get(handles.hPara.GCA.Residual_basedRadioBtn,'value')
                 PListOut_GCAtype='->Residual-based'; 
                 PListOut_CoefficientMode='';
              end
          end
          
                    
       PListOut{1,LabelIndex}='GCA tyle';
       PListOut{1,ParaIndex}=[PListOut_Voxelwise_ROIwise PListOut_GCAtype PListOut_CoefficientMode];
       PListOut{2,LabelIndex}='GCA order';
       PListOut{2,ParaIndex}=OrderString;
       PListOut{3,LabelIndex}='GCA ROI list';
       PListOut{3,ParaIndex}=GCA_ROIlistListboxStr;
end



function [BoundingBox,VoxelSize]=get_boundingbox_voxelsize(ProgramVersion,handles)
         if strcmp(ProgramVersion,'BasicVersion')
             BoundingBox=get(handles.hPara.Normalize.BoundingBoxEdit,'string');
             VoxelSize=get(handles.hPara.Normalize.VoxSizeEdit ,'string');             
         elseif strcmp(ProgramVersion,'AdvancedVersion')
             BoundingBox=get(handles.hPara.NormalizeEpi.BoundingBoxEdit,'string');
             VoxelSize=get(handles.hPara.NormalizeEpi.VoxSizeEdit,'string');
         else
             error('wrong use get_GUIParameters');
         end
end



function [run_string_affine_regularisation,log_string_affine_regularisation]...
                                =get_affine_regularisation(ProgramVersion,handles)
                            
   if strcmp(ProgramVersion,'BasicVersion')
         if 1==get(handles.hPara.Normalize.SegmentEuropeanRadio,'value')
            run_string_affine_regularisation='mni';
            log_string_affine_regularisation='European';
         elseif 1==get( handles.hPara.Normalize.SegmentEastAsianRadio,'value')
            run_string_affine_regularisation='eastern';
            log_string_affine_regularisation='EastAsian';
         else
             error('get_GUIParameters');
         end
   elseif strcmp(ProgramVersion,'AdvancedVersion')
          if 1==get(handles.hPara.T1Segment.SegmentEuropeanRadio,'value')
            run_string_affine_regularisation='mni';
            log_string_affine_regularisation='European';              
          elseif 1==get(handles.hPara.T1Segment.SegmentEastAsianRadio,'value')
            run_string_affine_regularisation='eastern';
            log_string_affine_regularisation='EastAsian';                 
          else
              error('get_GUIParameters');
          end
   else
       error('wrong use getGUIPara_T1Segment');
   end                            
end