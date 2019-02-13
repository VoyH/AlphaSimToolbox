function indir_dartel_creat_templates(indir_t1_newsegment,outfolder_Template)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

parameters='';
subject_folder_list=dir_NameList(indir_t1_newsegment);

spm_batch.jobs = init_SpmBatch('run_dartel_creat_templates');
parameters.rc1_filelist='';
parameters.rc2_filelist='';
    
for i=1:length(subject_folder_list)
    infodr_t1_newsegment=[indir_t1_newsegment filesep subject_folder_list{i}];
    parameters=init_parameters_dartel_creat_templates(infodr_t1_newsegment,parameters);    
end

spm_batch = output_SpmBatch_dartel_creat_templates(spm_batch,parameters);
run_SpmBatch(spm_batch);

move_template(fullfile(indir_t1_newsegment,subject_folder_list{1}),outfolder_Template);


end

function parameters=init_parameters_dartel_creat_templates(infodr_t1_newsegment,parameters)
    obj_path=path_operation(infodr_t1_newsegment);
    r1_path_tem=obj_path.must_1_brain_image_with_prefix('rc1');
    parameters.rc1_filelist=[parameters.rc1_filelist;{r1_path_tem}];
    r2_path_tem=obj_path.must_1_brain_image_with_prefix('rc2');
    parameters.rc2_filelist=[parameters.rc2_filelist;{r2_path_tem}];
end


function spm_batch = output_SpmBatch_dartel_creat_templates(spm_batch,parameters)
    spm_batch.jobs{1,1}.spm.tools.dartel.warp.images{1,1}=parameters.rc1_filelist;
    spm_batch.jobs{1,1}.spm.tools.dartel.warp.images{1,2}=parameters.rc2_filelist;
end


function move_template(first_subject_new_segment,outfolder_Template)
template_num=6;
obj_path=path_operation(first_subject_new_segment);            


for i=0:template_num
    current_template=obj_path.must_1_brain_image_with_prefix(['Template_' num2str(i)]);
    [pathstr, name, ext] =fileparts(current_template);
    move_brainimage_file(current_template,...
                         [outfolder_Template filesep name ext]);    
end



end





