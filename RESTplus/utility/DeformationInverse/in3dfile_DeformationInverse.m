function in3dfile_DeformationInverse...
         (inpath_snmat,inpath_orig_image,inpath_norm_image,output_path)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


     
 Parameter.ImageToBaseInverseOn=inpath_orig_image;
 Parameter.SnMat_ParameterFile=inpath_snmat;
 Parameter.ApplyTo_CellList={[inpath_norm_image ',1']}; 
 Parameter.output_path=output_path;     

   if ~isdir(output_path)
      mkdir(output_path);
   end
  
 SpmBatch.jobs=init_SpmBatch('DeformationInverse');
 SpmBatch = output_SpmBatch4DeformationInverse(SpmBatch,Parameter);
 run_SpmBatch(SpmBatch);
 
end