function pipeline_kernel(AOperation,InputParameter)
%restpro_batch
% EpiDicomtoNifti
%     InputParameter.EpiDicomToNifti.InDirFunRaw;
%     InputParameter.EpiDicomToNifti.OutDirFunImg;
% T1DicomToNifti
%      InputParameter.T1DicomToNifti.InDirT1Raw;
%      InputParameter.T1DicomToNifti.OutDirT1Img;
% Remove First Time Points
%     InputParameter.RemoveFirstTimePoints.InDirFunImg
%     InputParameter.RemoveFirstTimePoints.OutDirFunImg
%     InputParameter.RemoveFirstTimePoints.TimePointsAmount
% Slice Timing
%     InputParameter.SliceTiming.InDirFunImg;
%     InputParameter.SliceTiming.OutDirFunImg;
%     InputParameter.SliceTiming.SliceNumber;
%     InputParameter.SliceTiming.SliceOrder;
%     InputParameter.SliceTiming.ReferenceSlice;
%     InputParameter.SliceTiming.TR;
% Realign
%     InputParameter.Realign.InDirFunImg;
%     InputParameter.Realign.OutDirFunImg;
%     InputParameter.Realign.RealignParameterDir;
% ReorientFunBeforeCoreg
%     InputParameter.ReorientFunBeforeCoreg.RealignParameterDir
%     InputParameter.ReorientFunBeforeCoreg.OutFodr_ReorientMat
% ReorientT1BeforeCoreg
%     InputParameter.ReorientT1BeforeCoreg.InDirT1Img
%     InputParameter.ReorientT1BeforeCoreg.OutFodr_ReorientMat
% NormalizeEpi
%     InputParameter.Normalize.EPI.InDirFunImg;
%     InputParameter.Normalize.EPI.OutDirFunImg;
%     InputParameter.Normalize.EPI.InDirRealignParameter;
%     InputParameter.Normalize.EPI.InFodrChekNormPic
%     InputParameter.Normalize.EPI.BoundingBox;
%     InputParameter.Normalize.EPI.VoxSize;
% NormalizeSeg_Sym
%     InputParameter.Normalize.Seg_Sym.InDirFunImg;
%     InputParameter.Normalize.Seg_Sym.OutDirFunImg;
%     InputParameter.Normalize.Seg_Sym.InDirT1Img;
%     InputParameter.Normalize.Seg_Sym.BoundingBox;
%     InputParameter.Normalize.Seg_Sym.VoxSize; 
%     InputParameter.Normalize.Seg_Sym.AffineRegularisation;
%     InputParameter.Normalize.Seg_Sym.InFodrChekNormPic;
%     InputParameter.Normalize.Seg_Sym.InDirRealignParameter;
% Normalize_newsegment_dartel
%     InputParameter.Normalize.dartel.InDirFunImg;
%     InputParameter.Normalize.dartel.InDirT1Img;
%     InputParameter.Normalize.dartel.InDirRealignParameter;
%     InputParameter.Normalize.dartel.OutDirFunImg;
%     InputParameter.Normalize.dartel.OutDirT1NewSegment;
%     InputParameter.Normalize.dartel.OutDirT1CoregisterFun;
%     InputParameter.Normalize.dartel.InFodrChekNormPic;
%     InputParameter.Normalize.dartel.BoundingBox;
%     InputParameter.Normalize.dartel.VoxSize;
%     InputParameter.Normalize.dartel.AffineRegularisation;
% T1CoregisterFun
%     InputParameter.T1CoregisterFun.InDirT1Img;
%     InputParameter.T1CoregisterFun.InDirRealignParameter;
%     InputParameter.T1CoregisterFun.OutDirT1CoregisterFun;
% ReorientT1AfterCoreg 
%     InputParameter.ReorientT1AfterCoreg.InDirT1Coregister;
%     InputParameter.ReorientT1AfterCoreg.OutFodr_ReorientMat;
% T1Segment 
%     InputParameter.Segment.InDirT1;
%     InputParameter.Segment.OutDirT1Segment;
%     InputParameter.AffineRegularisation;
% NormalizeSeg
%     InputParameter.NormalizeSeg.InDirFunImg;
%     InputParameter.NormalizeSeg.OutDirFunImg;
%     InputParameter.NormalizeSeg.InDirT1Seg;
%     InputParameter.NormalizeSeg.InFodrChekNormPic;
%     InputParameter.NormalizeSeg.BoundingBox;
%     InputParameter.NormalizeSeg.VoxSize;
% Smooth
%     InputParameter.Smooth.Gaussian.InDirFunImg;
%     InputParameter.Smooth.Gaussian.OutDirFunImg;
%     InputParameter.Smooth.Gaussian.FWHM;
% Detrend
%     InputParameter.Detrend.InDirFunImg;
%     InputParameter.Detrend.OutDirFunImg;
%     InputParameter.Detrend.CutNumber;
% Filter
%     InputParameter.Filter.InDirFunImg;
%     InputParameter.Filter.OutDirFunImg;
%     InputParameter.Filter.InFileMask;
%     InputParameter.Filter.SamplePeriod;
%     InputParameter.Filter.LowPass_HighCutoff;
%     InputParameter.Filter.HighPass_LowCutoff;
%     InputParameter.Filter.IsAddMeanBack;
%     InputParameter.Filter.CutNumber;
% RegressOutCovariates
%     InputParameter.RegressOutCovariates.InDirFunImg;
%     InputParameter.RegressOutCovariates.OutDirFunImg;
%     InputParameter.RegressOutCovariates.OutDirCov;
%     InputParameter.RegressOutCovariates.IsWholeBrain
%     InputParameter.RegressOutCovariates.IsCSF
%     InputParameter.RegressOutCovariates.IsWhiteMatter
%     InputParameter.RegressOutCovariates.IsHeadMotion_Rigidbody6
%     InputParameter.RegressOutCovariates.IsOtherCovariatesROI
%     InputParameter.RegressOutCovariates.InDirRealignParameter
%     InputParameter.RegressOutCovariates.OtherCovariatesROIList
% Alff
%     InputParameter.alff.InDirFunImg;
%     InputParameter.alff.OutFodrALFF;
%     InputParameter.alff.InFileMask;
%     InputParameter.alff.SamplePeriod;
%     InputParameter.alff.LowPass_HighCutoff;
%     InputParameter.alff.HighPass_LowCutoff;
%     InputParameter.alff.CutNumber;
% fALFF
%     InputParameter.fALFF.InDirFunImg;
%     InputParameter.fALFF.OutFodrfALFF;
%     InputParameter.fALFF.InFileMask;
%     InputParameter.fALFF.SamplePeriod;
%     InputParameter.fALFF.LowPass_HighCutoff;
%     InputParameter.fALFF.HighPass_LowCutoff;
%     InputParameter.fALFF.CutNumber;
% KccReHo
%     InputParameter.KccReHo.InDirFunImg;
%     InputParameter.KccReHo.OutFodrKccReHo;
%     InputParameter.KccReHo.InFileMask;
%     InputParameter.KccReHo.NVoxel;
%     InputParameter.KccReHo.CutNumber;
%     InputParameter.KccReHo.IsSmooth
%     InputParameter.KccReHo.SmoothFWHM
% CoHeReHo
%     InputParameter.CoHe.InDirFunImg;
%     InputParameter.CoHe.OutFodrCoHeReHo;
%     InputParameter.CoHe.InFileMask;
% 
%     InputParameter.CoHeReHo.SamplePeriod;
%     InputParameter.CoHeReHo.LowPass_HighCutoff;
%     InputParameter.CoHeReHo.HighPass_LowCutoff;
%     InputParameter.CoHeReHo.IsSmooth
%     InputParameter.CoHeReHo.SmoothFWHM
% Functional Connectivity
%     InputParameter.FunctionalConnectivity.InDirFunImg;
%     InputParameter.FunctionalConnectivity.OutFodrFC;
%     InputParameter.FunctionalConnectivity.InFilePathMask;
%     InputParameter.FunctionalConnectivity.CovariablesDef;
%     InputParameter.FunctionalConnectivity.VorR_tag;
% GCA
%     InputParameter.GCA.InDirFunImg;
%     InputParameter.GCA.OutFodrGCA;
%     InputParameter.GCA.InFilePathMask;
%     InputParameter.GCA.GCAtype;
%     InputParameter.GCA.AROIDef;
%     InputParameter.GCA.Order;
%     InputParameter.GCA.CoefficientMode;
% Vmhc
%     InputParameter.VMHC.InDirFunImg;
%     InputParameter.VMHC.OutFodrVMHC;
%     InputParameter.VMHC.InFilePathMask;
%     InputParameter.VMHC.CutNumber;
% PerAF
%     InputParameter.PerAF.InDirFunImg;
%     InputParameter.PerAF.OutFodrPerAF;
%     InputParameter.PerAF.InFilePathMask;
% Degree Centrality
%     InputParameter.DegreeCentrality.InDirFunImg;
%     InputParameter.DegreeCentrality.OutFodrDegreeCentrality;
%     InputParameter.DegreeCentrality.InFilePathMask;
%     InputParameter.DegreeCentrality.rThreshold;
%     InputParameter.DegreeCentrality.CutNumber;
%     InputParameter.DegreeCentrality.IsSmooth
%     InputParameter.DegreeCentrality.SmoothFWHM
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201407
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



set_spm_path('default');

    switch upper(AOperation)
        case 'EPIDICOMTONIFTI' %EPI Dicom to Nifti
            run_EpiDicomToNifti(InputParameter);
       case 'T1DICOMTONIFTI' %T1DicomToNifti
            run_T1DicomToNifti(InputParameter);
        case 'REMOVEFIRSTTIMEPOINTS' %Remove First Time Points
            run_RemoveFirstTimePoints(InputParameter);
        case 'SLICETIMING' %Slice Timing
            run_SliceTiming(InputParameter);
        case 'REALIGN' %Realign
            run_Realign(InputParameter);
        case 'REORIENTFUNBEFORECOREG'%ReorientFunBeforeCoreg
            run_ReorientFunBeforeCoreg(InputParameter);
        case 'NORMALIZEEPI' %NormalizeEpi
            run_NormalizeEPI(InputParameter);
        case upper(get_RunStr('NormalizeSymSeg'))
            run_NormalizeSeg_Sym(InputParameter);
        case upper('NormalizeNewSeg_dartel')
            run_Normalize_newsegment_dartel(InputParameter);
        case 'REORIENTT1BEFORECOREG' %ReorientT1BeforeCoreg
            run_ReorientT1BeforeCoreg(InputParameter);
        case 'T1COREGISTERFUN' %T1CoregisterFun
            run_T1CoregisterFun(InputParameter);
        case 'REORIENTT1AFTERCOREG' %ReorientT1AfterCoreg
            run_ReorientT1AfterCoreg(InputParameter);
        case 'T1SEGMENT' %T1Segment
            run_T1Segment(InputParameter);
        case 'NORMALIZESEG' %NormalizeSeg
            run_NormalizeSeg(InputParameter);
        case 'SMOOTH' %Smooth
            run_Smooth(InputParameter);
        case 'DETREND' %Detrend
            run_Detrend(InputParameter);
        case 'FILTER' %Filter
            run_Filter(InputParameter);
        case 'REGRESSOUTCOVARIATES' %RegressOutCovariates
            run_RegressOutCovariates(InputParameter);
        case 'ALFF' %Alff
            run_alff(InputParameter);
        case 'FALFF' %fALFF
            run_fALFF(InputParameter);
        case 'KCCREHO' %KccReHo
            run_KccReHo(InputParameter);
        case 'COHEREHO' %CoHeReHo
            run_CoHeReHo(InputParameter);   
        case 'FUNCTIONALCONNECTIVITY' % Functional Connectivity 
            run_FunctionalConnectivity(InputParameter);
        case 'GCA' % Gca
            run_GCA(InputParameter);
        case 'VMHC' %Vmhc
            run_VMHC(InputParameter);
        case 'PERAF' %PerAF
            run_PerAF(InputParameter);
        case 'DEGREECENTRALITY' %Degree Centrality
            run_DegreeCentrality(InputParameter);
        otherwise
            error('error usage for restpro_run!');
            


    end
end

function run_EpiDicomToNifti(InputParameter)
indir_FunRaw=InputParameter.EpiDicomToNifti.InDirFunRaw;
outdir_FunImg=InputParameter.EpiDicomToNifti.OutDirFunImg;

indir_Dicom2Nifti(indir_FunRaw,outdir_FunImg);
end


function run_T1DicomToNifti(InputParameter)
indir_T1Raw = InputParameter.T1DicomToNifti.InDirT1Raw;
outdir_T1Img = InputParameter.T1DicomToNifti.OutDirT1Img;

indir_Dicom2Nifti(indir_T1Raw,outdir_T1Img);

end

function run_RemoveFirstTimePoints(InputParameter)
    indir_FunImg=InputParameter.RemoveFirstTimePoints.InDirFunImg;
    outdir_FunImg=InputParameter.RemoveFirstTimePoints.OutDirFunImg;
    TimePointsAmount=InputParameter.RemoveFirstTimePoints.TimePointsAmount;
    
    indir_RmFirstTimePoints(indir_FunImg,outdir_FunImg,TimePointsAmount);
end



function run_SliceTiming(InputParameter)
    indir_FunImg=InputParameter.SliceTiming.InDirFunImg;
    outdir_FunImg=InputParameter.SliceTiming.OutDirFunImg;
    Parameter.SliceNumber=InputParameter.SliceTiming.SliceNumber;
    Parameter.SliceOrder=InputParameter.SliceTiming.SliceOrder;
    Parameter.ReferenceSlice=InputParameter.SliceTiming.ReferenceSlice;
    Parameter.TR=InputParameter.SliceTiming.TR;
    
    indir_SliceTiming(indir_FunImg,outdir_FunImg,Parameter);
end



function run_Realign(InputParameter)
    indir_FunImg=InputParameter.Realign.InDirFunImg;
    outdir_FunImg=InputParameter.Realign.OutDirFunImg;
    outdir_RealignParameter=InputParameter.Realign.RealignParameterDir;
    
    indir_Realign(indir_FunImg,outdir_FunImg,outdir_RealignParameter);
end


function run_ReorientFunBeforeCoreg(InputParameter)

    indir_RealignParameter=InputParameter.ReorientFunBeforeCoreg.RealignParameterDir;
    outFodr_ReorientMat=InputParameter.ReorientFunBeforeCoreg.OutFodr_ReorientMat;
        
    Parameter.ReorientMatPrefix='ReorientFunBeforeCoreg';

    indir_FunReorientImage(indir_RealignParameter,outFodr_ReorientMat,Parameter);
end

function run_NormalizeEPI(InputParameter)
    indir_FunImg=InputParameter.Normalize.EPI.InDirFunImg;
    outdir_FunImg=InputParameter.Normalize.EPI.OutDirFunImg;
    indir_RealignParameter=InputParameter.Normalize.EPI.InDirRealignParameter;
    outfodr_ChekNorm=InputParameter.Normalize.EPI.InFodrChekNormPic;
    
    Parameter.BoundingBox=InputParameter.Normalize.EPI.BoundingBox;
    Parameter.VoxSize=InputParameter.Normalize.EPI.VoxSize;
    
    indir_NormalizeEPI(indir_FunImg,indir_RealignParameter,outdir_FunImg,outfodr_ChekNorm,Parameter);
end


function run_NormalizeSeg_Sym(InputParameter)
   
ori_funimg=InputParameter.Normalize.Seg_Sym.InDirFunImg;
normsym_funimg=InputParameter.Normalize.Seg_Sym.OutDirFunImg;
ori_t1Img=InputParameter.Normalize.Seg_Sym.InDirT1Img;
realignpara=InputParameter.Normalize.Seg_Sym.InDirRealignParameter;
ChekNorm=InputParameter.Normalize.Seg_Sym.InFodrChekNormPic;
Parameter.BoundingBox=InputParameter.Normalize.Seg_Sym.BoundingBox;
Parameter.VoxSize=InputParameter.Normalize.Seg_Sym.VoxSize;
Parameter.AffineRegularisation=InputParameter.Normalize.Seg_Sym.AffineRegularisation;

indir_NormalizeSeg_sym_module(ori_funimg,normsym_funimg,ori_t1Img,realignpara,ChekNorm,Parameter)
end


function run_Normalize_newsegment_dartel(InputParameter)
indir_epi_img          =InputParameter.Normalize.dartel.InDirFunImg;
indir_t1_img           =InputParameter.Normalize.dartel.InDirT1Img;
indir_realignparameter =InputParameter.Normalize.dartel.InDirRealignParameter;
outdir_normalized_epi  =InputParameter.Normalize.dartel.OutDirFunImg;
outdir_t1_new_segment  =InputParameter.Normalize.dartel.OutDirT1NewSegment;
outdir_t1_coregister   =InputParameter.Normalize.dartel.OutDirT1CoregisterFun;
outfolder_Template     =InputParameter.Normalize.dartel.OutFodrTemplate;
output_folder_for_check=InputParameter.Normalize.dartel.InFodrChekNormPic;


parameters.bb          =InputParameter.Normalize.dartel.BoundingBox;
parameters.vox         =InputParameter.Normalize.dartel.VoxSize;
parameters.AffineRegularisation=InputParameter.Normalize.dartel.AffineRegularisation;

indir_Normalize_newsegment_dartel_module...
        (indir_epi_img,indir_t1_img,indir_realignparameter,...
        outdir_normalized_epi,outdir_t1_new_segment,outdir_t1_coregister,...
         parameters,output_folder_for_check,outfolder_Template)
end


function  run_ReorientT1BeforeCoreg(InputParameter)
    indir_T1=InputParameter.ReorientT1BeforeCoreg.InDirT1Img;
    outFodr_ReorientMat=InputParameter.ReorientT1BeforeCoreg.OutFodr_ReorientMat;
    Parameter.ReorientMatPrefix='ReorientT1BeforeCoreg';   

    indir_T1ReorientImage(indir_T1,outFodr_ReorientMat,Parameter)
end

function  run_T1CoregisterFun(InputParameter)
    indir_T1Img=InputParameter.T1CoregisterFun.InDirT1Img;
    indir_RealignParameter=InputParameter.T1CoregisterFun.InDirRealignParameter;
    outdir_T1CoregisterFun=InputParameter.T1CoregisterFun.OutDirT1CoregisterFun;
    
    indir_Coregister(indir_T1Img,indir_RealignParameter,outdir_T1CoregisterFun);
end

function run_ReorientT1AfterCoreg(InputParameter)
indir_T1 =  InputParameter.ReorientT1AfterCoreg.InDirT1Coregister;
outFodr_ReorientMat =  InputParameter.ReorientT1AfterCoreg.OutFodr_ReorientMat;
Parameter.ReorientMatPrefix = 'ReorientT1AfterCoreg';

indir_T1ReorientImage(indir_T1,outFodr_ReorientMat,Parameter);
end

function run_T1Segment(InputParameter)
    indir_T1=InputParameter.Segment.InDirT1;
    outdir_T1Segment=InputParameter.Segment.OutDirT1Segment;
    Parameter.AffineRegularisation=InputParameter.AffineRegularisation;
    
    indir_Segmentation(indir_T1,outdir_T1Segment,Parameter);
end


function run_NormalizeSeg(InputParameter)
    indir_FunImg=InputParameter.NormalizeSeg.InDirFunImg;
    outidr_FunImg=InputParameter.NormalizeSeg.OutDirFunImg;
    indir_T1Seg=InputParameter.NormalizeSeg.InDirT1Seg;
    outfodr_ChekNorm=InputParameter.NormalizeSeg.InFodrChekNormPic;
    
    Parameter.BoundingBox=InputParameter.NormalizeSeg.BoundingBox;
    Parameter.VoxSize=InputParameter.NormalizeSeg.VoxSize;
    
    indir_NormalizeSeg(indir_FunImg,outidr_FunImg,indir_T1Seg,outfodr_ChekNorm,Parameter);
end

function run_Smooth(InputParameter)
    indir_FunImg=InputParameter.Smooth.Gaussian.InDirFunImg;
    outdir_FunImg=InputParameter.Smooth.Gaussian.OutDirFunImg;
    Parameter.FWHM=InputParameter.Smooth.Gaussian.FWHM;
    
    if 3~=length(Parameter.FWHM)
        error('FWHM is not [X X X]');
    end
    
    indir_SPMdefaultSmooth(indir_FunImg,outdir_FunImg,Parameter)
end

function run_Detrend(InputParameter)
 indir_FunImg=InputParameter.Detrend.InDirFunImg;
 outdir_FunImg=InputParameter.Detrend.OutDirFunImg;
 CutNumber=InputParameter.Detrend.CutNumber;
 
 indir_Detrend(indir_FunImg,outdir_FunImg,CutNumber);
end

function run_Filter(InputParameter)

indir_FunImg=InputParameter.Filter.InDirFunImg;
outdir_FunImg=InputParameter.Filter.OutDirFunImg;
infile_Mask=InputParameter.Filter.InFileMask;

Parameter.SamplePeriod=InputParameter.Filter.SamplePeriod;
Parameter.LowPass_HighCutoff=InputParameter.Filter.LowPass_HighCutoff;
Parameter.HighPass_LowCutoff=InputParameter.Filter.HighPass_LowCutoff;
Parameter.IsAddMeanBack=InputParameter.Filter.IsAddMeanBack;
Parameter.CutNumber=InputParameter.Filter.CutNumber;

indir_Filter(indir_FunImg,outdir_FunImg,infile_Mask,Parameter);

end


function run_RegressOutCovariates(InputParameter)
Fun_Indir =InputParameter.RegressOutCovariates.InDirFunImg;
Fun_Outdir =InputParameter.RegressOutCovariates.OutDirFunImg;
Cov_OutDir =InputParameter.RegressOutCovariates.OutDirCov;

Parameter.IsRemoveIntercept=InputParameter.RegressOutCovariates.IsRemoveIntercept;
Parameter.PolynomialTrend=InputParameter.RegressOutCovariates.PolynomialTrend;
Parameter.IsWholeBrain = InputParameter.RegressOutCovariates.IsWholeBrain;
Parameter.IsCSF = InputParameter.RegressOutCovariates.IsCSF;
Parameter.IsWhiteMatter = InputParameter.RegressOutCovariates.IsWhiteMatter;
Parameter.IsHeadMotion_Rigidbody6 = InputParameter.RegressOutCovariates.IsHeadMotion_Rigidbody6;
Parameter.IsOtherCovariatesROI = InputParameter.RegressOutCovariates.IsOtherCovariatesROI;
Parameter.InDirRealignParameter = InputParameter.RegressOutCovariates.InDirRealignParameter;
Parameter.OtherCovariatesROIList = InputParameter.RegressOutCovariates.OtherCovariatesROIList;


indir_RegressOutCov(Fun_Indir,Fun_Outdir,Cov_OutDir,Parameter);
end

function run_alff(InputParameter)
indir_FunImg=InputParameter.alff.InDirFunImg;
outfodr_ALFF=InputParameter.alff.OutFodrALFF;
Maskinfo=InputParameter.alff.InFileMask;
infile_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);


Parameter.SamplePeriod=InputParameter.alff.SamplePeriod;
Parameter.LowPass_HighCutoff=InputParameter.alff.LowPass_HighCutoff;
Parameter.HighPass_LowCutoff=InputParameter.alff.HighPass_LowCutoff;
Parameter.CutNumber=InputParameter.alff.CutNumber;

indir_ALFF(indir_FunImg,outfodr_ALFF,infile_Mask,Parameter);
StandardizedMethod(outfodr_ALFF,infile_Mask);



end


function run_fALFF(InputParameter)
indir_FunImg=InputParameter.fALFF.InDirFunImg;
outfodr_fALFF=InputParameter.fALFF.OutFodrfALFF;
Maskinfo=InputParameter.fALFF.InFileMask;
infile_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);

Parameter.SamplePeriod=InputParameter.fALFF.SamplePeriod;
Parameter.LowPass_HighCutoff=InputParameter.fALFF.LowPass_HighCutoff;
Parameter.HighPass_LowCutoff=InputParameter.fALFF.HighPass_LowCutoff;
Parameter.CutNumber=InputParameter.fALFF.CutNumber;

indir_fALFF(indir_FunImg,outfodr_fALFF,infile_Mask,Parameter);
StandardizedMethod(outfodr_fALFF,infile_Mask);


end


function run_KccReHo(InputParameter)
indir_FunImg=InputParameter.KccReHo.InDirFunImg;
outfodr_KccReHo=InputParameter.KccReHo.OutFodrKccReHo;
Maskinfo=InputParameter.KccReHo.InFileMask;
infile_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);
smooth_FWHM=InputParameter.KccReHo.SmoothFWHM;

Parameter.NVoxel=InputParameter.KccReHo.NVoxel;
Parameter.CutNumber=InputParameter.KccReHo.CutNumber;

indir_KccReHo(indir_FunImg,outfodr_KccReHo,infile_Mask,Parameter);

if 1==InputParameter.KccReHo.IsSmooth
   smooth_and_standardized_postprocess_folder(outfodr_KccReHo,smooth_FWHM,infile_Mask);    
elseif 0==InputParameter.KccReHo.IsSmooth
   StandardizedMethod(outfodr_KccReHo,infile_Mask);
end
    

end


function run_CoHeReHo(InputParameter)
indir_FunImg=InputParameter.CoHe.InDirFunImg;
outfodr_CoHeReHo=InputParameter.CoHe.OutFodrCoHeReHo;
Maskinfo=InputParameter.CoHe.InFileMask;
infile_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);

Parameter.NVoxel=27;
Parameter.Auto=1;
Parameter.Overlap='';
Parameter.TimeP='';

Parameter.SamplePeriod=InputParameter.CoHeReHo.SamplePeriod;
Parameter.LowPass_HighCutoff=InputParameter.CoHeReHo.LowPass_HighCutoff;
Parameter.HighPass_LowCutoff=InputParameter.CoHeReHo.HighPass_LowCutoff;
    
indir_CoHeReHo(indir_FunImg,outfodr_CoHeReHo,infile_Mask,Parameter);
smooth_FWHM=InputParameter.CoHeReHo.SmoothFWHM;

if 1==InputParameter.CoHeReHo.IsSmooth
    smooth_and_standardized_postprocess_folder(outfodr_CoHeReHo,smooth_FWHM,infile_Mask);
elseif 0==InputParameter.CoHeReHo.IsSmooth
     StandardizedMethod(outfodr_CoHeReHo,infile_Mask);
end

end


function run_FunctionalConnectivity(InputParameter)
indir_FunImg=InputParameter.FunctionalConnectivity.InDirFunImg;
outfodr_FC=InputParameter.FunctionalConnectivity.OutFodrFC;
Maskinfo=InputParameter.FunctionalConnectivity.InFilePathMask;
infilepath_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);

Parameter.CovariablesDef.ort_file='';
Parameter.VorR_tag=InputParameter.FunctionalConnectivity.VorR_tag;
Parameter.ROIDef=InputParameter.FunctionalConnectivity.ROIDef;

indir_FunctionalConnectivity(indir_FunImg,outfodr_FC,infilepath_Mask,Parameter);

end



function run_GCA(InputParameter)
indir_FunImg=InputParameter.GCA.InDirFunImg;
outfodr_GCA=InputParameter.GCA.OutFodrGCA;
Maskinfo=InputParameter.GCA.InFilePathMask;
infilepath_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);
Parameter.GCAtype=InputParameter.GCA.GCAtype;
Parameter.AROIDef=InputParameter.GCA.AROIDef;
Parameter.Order=InputParameter.GCA.Order;

if isfield(InputParameter.GCA,'CoefficientMode')
   Parameter.CoefficientMode=InputParameter.GCA.CoefficientMode;
end

indir_GCA(indir_FunImg,outfodr_GCA,infilepath_Mask,Parameter);

end


function run_VMHC(InputParameter)
indir_FunImg=InputParameter.VMHC.InDirFunImg;
outfodr_VMHC=InputParameter.VMHC.OutFodrVMHC;
Maskinfo=InputParameter.VMHC.InFilePathMask;
infile_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);

Parameter.CutNumber=InputParameter.VMHC.CutNumber;

indir_VMHC(indir_FunImg,outfodr_VMHC,infile_Mask,Parameter);
StandardizedMethod(outfodr_VMHC,infile_Mask);

end


function run_PerAF(InputParameter)
indir_FunImg=InputParameter.PerAF.InDirFunImg;
outfodr_PerAF=InputParameter.PerAF.OutFodrPerAF;
Maskinfo=InputParameter.PerAF.InFilePathMask;
infilepath_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);

Parameter='';
indir_PerAF(indir_FunImg,outfodr_PerAF,infilepath_Mask,Parameter);
StandardizedMethod(outfodr_PerAF,infilepath_Mask);

end


function run_DegreeCentrality(InputParameter)
indir_FunImg=InputParameter.DegreeCentrality.InDirFunImg;
outfodr_Result=InputParameter.DegreeCentrality.OutFodrDegreeCentrality;
Maskinfo=InputParameter.DegreeCentrality.InFilePathMask;
infile_Mask=mask_misc('Maskinfo2MaskPath',Maskinfo,indir_FunImg);

Parameter.rThreshold=InputParameter.DegreeCentrality.rThreshold;
Parameter.CutNumber=InputParameter.DegreeCentrality.CutNumber;

indir_DegreeCentrality(indir_FunImg,outfodr_Result,infile_Mask,Parameter);


smooth_FWHM=InputParameter.DegreeCentrality.SmoothFWHM;
if 1==InputParameter.DegreeCentrality.IsSmooth
    smooth_and_standardized_postprocess_folder(outfodr_Result,smooth_FWHM,infile_Mask);
elseif 0==InputParameter.DegreeCentrality.IsSmooth
     StandardizedMethod(outfodr_Result,infile_Mask);
end


end




function [mfolderpath,zfolderpath]= StandardizedMethod(infolder,infile_Mask)
    if ischar(infile_Mask)
        [pathstr, name, ext]=fileparts(infolder);
        mfolderpath=[pathstr filesep get_Prefix('DivideMeanWithinMask') name];
        zfolderpath=[pathstr filesep get_Prefix('CalcZscoreWithinMask') name];
        batch_calc3dimg('DivideMeanWithinMask',infolder,...
                                               mfolderpath,...
                                              infile_Mask);
        batch_calc3dimg('CalcZscoreWithinMask',infolder,...
                                               zfolderpath,...
                                              infile_Mask);
    end
end


function smooth_and_standardized_postprocess_folder(postprocess_folder,smooth_FWHM,infile_Mask)
   [m_postprocess_folder,z_postprocess_folder]=StandardizedMethod(postprocess_folder,infile_Mask);
   
   [pathstr, name, ext]       = fileparts(postprocess_folder);
   [m_pathstr, m_name, m_ext] = fileparts(m_postprocess_folder);
   [z_pathstr, z_name, z_ext] = fileparts(z_postprocess_folder);

    Parameter.FWHM=smooth_FWHM;
   
   s_postprocess_folder =[pathstr filesep get_Postfix('Smooth') name];
   sm_postprocess_folder=[m_pathstr filesep get_Postfix('Smooth') m_name];
   sz_postprocess_folder=[z_pathstr filesep get_Postfix('Smooth') z_name];
   
   inpath_Misc(s_postprocess_folder,'MakeCurrentDir');
   inpath_Misc(sm_postprocess_folder,'MakeCurrentDir');
   inpath_Misc(sz_postprocess_folder,'MakeCurrentDir');
   
   infodr_SPMdefaultSmooth(postprocess_folder,s_postprocess_folder,Parameter);
   infodr_SPMdefaultSmooth(m_postprocess_folder,sm_postprocess_folder,Parameter);
   infodr_SPMdefaultSmooth(z_postprocess_folder,sz_postprocess_folder,Parameter);
end