function in3dfile_Coregister(in_t1_file,in_fun_file,out_core_file)
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

SpmBatch.jobs = init_SpmBatch('Coregister');
copy_brainimage_file(in_t1_file,out_core_file);
SpmBatch.jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.ref = {[in_fun_file ',1']};
SpmBatch.jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.source ={out_core_file};
run_SpmBatch(SpmBatch);
end
