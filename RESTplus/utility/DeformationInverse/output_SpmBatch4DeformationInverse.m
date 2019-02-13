 function SpmBatch = output_SpmBatch4DeformationInverse(SpmBatch,Parameter)
 %-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150720
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;
  SpmBatch.jobs{1,1}.util{1,1}.defs.comp{1}.inv.comp{1}.sn2def.matname = {Parameter.SnMat_ParameterFile};
  SpmBatch.jobs{1,1}.util{1,1}.defs.comp{1}.inv.space = {[Parameter.ImageToBaseInverseOn ',1']};
  SpmBatch.jobs{1,1}.util{1,1}.defs.fnames=Parameter.ApplyTo_CellList;
  SpmBatch.jobs{1,1}.util{1,1}.defs.savedir.saveusr={Parameter.output_path};
 end