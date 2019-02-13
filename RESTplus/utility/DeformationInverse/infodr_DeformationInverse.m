function infodr_DeformationInverse(infodr_RealignParameter,infodr_T1ImgSegment,input_AppliedImages,snmat_RegExp,output_path)
% snmat_RegExp : '*_sn.mat'
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


  [pathstr,subfolderName,ext]=fileparts(infodr_RealignParameter);
  Parameter.ImageToBaseInverseOn=get_MeanImgPath(infodr_RealignParameter);
  Parameter.SnMat_ParameterFile=get_MatFilePath(infodr_T1ImgSegment,snmat_RegExp);
  Parameter.ApplyTo_CellList=get_ApplyTo_CellList(input_AppliedImages);
  Parameter.output_path=output_path;     
  if ~isdir(output_path)
      mkdir(output_path);
  end

 SpmBatch.jobs=init_SpmBatch('DeformationInverse');
 SpmBatch = output_SpmBatch4DeformationInverse(SpmBatch,Parameter);
 run_SpmBatch(SpmBatch);
end   
    
    
 function SnMat_ParameterFile=get_MatFilePath(InFolderPath,RegExp)
    SnMat_List=dir_4RegExp(InFolderPath,RegExp);
    if length(SnMat_List)~=1
       error('get_MatFilePath');
    end
    SnMat_ParameterFile=[InFolderPath filesep SnMat_List{1}];    
 end
    
    
 function ApplyTo_CellList=get_ApplyTo_CellList(input_AppliedImages)
    % indir_AppliedImages
    % FunImgARWSD/sub001
    % Result/mALFF/alff_sub001.nii
    
    if 2==exist(input_AppliedImages,'file')%file |input_AppliedImages = Result/mALFF
       ApplyTo_CellList={[input_AppliedImages ',1']}; 
    elseif 7==exist(input_AppliedImages,'file')%folder | input_AppliedImages= FunImgARWSD
       [ImgType,ImgExt]=infodr_ChekImgTyp(input_AppliedImages);
       ApplyTo_CellList=spread_Fodr4SPM(input_AppliedImages,ImgType);        
    else
        error('get_indir_AppliedImages');
    end
    
 end
 
 

    