function all_out=pipeline_parameters_check(AOperation,InputParameter,all_out)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201407
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



     switch upper(AOperation)
            case 'EPIDICOMTONIFTI' %EPI Dicom to Nifti
                 all_out=EPI_DICOM_to_NIFTI(InputParameter,all_out);
            case 'T1DICOMTONIFTI' %T1DicomToNifti
                 all_out=T1_DICOM_to_NIFTI(InputParameter,all_out);
            case 'REMOVEFIRSTTIMEPOINTS' %Remove First Time Points
                 all_out=check_RemoveFirstTimePoints(InputParameter,all_out);
            case 'SLICETIMING' %Slice Timing
                 all_out=check_SliceTiming(InputParameter,all_out);
            case 'REALIGN' %Realign
                 all_out=check_Realign(InputParameter,all_out);
            case 'REORIENTFUNBEFORECOREG'%ReorientFunBeforeCoreg
                 all_out=check_reorient_fun_before_coreg(InputParameter,all_out);
            case 'NORMALIZEEPI' %NormalizeEpi
                 all_out=check_NormalizeEPI(InputParameter,all_out);                
            case 'REORIENTT1BEFORECOREG' %ReorientT1BeforeCoreg
                 all_out=check_reorient_t1_before_coreg(InputParameter,all_out);
            case 'T1COREGISTERFUN' %T1CoregisterFun
                 all_out=check_T1CoregisterFun(InputParameter,all_out);                                 
            case 'REORIENTT1AFTERCOREG' %ReorientT1AfterCoreg
                 all_out=check_reorient_t1_after_coreg(InputParameter,all_out);
            case 'T1SEGMENT' %T1Segment
                 all_out=check_T1Segment(InputParameter,all_out);                                                  
            case 'NORMALIZESEG' %NormalizeSeg
                 all_out=check_NormalizeSeg(InputParameter,all_out);  
            case upper('NormalizeSymSeg')

            case  upper('NormalizeNewSeg_dartel')
                 all_out=check_normalize_new_seg_dartel(InputParameter,all_out);
            case 'SMOOTH' %Smooth
                 all_out=check_Smooth(InputParameter,all_out);
            case 'DETREND' %Detrend
                 all_out=check_Detrend(InputParameter,all_out);
            case 'FILTER' %Filter
                 all_out=check_Filter(InputParameter,all_out);
            case 'REGRESSOUTCOVARIATES' %RegressOutCovariates
                 all_out=check_RegressOutCovariates(InputParameter,all_out);
            case 'ALFF' %Alff
                 all_out=check_ALFF(InputParameter,all_out);                
            case 'FALFF' %fALFF
                 all_out=check_fALFF(InputParameter,all_out);
            case 'KCCREHO' %KccReHo
                 all_out=check_KccReHo(InputParameter,all_out);
            case 'COHEREHO' %CoHeReHo
                 all_out=check_CoheReHo(InputParameter,all_out);
           case 'FUNCTIONALCONNECTIVITY' % Functional Connectivity 
                 all_out=check_functional_connectivity(InputParameter,all_out);  
           case 'GCA' % Gca
                 all_out=check_gca(InputParameter,all_out);
           case 'VMHC' %Vmhc
                 all_out=check_VHMC(InputParameter,all_out);
            case 'PERAF' %PerAF
                 all_out=check_PerAF(InputParameter,all_out);
            case 'DEGREECENTRALITY' %Degree Centrality
                 all_out=check_DegreeCentrality(InputParameter,all_out);
            otherwise
                error('error usage for check!');

     end

end

 

function all_out=EPI_DICOM_to_NIFTI(input_parameter,all_out)
         process_string='Epi dicom to nifti';
         input_checking(input_parameter.EpiDicomToNifti.InDirFunRaw,  process_string ,all_out);
all_out=output_checking(input_parameter.EpiDicomToNifti.OutDirFunImg,  process_string,all_out);
    
end


function all_out=T1_DICOM_to_NIFTI(input_parameter,all_out)
        process_string='T1 dicom to nifti';
        input_checking(input_parameter.T1DicomToNifti.InDirT1Raw  ,process_string ,all_out);
all_out=output_checking(input_parameter.T1DicomToNifti.OutDirT1Img,process_string ,all_out);
end


function all_out=check_RemoveFirstTimePoints(InputParameter,all_out)
             process_string='Remove first time points';
             input_checking(InputParameter.RemoveFirstTimePoints.InDirFunImg  ,process_string,all_out);    
     all_out=output_checking(InputParameter.RemoveFirstTimePoints.OutDirFunImg,process_string,all_out);
end


function all_out=check_SliceTiming(InputParameter,all_out)
            process_string='Slice timing';
           input_checking(InputParameter.SliceTiming.InDirFunImg,  process_string,all_out);
   all_out=output_checking(InputParameter.SliceTiming.OutDirFunImg,process_string,all_out);
end


function all_out=check_Realign(InputParameter,all_out)
    process_string='Realign';
    
            input_checking(InputParameter.Realign.InDirFunImg         ,process_string,all_out);
    all_out=output_checking(InputParameter.Realign.OutDirFunImg       ,process_string,all_out);
    all_out=output_checking(InputParameter.Realign.RealignParameterDir,process_string,all_out);   
end


function all_out=check_reorient_fun_before_coreg(InputParameter,all_out)
   process_string='Reorient fun before coregister';
   
   input_checking(InputParameter.ReorientFunBeforeCoreg.RealignParameterDir   ,process_string,all_out);
end


function all_out=check_NormalizeEPI(InputParameter,all_out)
    P_string='Normalize';

            input_checking(InputParameter.Normalize.EPI.InDirFunImg          ,P_string,all_out);
            input_checking(InputParameter.Normalize.EPI.InDirRealignParameter,P_string,all_out);
    all_out=output_checking(InputParameter.Normalize.EPI.OutDirFunImg        ,P_string,all_out);
    all_out=output_checking(InputParameter.Normalize.EPI.InFodrChekNormPic   ,P_string,all_out);

end

function all_out=check_reorient_t1_before_coreg(InputParameter,all_out)
   P_string='Reorient t1 before coregister';
   input_checking(InputParameter.ReorientT1BeforeCoreg.InDirT1Img,P_string,all_out);
   
end


function all_out=check_T1CoregisterFun(InputParameter,all_out)
    P_string='T1 coregister fun';
            input_checking(InputParameter.T1CoregisterFun.InDirT1Img            ,P_string,all_out);
            input_checking(InputParameter.T1CoregisterFun.InDirRealignParameter ,P_string,all_out);
    all_out=output_checking(InputParameter.T1CoregisterFun.OutDirT1CoregisterFun,P_string,all_out);       
end

function all_out=check_reorient_t1_after_coreg(InputParameter,all_out)
P_string='Reorient t1 after coregister';
input_checking(InputParameter.ReorientT1AfterCoreg.InDirT1Coregister,P_string,all_out);
end



function all_out=check_T1Segment(InputParameter,all_out)
P_string='T1 image segmentation';
         input_checking(InputParameter.Segment.InDirT1         ,P_string,all_out);
 all_out=output_checking(InputParameter.Segment.OutDirT1Segment,P_string,all_out);  
      
end


function all_out=check_NormalizeSeg(InputParameter,all_out)
P_string='Normalize by using T1 image unified segmentation';
         input_checking(InputParameter.NormalizeSeg.InDirFunImg       ,P_string,all_out);
         input_checking(InputParameter.NormalizeSeg.InDirT1Seg        ,P_string,all_out);
all_out= output_checking(InputParameter.NormalizeSeg.OutDirFunImg     ,P_string,all_out);    
all_out= output_checking(InputParameter.NormalizeSeg.InFodrChekNormPic,P_string,all_out);    

    
end


function all_out=check_normalize_new_seg_dartel(InputParameter,all_out)
P_string='Normalize(DARTEL)';
         input_checking(InputParameter.Normalize.dartel.InDirFunImg           ,P_string,all_out);
         input_checking(InputParameter.Normalize.dartel.InDirT1Img            ,P_string,all_out);
         input_checking(InputParameter.Normalize.dartel.InDirRealignParameter ,P_string,all_out);
all_out= output_checking(InputParameter.Normalize.dartel.OutDirFunImg         ,P_string,all_out);    
all_out= output_checking(InputParameter.Normalize.dartel.OutDirT1NewSegment   ,P_string,all_out);    
all_out= output_checking(InputParameter.Normalize.dartel.OutDirT1CoregisterFun,P_string,all_out);    
all_out= output_checking(InputParameter.Normalize.dartel.OutFodrTemplate      ,P_string,all_out);    
all_out= output_checking(InputParameter.Normalize.dartel.InFodrChekNormPic    ,P_string,all_out);    

end


function all_out=check_Smooth(InputParameter,all_out)
P_string='Smooth';

          input_checking(InputParameter.Smooth.Gaussian.InDirFunImg   ,P_string,all_out);
all_out= output_checking(InputParameter.Smooth.Gaussian.OutDirFunImg  ,P_string,all_out);    
    
end


function all_out=check_Detrend(InputParameter,all_out)
P_string='Detrend';
           input_checking(InputParameter.Detrend.InDirFunImg   ,P_string,all_out);
  all_out= output_checking(InputParameter.Detrend.OutDirFunImg  ,P_string,all_out);    
           
end


function all_out=check_Filter(InputParameter,all_out)
P_string='Filter';
           input_checking(InputParameter.Filter.InDirFunImg   ,P_string,all_out);
  all_out= output_checking(InputParameter.Filter.OutDirFunImg ,P_string,all_out);
  
    
end


function all_out=check_RegressOutCovariates(InputParameter,all_out)
P_string='Regress out covariates';
           input_checking(InputParameter.RegressOutCovariates.InDirFunImg           ,P_string,all_out);
  if 1==InputParameter.RegressOutCovariates.IsHeadMotion_Rigidbody6
           input_checking(InputParameter.RegressOutCovariates.InDirRealignParameter,P_string,all_out);
  end
  all_out= output_checking(InputParameter.RegressOutCovariates.OutDirFunImg        ,P_string,all_out);
  all_out= output_checking(InputParameter.RegressOutCovariates.OutDirCov           ,P_string,all_out);
  
end


function all_out=check_ALFF(InputParameter,all_out)
P_string='ALFF';
           input_checking(InputParameter.alff.InDirFunImg   ,P_string,all_out);
  all_out= output_checking(InputParameter.alff.OutFodrALFF  ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.alff.OutFodrALFF,...
                                InputParameter.alff.InFileMask,P_string,all_out);
  

                                      
  

end


function all_out=check_fALFF(InputParameter,all_out)
P_string='fALFF';
            input_checking(InputParameter.fALFF.InDirFunImg   ,P_string,all_out);
  all_out= output_checking(InputParameter.fALFF.OutFodrfALFF  ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.fALFF.OutFodrfALFF,...
                                InputParameter.fALFF.InFileMask  ,P_string,all_out);
                            
end


function all_out=check_KccReHo(InputParameter,all_out)

P_string='KCC-ReHo';
            input_checking(InputParameter.KccReHo.InDirFunImg     ,P_string,all_out);
  all_out= output_checking(InputParameter.KccReHo.OutFodrKccReHo  ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.KccReHo.OutFodrKccReHo,...
                                InputParameter.KccReHo.InFileMask  ,P_string,all_out);
                            
end


function all_out=check_CoheReHo(InputParameter,all_out)
P_string='Cohe-ReHo';
                 input_checking(InputParameter.CoHe.InDirFunImg        ,P_string,all_out);
  all_out=      output_checking(InputParameter.CoHe.OutFodrCoHeReHo    ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.CoHe.OutFodrCoHeReHo,...
                                InputParameter.CoHe.InFileMask         ,P_string,all_out); 

end


function all_out=check_functional_connectivity(InputParameter,all_out)
P_string='Functional connectivity';
                 input_checking(InputParameter.FunctionalConnectivity.InDirFunImg    ,P_string,all_out);
  all_out=      output_checking(InputParameter.FunctionalConnectivity.OutFodrFC      ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.FunctionalConnectivity.OutFodrFC,...
                                InputParameter.FunctionalConnectivity.InFilePathMask ,P_string,all_out); 

end


function all_out=check_gca(InputParameter,all_out)
P_string='GCA';
                 input_checking(InputParameter.GCA.InDirFunImg    ,P_string,all_out);
  all_out=      output_checking(InputParameter.GCA.OutFodrGCA     ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.GCA.OutFodrGCA,...
                                InputParameter.GCA.InFilePathMask ,P_string,all_out);
end

function all_out=check_VHMC(InputParameter,all_out)


P_string='VMHC';
           input_checking(InputParameter.VMHC.InDirFunImg     ,P_string,all_out);
  all_out= output_checking(InputParameter.VMHC.OutFodrVMHC    ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.VMHC.OutFodrVMHC,...
                                InputParameter.VMHC.InFilePathMask  ,P_string,all_out);
                            
end


function all_out=check_PerAF(InputParameter,all_out)

P_string='PerAF';
                 input_checking(InputParameter.PerAF.InDirFunImg     ,P_string,all_out);
  all_out=      output_checking(InputParameter.PerAF.OutFodrPerAF    ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.PerAF.OutFodrPerAF,...
                                InputParameter.PerAF.InFilePathMask  ,P_string,all_out);                           
end


function all_out=check_DegreeCentrality(InputParameter,all_out)
 

P_string='DegreeCentrality';
                 input_checking(InputParameter.DegreeCentrality.InDirFunImg             ,P_string,all_out);
  all_out=      output_checking(InputParameter.DegreeCentrality.OutFodrDegreeCentrality ,P_string,all_out);  
  all_out=stand_output_checking(InputParameter.DegreeCentrality.OutFodrDegreeCentrality,...
                                InputParameter.DegreeCentrality.InFilePathMask         ,P_string,all_out);
                            
end



function input_checking(indir_path,process_string,all_output_folder)

[pathstr, name_string, ext] =fileparts(indir_path);

if (~isdir(indir_path))&&(isempty(strfind(all_output_folder,['||' name_string '||'])))
   display_warning_4_input(process_string,name_string);  
   error('RESTplus:stop','program is stopped!');
elseif isempty(name_string)
   name_string='input folder'; 
   display_warning_4_input(process_string,name_string);  
   error('RESTplus:stop','program is stopped!');
end

end


function all_out=output_checking(outdir_funimg,process_string,all_out)

[pathstr, folder_name, ext] =fileparts(outdir_funimg);

    if isdir(outdir_funimg)
%        button=display_dlg_4_output(process_string,name_string);
%        if strcmpi(button,'Yes')
%           rmdir(outdir_funimg,'s');
%           warning('RESTplus:replace','%s is deleted',outdir_funimg);
%        else
%           error('RESTplus:stop','program is stopped!');
%        end
       display_warning_4_output(process_string,folder_name);
       error('RESTplus:stop','program is stopped!');
    end
    all_out=[all_out folder_name '||'];
end


function   all_out=stand_output_checking(output_folder,mask_info,P_string,all_out)
    if (ischar(mask_info))||(mask_info==1)
       [pathstr, name, ext]=fileparts(output_folder);
       mfolderpath=[pathstr filesep get_Prefix('DivideMeanWithinMask') name];
       zfolderpath=[pathstr filesep get_Prefix('CalcZscoreWithinMask') name];
       all_out=output_checking(mfolderpath,P_string,all_out);
       all_out=output_checking(zfolderpath,P_string,all_out);
    end
    
    

                            
    
end





function button=display_dlg_4_output(process_string,folder_name)
       questdlgstr=sprintf('Do you want to replace %s[%s]?',folder_name,process_string); 
       questdlgtitle='Replace!';
       button = questdlg(questdlgstr,questdlgtitle,'Yes','No','Yes');
end

function display_warning_4_output(process_string,folder_name)
 warning_dlg_str=sprintf('%s is already exist[%s], please remove it or delete it!',folder_name,process_string);
 warning_dlg_title='EXIST!';
 warndlg(warning_dlg_str,warning_dlg_title);
end

function display_warning_4_input(process_string,folder_name)
       warning_dlg_str=sprintf('%s is not exist[%s], please check it!',folder_name,process_string);
       warning_dlg_title='NOT EXIST!';
       warndlg(warning_dlg_str,warning_dlg_title);
end


