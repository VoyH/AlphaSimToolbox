function asltbx_indir_normalize_3D_ASL(indir_t1img,indir_m0,indir_cbf,parameters)
%parameters.M0_name
%parameters.CBF_name
%parameters.T1_name
%parameters.AffineRegularisation='mni';  European brains (mni)
%parameters.AffineRegularisation='eastern'; East Asian brains (eastern)
%parameters.outfodr_ChekNorm
%parameters.BoundingBox
%parameters.VoxSize


[m0_coreg,cbf_coreg]=indir_3dasl_coregister(indir_t1img,indir_m0,indir_cbf,parameters);
indir_Segmentation(indir_t1img,[indir_t1img 'S'],parameters);
indir_NormalizeSeg(cbf_coreg,[cbf_coreg 'W'],[indir_t1img 'S'],parameters.outfodr_ChekNorm,parameters);

end






function [m0_coreg,cbf_coreg]= indir_3dasl_coregister(indir_t1img,indir_m0,indir_cbf,parameters)

subject_list=dir_NameList(indir_t1img);
SpmBatch=cell(length(subject_list),1);

for i=1:length(subject_list)
    SpmBatch{i}.jobs = init_SpmBatch('Coregister');
    parameters=init_coregister_parameter(indir_t1img,indir_m0,indir_cbf,subject_list{i},parameters);
    SpmBatch{i} = output_SpmBatch4Corgstr(SpmBatch{i},parameters);
end

batch_run_spm_jobman(subject_list,SpmBatch);

m0_coreg=[indir_m0 'C'];
cbf_coreg=[indir_cbf 'C'];

copy_InDir2OutDir(indir_m0,m0_coreg);
copy_InDir2OutDir(indir_cbf,cbf_coreg);

end

function parameters=init_coregister_parameter(indir_t1img,indir_m0,indir_cbf,subject_name,parameters)
    parameters.t1img_file_path=[indir_t1img filesep subject_name filesep parameters.T1_name];
    parameters.m0_file_path=[indir_m0 filesep subject_name filesep parameters.M0_name];
    parameters.cbf_file_path=[indir_cbf filesep subject_name filesep parameters.CBF_name];
end




function SpmBatch = output_SpmBatch4Corgstr(SpmBatch,parameters)
SpmBatch.jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.ref = {[parameters.t1img_file_path ',1']};
if ~ischar(parameters.m0_index)
   parameters.m0_index=num2str(parameters.m0_index);
end
SpmBatch.jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.source ={[parameters.m0_file_path,',' parameters.m0_index]};
SpmBatch.jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.other = {parameters.cbf_file_path};
end