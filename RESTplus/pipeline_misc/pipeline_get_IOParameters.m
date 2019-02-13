function [InputParameter IOListOut]=pipeline_get_IOParameters(AOperation,IOListIn,InputParameter,AnalysisDir,handles)
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
IOListOut{FunIn}=IOListIn{FunIn};
IOListOut{FunOut}=IOListIn{FunOut};
IOListOut{T1In}=IOListIn{T1In};
IOListOut{T1Out}=IOListIn{T1Out};

NoT1In='';
NoT1Out='';
NoFunIn='';
NoFunOut='';

indirfun=[AnalysisDir filesep IOListIn{FunIn}];
outdirfun=[AnalysisDir filesep IOListIn{FunOut}];
indirt1=[AnalysisDir filesep IOListIn{T1In}];
outdirt1=[AnalysisDir filesep IOListIn{T1Out}];
resultdir=[AnalysisDir filesep 'Results'];


switch AOperation
    case 'EpiDicomtoNifti'
        InputParameter.EpiDicomToNifti.InDirFunRaw=indirfun;
        InputParameter.EpiDicomToNifti.OutDirFunImg=outdirfun;  
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;
    case 'T1DicomToNifti'
        InputParameter.T1DicomToNifti.InDirT1Raw=indirt1;
        InputParameter.T1DicomToNifti.OutDirT1Img=outdirt1;   
        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;
    case 'RemoveFirstTimePoints'
       InputParameter.RemoveFirstTimePoints.InDirFunImg=indirfun;
       InputParameter.RemoveFirstTimePoints.OutDirFunImg=outdirfun;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;       
    case 'SliceTiming'
        InputParameter.SliceTiming.InDirFunImg=indirfun;
        InputParameter.SliceTiming.OutDirFunImg=outdirfun;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;        
    case 'Realign'
        InputParameter.Realign.InDirFunImg=indirfun;
        InputParameter.Realign.OutDirFunImg=outdirfun;
        InputParameter.Realign.RealignParameterDir=[AnalysisDir filesep get_Postfix('RealignParameter')];
        IOListOut{FunOut}=[IOListIn{FunOut} '|' get_Postfix('RealignParameter')];
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;   
    case 'ReorientFunBeforeCoreg'
        InputParameter.ReorientFunBeforeCoreg.RealignParameterDir=[AnalysisDir filesep get_Postfix('RealignParameter')];
        InputParameter.ReorientFunBeforeCoreg.OutFodr_ReorientMat=[AnalysisDir filesep get_Postfix('ReorientMats')];
        IOListOut{FunIn}=get_Postfix('RealignParameter');
        IOListOut{FunOut}=[get_Postfix('RealignParameter') '|' get_Postfix('ReorientMats')];        
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;   
    case 'ReorientT1BeforeCoreg'
        InputParameter.ReorientT1BeforeCoreg.InDirT1Img=indirt1;
        InputParameter.ReorientT1BeforeCoreg.OutFodr_ReorientMat=[AnalysisDir filesep get_Postfix('ReorientMats')];
        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;
        IOListOut{T1Out}=[IOListIn{T1Out} '|' get_Postfix('ReorientMats')];
    case 'NormalizeEpi'
        InputParameter.Normalize.EPI.InDirFunImg=indirfun;
        InputParameter.Normalize.EPI.OutDirFunImg=outdirfun;
        InputParameter.Normalize.EPI.InDirRealignParameter=[AnalysisDir filesep get_Postfix('RealignParameter')];
        InputParameter.Normalize.EPI.InFodrChekNormPic=[AnalysisDir filesep get_Postfix('PicsForChekNorm')];
        IOListOut{FunIn}=[IOListIn{FunIn} '|' get_Postfix('RealignParameter')];        
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;        
    case 'T1CoregisterFun'
        InputParameter.T1CoregisterFun.InDirT1Img=indirt1;
        InputParameter.T1CoregisterFun.InDirRealignParameter=[AnalysisDir filesep get_Postfix('RealignParameter')];
        InputParameter.T1CoregisterFun.OutDirT1CoregisterFun=outdirt1;
        IOListOut{FunIn}=get_Postfix('RealignParameter');
        IOListOut{FunOut}=NoFunOut;       
    case 'ReorientT1AfterCoreg'
        InputParameter.ReorientT1AfterCoreg.InDirT1Coregister=indirt1;
        InputParameter.ReorientT1AfterCoreg.OutFodr_ReorientMat=[AnalysisDir filesep get_Postfix('ReorientMats')];  
        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;
        IOListOut{T1In}=IOListIn{T1In};
        IOListOut{T1Out}=[IOListIn{T1Out} '|' get_Postfix('ReorientMats')];      
    case 'T1Segment'
        InputParameter.Segment.InDirT1=indirt1;
        InputParameter.Segment.OutDirT1Segment=outdirt1;
        IOListOut{FunIn}=NoFunIn;
        IOListOut{FunOut}=NoFunOut;        
    case 'NormalizeSeg'
        InputParameter.NormalizeSeg.InDirFunImg=indirfun;
        InputParameter.NormalizeSeg.OutDirFunImg=outdirfun;
        InputParameter.NormalizeSeg.InDirT1Seg=indirt1;
        InputParameter.NormalizeSeg.InFodrChekNormPic=[AnalysisDir filesep get_Postfix('PicsForChekNorm')];
        IOListOut{FunOut}=[IOListIn{FunOut} '|' get_Postfix('PicsForChekNorm')];
        IOListOut{T1Out}=NoT1Out;
    case 'NormalizeSymSeg'
       InputParameter.Normalize.Seg_Sym.InDirFunImg=indirfun;
       InputParameter.Normalize.Seg_Sym.OutDirFunImg=outdirfun;
       InputParameter.Normalize.Seg_Sym.InDirT1Img=indirt1;
       InputParameter.Normalize.Seg_Sym.InFodrChekNormPic=[AnalysisDir filesep get_Postfix('PicsForChekNorm')];
       InputParameter.Normalize.Seg_Sym.InDirRealignParameter=[AnalysisDir filesep get_Postfix('RealignParameter')];
       IOListOut{FunIn}=[IOListIn{FunIn} '|' get_Postfix('RealignParameter')];
       IOListOut{FunOut}=[IOListIn{FunOut} '|' get_Postfix('PicsForChekNorm')];
       IOListOut{T1Out}=NoT1Out;       
    case 'NormalizeNewSeg_dartel'
       InputParameter.Normalize.dartel.InDirFunImg=indirfun;
       InputParameter.Normalize.dartel.InDirT1Img=indirt1;
       InputParameter.Normalize.dartel.InDirRealignParameter=[AnalysisDir filesep get_Postfix('RealignParameter')];
       InputParameter.Normalize.dartel.OutDirFunImg=outdirfun;
       InputParameter.Normalize.dartel.OutDirT1CoregisterFun=outdirt1(1:end-1);
       InputParameter.Normalize.dartel.OutDirT1NewSegment=outdirt1;
       InputParameter.Normalize.dartel.InFodrChekNormPic=[AnalysisDir filesep get_Postfix('PicsForChekNorm')];
       InputParameter.Normalize.dartel.OutFodrTemplate=[AnalysisDir filesep 'dartel_template'];
       
       IOListOut{FunIn}=[IOListIn{FunIn} '|' get_Postfix('RealignParameter')];
       IOListOut{FunOut}=[IOListIn{FunOut} '|' get_Postfix('PicsForChekNorm')];        
       IOListOut{T1In}=[IOListIn{T1In}];
       IOListOut{T1Out}=[IOListIn{T1Out}(1:end-1) '|' IOListIn{T1Out} '|' 'dartel_template'];  
        
    case 'Smooth'
        InputParameter.Smooth.Gaussian.InDirFunImg=indirfun;
        InputParameter.Smooth.Gaussian.OutDirFunImg=outdirfun;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
    case 'Detrend'
        InputParameter.Detrend.InDirFunImg=indirfun;
        InputParameter.Detrend.OutDirFunImg=outdirfun;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
    case 'Filter'
        InputParameter.Filter.InDirFunImg=indirfun;
        InputParameter.Filter.OutDirFunImg=outdirfun;
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;        
    case 'RegressOutCovariates'
        InputParameter.RegressOutCovariates.InDirFunImg=indirfun;
        InputParameter.RegressOutCovariates.OutDirFunImg=outdirfun;
        InputParameter.RegressOutCovariates.OutDirCov=[AnalysisDir filesep get_Postfix('CovariatesParameter')];
        IOListOut{FunOut}=[IOListIn{FunOut} '|' get_Postfix('CovariatesParameter')];        
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;        
        if 1==get( handles.hPara.RegressOutNuisance.HeadMotion6Para ,'value')
          InputParameter.RegressOutCovariates.InDirRealignParameter=[AnalysisDir filesep get_Postfix('RealignParameter')];
          IOListOut{FunIn}=[IOListOut{FunIn} '|' get_Postfix('RealignParameter')];
        else
          InputParameter.RegressOutCovariates.InDirRealignParameter=''; 
        end
    case 'Alff'
        InputParameter.alff.InDirFunImg=indirfun;
        InputParameter.alff.OutFodrALFF=[resultdir filesep 'ALFF'];
        InputParameter.alff.InFileMask=mask_misc('getGUImaskinfo',handles);
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;   
        IOListOut{FunOut}='ALFF';
    case 'fALFF'
        InputParameter.fALFF.InDirFunImg=indirfun;
        InputParameter.fALFF.OutFodrfALFF=[resultdir filesep 'fALFF'];
        InputParameter.fALFF.InFileMask=mask_misc('getGUImaskinfo',handles);       
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
        IOListOut{FunOut}='fALFF';
    case 'KccReHo'
        InputParameter.KccReHo.InDirFunImg=indirfun;
        InputParameter.KccReHo.OutFodrKccReHo=[resultdir filesep 'KccReHo'];
        InputParameter.KccReHo.InFileMask=mask_misc('getGUImaskinfo',handles);
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
        IOListOut{FunOut}='KccReHo';
    case 'CoHeReHo'
        InputParameter.CoHe.InDirFunImg=indirfun;
        InputParameter.CoHe.OutFodrCoHeReHo=[resultdir filesep 'CoHeReHo'];
        InputParameter.CoHe.InFileMask=mask_misc('getGUImaskinfo',handles);
        
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out; 
        IOListOut{FunOut}='CoHeReHo';
    case 'FunctionalConnectivity'
        InputParameter.FunctionalConnectivity.InDirFunImg=indirfun;
        InputParameter.FunctionalConnectivity.OutFodrFC=[resultdir filesep 'FunctionalConnectivity'];
        InputParameter.FunctionalConnectivity.InFilePathMask=mask_misc('getGUImaskinfo',handles);
        IOListOut{T1In}=NoT1In;
        IOListOut{T1Out}=NoT1Out;   
        IOListOut{FunOut}='FunctionalConnectivity';
    case 'VMHC'
       InputParameter.VMHC.InDirFunImg=indirfun;
       InputParameter.VMHC.OutFodrVMHC=[resultdir filesep 'VMHC'];
       InputParameter.VMHC.InFilePathMask=mask_misc('getGUImaskinfo',handles);      
       IOListOut{T1In}=NoT1In;
       IOListOut{T1Out}=NoT1Out;  
       IOListOut{FunOut}='VMHC';
    case 'PerAF'
      InputParameter.PerAF.InDirFunImg=indirfun;
      InputParameter.PerAF.OutFodrPerAF=[resultdir filesep 'PerAF'];
      InputParameter.PerAF.InFilePathMask=mask_misc('getGUImaskinfo',handles);      
      IOListOut{T1In}=NoT1In;
      IOListOut{T1Out}=NoT1Out; 
      IOListOut{FunOut}='PerAF';
    case 'DegreeCentrality'
      InputParameter.DegreeCentrality.InDirFunImg=indirfun;
      InputParameter.DegreeCentrality.OutFodrDegreeCentrality=[resultdir filesep 'DegreeCentrality'];
      InputParameter.DegreeCentrality.InFilePathMask=mask_misc('getGUImaskinfo',handles);      
      IOListOut{T1In}=NoT1In;
      IOListOut{T1Out}=NoT1Out;  
      IOListOut{FunOut}='DegreeCentrality';
    case 'GCA'
      InputParameter.GCA.InDirFunImg=indirfun;
      InputParameter.GCA.OutFodrGCA=[resultdir filesep 'GCA'];
      InputParameter.GCA.InFilePathMask=mask_misc('getGUImaskinfo',handles);      
      IOListOut{T1In}=NoT1In;
      IOListOut{T1Out}=NoT1Out;  
      IOListOut{FunOut}='GCA';    
    otherwise
        error('wrong Generate_IOParameter %s is not exist',AOperation);
end
end