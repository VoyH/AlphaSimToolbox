function in3dfile_Normalize_dartel(in_epi_img,out_normalized_epi,infodr_t1_newsegment,parameters)
%parameters.bb
%parameters.vox
%Normalize in_epi_img by dartel
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

SpmBatch.jobs = init_SpmBatch('dartel_normalise_to_mni_space');

parameters=init_parameters(infodr_t1_newsegment,in_epi_img,parameters);
SpmBatch=init_Normalize_dartel_SpmBatch(parameters);  
run_SpmBatch(SpmBatch);
[pathstr, name, ext]=fileparts(in_epi_img);
copy_brainimage_file([pathstr filesep get_Postfix('Normalize_dartel') name ext],...
                     out_normalized_epi);

end

function parameters= init_parameters(infodr_t1_newsegment,in_epi_img,parameters)
obj_path=path_operation(infodr_t1_newsegment);            
parameters.images={in_epi_img};
parameters.template={obj_path.must_1_brain_image_with_prefix('Template_6')}; 
parameters.fwhm=[0 0 0];
parameters.preserve=0;
parameters.flowfield={obj_path.must_1_brain_image_with_prefix('u_')}; 
end

function SpmBatch=init_Normalize_dartel_SpmBatch(parameters)
SpmBatch.jobs{1,1}.spm.tools.dartel.mni_norm.fwhm=parameters.fwhm;
SpmBatch.jobs{1,1}.spm.tools.dartel.mni_norm.preserve=parameters.preserve;
SpmBatch.jobs{1,1}.spm.tools.dartel.mni_norm.bb=parameters.bb;
SpmBatch.jobs{1,1}.spm.tools.dartel.mni_norm.vox=parameters.vox;
SpmBatch.jobs{1,1}.spm.tools.dartel.mni_norm.template=parameters.template;
SpmBatch.jobs{1,1}.spm.tools.dartel.mni_norm.data.subj(1,1).images=parameters.images;
SpmBatch.jobs{1,1}.spm.tools.dartel.mni_norm.data.subj(1,1).flowfield=parameters.flowfield;
end