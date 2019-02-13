function infile_DeformationInverse(referenceimage,sn_matfile,appliedimage,output_path)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze, LiXun and Huang hui-yuan 201407
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



 if ~isdir(output_path)
      mkdir(output_path);
 end
  
SpmBatch.jobs=init_SpmBatch('DeformationInverse');
SpmBatch.jobs{1,1}.util{1,1}.defs.comp{1}.inv.comp{1}.sn2def.matname = {sn_matfile};
SpmBatch.jobs{1,1}.util{1,1}.defs.comp{1}.inv.space = {[referenceimage ',1']};
SpmBatch.jobs{1,1}.util{1,1}.defs.fnames={[appliedimage,',1']};
SpmBatch.jobs{1,1}.util{1,1}.defs.savedir.saveusr={output_path};
run_SpmBatch(SpmBatch);

end