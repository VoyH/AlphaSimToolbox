function  [InputParameter IOListOut]=flaxible_get_IOParameters(AOperation,InputParameter,AnalysisDir,handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



FunIn=1;
FunOut=2;
T1In=3;
T1Out=4;

IOListOut=cell(4,1);

NoT1In='';
NoT1Out='';
NoFunIn='';
NoFunOut='';

resultdir=[AnalysisDir filesep 'Results'];
switch AOperation
    case 'EpiDicomtoNifti'
        FunFolderIn=get(handles.hPara.EpiDicomToNifti.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.EpiDicomToNifti.OutdirFunEdit,'string');
        
        InputParameter.EpiDicomToNifti.InDirFunRaw=[AnalysisDir filesep FunFolderIn];
        InputParameter.EpiDicomToNifti.OutDirFunImg=[AnalysisDir filesep FunFolderOut];  
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=FunFolderOut;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;
    case 'T1DicomToNifti'
        T1FolderIn=get(handles.hPara.T1DicomToNifti.IndirFunEdit,'string');
        T1FolderOut=get(handles.hPara.T1DicomToNifti.OutdirFunEdit,'string');
        
        InputParameter.T1DicomToNifti.InDirT1Raw=[AnalysisDir filesep T1FolderIn];
        InputParameter.T1DicomToNifti.OutDirT1Img=[AnalysisDir filesep T1FolderOut];
        
        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;        
        IOListOut{T1In}=T1FolderIn;
        IOListOut{T1Out}=T1FolderOut;
    case 'RemoveFirstTimePoints'
       FunFolderIn=get(handles.hPara.RemoveTimePoints.IndirFunEdit,'string');
       FunFolderOut=get(handles.hPara.RemoveTimePoints.OutdirFunEdit,'string');
       
       InputParameter.RemoveFirstTimePoints.InDirFunImg=[AnalysisDir filesep FunFolderIn];
       InputParameter.RemoveFirstTimePoints.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
       
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=FunFolderOut;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;       
    case 'SliceTiming'
        FunFolderIn=get(handles.hPara.SliceTiming.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.SliceTiming.OutdirFunEdit,'string');
        
        InputParameter.SliceTiming.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.SliceTiming.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=FunFolderOut;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;        
    case 'Realign'
        FunFolderIn=get(handles.hPara.Realign.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.Realign.OutdirFunEdit,'string');
        RealignParameter_In=get(handles.hPara.Realign.OutdirRealignParaEdit,'string');
        
        InputParameter.Realign.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.Realign.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        InputParameter.Realign.RealignParameterDir=[AnalysisDir filesep RealignParameter_In];
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=[FunFolderOut '|' RealignParameter_In];
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;      
        
    case get_RunStr('ReorientFunBeforeCoreg')
        RealignParameterDir_in=get(handles.hPara.ReorientFunBeforeCoreg.IndirFunEdit,'string');
        
        InputParameter.ReorientFunBeforeCoreg.RealignParameterDir=[AnalysisDir filesep RealignParameterDir_in];
        InputParameter.ReorientFunBeforeCoreg.OutFodr_ReorientMat=[AnalysisDir filesep get_Postfix('ReorientMats')];
        
        IOListOut{FunIn}=RealignParameterDir_in;
        IOListOut{FunOut}=[RealignParameterDir_in '|' get_Postfix('ReorientMats')];
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;         
        
    case get_RunStr('ReorientT1BeforeCoreg')
        T1FolderIn=get(handles.hPara.ReorientT1BeforeCoreg.IndirFunEdit,'string');
        T1FolderOut=T1FolderIn;
        
        InputParameter.ReorientT1BeforeCoreg.InDirT1Img=[AnalysisDir filesep T1FolderIn];
        InputParameter.ReorientT1BeforeCoreg.OutFodr_ReorientMat=[AnalysisDir filesep get_Postfix('ReorientMats')];       

        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;
        IOListOut{T1In}=T1FolderIn;
        IOListOut{T1Out}=[T1FolderOut '|' get_Postfix('ReorientMats')]; 
        
    case get_RunStr('ReorientT1AfterCoreg')
        T1FolderIn=get(handles.hPara.ReorientT1AfterCoreg.IndirFunEdit,'string');
        T1FolderOut=T1FolderIn;
        
        InputParameter.ReorientT1AfterCoreg.InDirT1Coregister=[AnalysisDir filesep T1FolderIn];
        InputParameter.ReorientT1AfterCoreg.OutFodr_ReorientMat=[AnalysisDir filesep get_Postfix('ReorientMats')];       

        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;
        IOListOut{T1In}=T1FolderIn;
        IOListOut{T1Out}=[T1FolderOut '|' get_Postfix('ReorientMats')];         
        
    case 'NormalizeEpi'
        FunFolderIn=get(handles.hPara.NormalizeEpi.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.NormalizeEpi.OutdirFunEdit,'string');
        InDirRealignParameter_in=get(handles.hPara.NormalizeEpi.IndirRealignParaEdit,'string');
        
        InputParameter.Normalize.EPI.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.Normalize.EPI.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        InputParameter.Normalize.EPI.InDirRealignParameter=[AnalysisDir filesep InDirRealignParameter_in];
        InputParameter.Normalize.EPI.InFodrChekNormPic=[AnalysisDir filesep get_Postfix('PicsForChekNorm')];
        
        IOListOut{FunIn}=[FunFolderIn '|' InDirRealignParameter_in];    
        IOListOut{FunOut}=[FunFolderOut '|' get_Postfix('PicsForChekNorm')];
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;        
    case 'T1CoregisterFun'
        T1FolderIn=get(handles.hPara.T1CoregisterFun.IndirT1Edit,'string');
        T1FolderOut=get(handles.hPara.T1CoregisterFun.OutDirT1Edit,'string');
        InDirRealignParameter_In=get(handles.hPara.T1CoregisterFun.IndirRealignParaEdit,'string');
        
        InputParameter.T1CoregisterFun.InDirT1Img=[AnalysisDir filesep T1FolderIn];
        InputParameter.T1CoregisterFun.InDirRealignParameter=[AnalysisDir filesep InDirRealignParameter_In];
        InputParameter.T1CoregisterFun.OutDirT1CoregisterFun=[AnalysisDir filesep T1FolderOut];
        
        IOListOut{FunIn}=InDirRealignParameter_In;
        IOListOut{FunOut}=NoFunOut;       
        IOListOut{T1In}=T1FolderIn;
        IOListOut{T1Out}=T1FolderOut;
        
    case 'T1Segment'
        T1FolderIn=get(handles.hPara.T1Segment.IndirT1Edit,'string');
        T1FolderOut=get(handles.hPara.T1Segment.OutDirT1Edit,'string');
        
        InputParameter.Segment.InDirT1=[AnalysisDir filesep T1FolderIn];
        InputParameter.Segment.OutDirT1Segment=[AnalysisDir filesep T1FolderOut];
        
        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;    
        IOListOut{T1In}=T1FolderIn;
        IOListOut{T1Out}=T1FolderOut;
    case 'NormalizeSeg'
        FunFolderIn=get(handles.hPara.NormalizeSeg.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.NormalizeSeg.OutFunEdit,'string');
        T1FolderIn=get(handles.hPara.NormalizeSeg.InDirT1Edit,'string');
        
        InputParameter.NormalizeSeg.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.NormalizeSeg.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        InputParameter.NormalizeSeg.InDirT1Seg=[AnalysisDir filesep T1FolderIn];
        InputParameter.NormalizeSeg.InFodrChekNormPic=[AnalysisDir filesep get_Postfix('PicsForChekNorm')];
        
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=[FunFolderOut '|' get_Postfix('PicsForChekNorm')];
        IOListOut{T1In}=T1FolderIn;
        IOListOut{T1Out}=NoT1Out;
        
    case get_RunStr('NormalizeNewSeg_dartel')
        
        FunFolderIn=get(handles.hPara.Normalize_newseg_dartel.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.Normalize_newseg_dartel.OutFunEdit,'string');
        T1FolderIn=get(handles.hPara.Normalize_newseg_dartel.InDirT1Edit,'string');
        RealignParameter=get(handles.hPara.Normalize_newseg_dartel.IndirRealignParaEdit,'string');
        
        
        InputParameter.Normalize.dartel.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.Normalize.dartel.InDirT1Img=[AnalysisDir filesep T1FolderIn];
        InputParameter.Normalize.dartel.InDirRealignParameter=[AnalysisDir filesep RealignParameter];
        InputParameter.Normalize.dartel.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        
        
        
        InputParameter.Normalize.dartel.OutDirT1NewSegment=...
                        [AnalysisDir filesep T1FolderIn get_Postfix('T1CoregisterFun') get_Postfix('NewSegment')];
        InputParameter.Normalize.dartel.OutDirT1CoregisterFun=...
                        [AnalysisDir filesep T1FolderIn get_Postfix('T1CoregisterFun')];
        InputParameter.Normalize.dartel.InFodrChekNormPic=[AnalysisDir filesep get_Postfix('PicsForChekNorm')];
        InputParameter.Normalize.dartel.OutFodrTemplate=[AnalysisDir filesep 'dartel_template'];
        
        IOListOut{FunIn}=[FunFolderIn '|' RealignParameter];
        IOListOut{FunOut}=[FunFolderOut '|' get_Postfix('PicsForChekNorm')];
        IOListOut{T1In}=T1FolderIn;
        IOListOut{T1Out}=[T1FolderIn get_Postfix('T1CoregisterFun') '|' ...
                          T1FolderIn get_Postfix('T1CoregisterFun') get_Postfix('NewSegment') '|' ...
                          'dartel_template'];        
              
    case 'Smooth'
        FunFolderIn=get(handles.hPara.Smooth.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.Smooth.OutdirFunEdit,'string');
        
        InputParameter.Smooth.Gaussian.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.Smooth.Gaussian.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=FunFolderOut;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
    case 'Detrend'
        FunFolderIn=get(handles.hPara.Detrend.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.Detrend.OutdirFunEdit,'string');
        
        InputParameter.Detrend.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.Detrend.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=FunFolderOut;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
    case 'Filter'
        FunFolderIn=get(handles.hPara.Filter.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.Filter.OutdirFunEdit,'string');
        
        InputParameter.Filter.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.Filter.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=FunFolderOut;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;        
    case 'RegressOutCovariates'
        FunFolderIn=get(handles.hPara.RegressOutNuisance.IndirFunEdit,'string');
        FunFolderOut=get(handles.hPara.RegressOutNuisance.OutdirFunEdit,'string');
        
        InputParameter.RegressOutCovariates.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.RegressOutCovariates.OutDirFunImg=[AnalysisDir filesep FunFolderOut];
        InputParameter.RegressOutCovariates.OutDirCov=[AnalysisDir filesep get_Postfix('CovariatesParameter')];
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{FunOut}=[FunFolderOut '|' get_Postfix('CovariatesParameter')];        
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;  
        
        if 1==get( handles.hPara.RegressOutNuisance.HeadMotion6Para ,'value')
          InputParameter.RegressOutCovariates.InDirRealignParameter=[AnalysisDir filesep get_Postfix('RealignParameter')];
          IOListOut{FunOut}=[IOListOut{FunOut} '|' get_Postfix('RealignParameter')];
        else
          InputParameter.RegressOutCovariates.InDirRealignParameter=''; 
        end
    case 'Alff'
        FunFolderIn=get(handles.hPara.ALFF.IndirFunEdit,'string');
        ALFFresult=get(handles.hPara.ALFF.ResultEdit,'string');
        
        InputParameter.alff.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.alff.OutFodrALFF=[AnalysisDir filesep ALFFresult];
        InputParameter.alff.InFileMask=mask_misc('getGUImaskinfo',handles);
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;   
        IOListOut{FunOut}=ALFFresult;
    case 'fALFF'
        FunFolderIn=get(handles.hPara.fALFF.IndirFunEdit,'string');
        fALFFresult=get(handles.hPara.fALFF.ResultEdit,'string');
        
        InputParameter.fALFF.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.fALFF.OutFodrfALFF=[AnalysisDir filesep fALFFresult];
        InputParameter.fALFF.InFileMask=mask_misc('getGUImaskinfo',handles);       

        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
        IOListOut{FunOut}=fALFFresult;
    case 'KccReHo'
        FunFolderIn=get(handles.hPara.KccReHo.IndirFunEdit,'string');
        KccReHoResult=get(handles.hPara.KccReHo.ResultEdit,'string');
        
        InputParameter.KccReHo.InDirFunImg=[AnalysisDir filesep FunFolderIn];
        InputParameter.KccReHo.OutFodrKccReHo=[AnalysisDir filesep KccReHoResult];
        InputParameter.KccReHo.InFileMask=mask_misc('getGUImaskinfo',handles);
        
        IOListOut{FunIn}=FunFolderIn;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
        IOListOut{FunOut}=KccReHoResult;
    case 'CoHeReHo'          
          cohe_in=get(handles.hPara.CoHeReHo.IndirFunEdit,'string');
          cohe_out=get(handles.hPara.CoHeReHo.ResultEdit,'string');
          
          InputParameter.CoHe.InDirFunImg=[AnalysisDir filesep cohe_in];
          InputParameter.CoHe.OutFodrCoHeReHo=[AnalysisDir filesep cohe_out];
          InputParameter.CoHe.InFileMask=mask_misc('getGUImaskinfo',handles);
          IOListOut{T1In}=NoT1In;
          IOListOut{T1Out}=NoT1Out;
          IOListOut{FunIn}=cohe_in;
          IOListOut{FunOut}=cohe_out;
    case 'FunctionalConnectivity'
        fc_in=get(handles.hPara.FunConnectivity.IndirFunEdit,'string');
        fc_out=get(handles.hPara.FunConnectivity.ResultEdit,'string');
        
        InputParameter.FunctionalConnectivity.InDirFunImg=[AnalysisDir filesep fc_in];
        InputParameter.FunctionalConnectivity.OutFodrFC=[AnalysisDir filesep fc_out];
        InputParameter.FunctionalConnectivity.InFilePathMask=mask_misc('getGUImaskinfo',handles);
        
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;   
        IOListOut{FunIn}=fc_in;
        IOListOut{FunOut}=fc_out;
        
    case 'VMHC'
%        FunFolderIn=get(handles.hPara.VMHC.IndirFunEdit,'string');
%        vhmc_result=get(handles.hPara.VMHC.ResultEdit,'string');
%        
%        InputParameter.VMHC.InDirFunImg=[AnalysisDir filesep FunFolderIn];
%        InputParameter.VMHC.OutFodrVMHC=[resultdir filesep 'VMHC'];
%        InputParameter.VMHC.InFilePathMask=mask_misc('getGUImaskinfo',handles);      
%        
%        IOListOut{FunIn}=FunFolderIn;
%        IOListOut{T1In}=NoT1In;
%        IOListOut{T1Out}=NoT1Out;  
%        IOListOut{FunOut}='VMHC';
    case 'PerAF'
      FunFolderIn=get(handles.hPara.PerAF.IndirFunEdit,'string');
      PerAF_result=get(handles.hPara.PerAF.ResultEdit,'string');
      
      InputParameter.PerAF.InDirFunImg=[AnalysisDir filesep FunFolderIn];
      InputParameter.PerAF.OutFodrPerAF=[AnalysisDir filesep PerAF_result];
      InputParameter.PerAF.InFilePathMask=mask_misc('getGUImaskinfo',handles);      
      
      IOListOut{FunIn}=FunFolderIn;
      IOListOut{T1In}=NoT1In;
      IOListOut{T1Out}=NoT1Out; 
      IOListOut{FunOut}=PerAF_result;
    case 'DegreeCentrality'
      FunFolderIn=get(handles.hPara.DegreeCentrality.IndirFunEdit,'string');
      DC_result=get(handles.hPara.DegreeCentrality.ResultEdit,'string');
      
      InputParameter.DegreeCentrality.InDirFunImg=[AnalysisDir filesep FunFolderIn];
      InputParameter.DegreeCentrality.OutFodrDegreeCentrality=[AnalysisDir filesep DC_result];
      InputParameter.DegreeCentrality.InFilePathMask=mask_misc('getGUImaskinfo',handles);      
      
      IOListOut{FunIn}=FunFolderIn;
      IOListOut{FunOut}=DC_result;
      IOListOut{T1In}=NoT1In;
      IOListOut{T1Out}=NoT1Out;  
    case 'GCA'
      gca_in=get(handles.hPara.GCA.IndirFunEdit,'string');
      gca_out=get(handles.hPara.GCA.ResultEdit,'string');
      
      InputParameter.GCA.InDirFunImg=[AnalysisDir filesep gca_in];
      InputParameter.GCA.OutFodrGCA=[AnalysisDir filesep gca_out];
      InputParameter.GCA.InFilePathMask=mask_misc('getGUImaskinfo',handles);
      
      IOListOut{FunIn}=gca_in;
      IOListOut{FunOut}=gca_out;
      IOListOut{T1In}=NoT1In;
      IOListOut{T1Out}=NoT1Out; 
      
      
    otherwise
        error('wrong Generate_IOParameter %s is not exist',AOperation);
end



end