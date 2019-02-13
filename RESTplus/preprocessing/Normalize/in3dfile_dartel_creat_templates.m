function in3dfile_dartel_creat_templates(infodr_t1_newsegment)
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

spm_batch.jobs = init_SpmBatch('run_dartel_creat_templates');
obj_path=path_operation(infodr_t1_newsegment);
r1_path_tem=obj_path.must_1_brain_image_with_prefix('rc1');
parameters.rc1_filelist={r1_path_tem};
r2_path_tem=obj_path.must_1_brain_image_with_prefix('rc2');
parameters.rc2_filelist={r2_path_tem};


spm_batch.jobs{1,1}.spm.tools.dartel.warp.images{1,1}=parameters.rc1_filelist;
spm_batch.jobs{1,1}.spm.tools.dartel.warp.images{1,2}=parameters.rc2_filelist;
    
run_SpmBatch(spm_batch);

end