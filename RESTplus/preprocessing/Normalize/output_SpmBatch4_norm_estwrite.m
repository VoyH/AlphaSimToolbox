function SpmBatch = output_SpmBatch4_norm_estwrite(SpmBatch,Parameter)
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201509
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj(1,1).source={Parameter.MeanFilePath};
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj(1,1).resample =Parameter.FileList;
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.template={[Parameter.Template ',1']};
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.prefix = get_Postfix('Normalize');

 if isfield(Parameter,'BoundingBox')
     SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.bb=Parameter.BoundingBox;
 end
 if isfield(Parameter,'VoxSize')
 SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.vox=Parameter.VoxSize;
 end
end