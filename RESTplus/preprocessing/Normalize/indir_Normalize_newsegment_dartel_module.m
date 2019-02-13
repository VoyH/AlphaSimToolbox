function indir_Normalize_newsegment_dartel_module...
        (indir_epi_img,        indir_t1img,          indir_realignparameter,...
         outdir_normalized_epi,outdir_t1_new_segment,outdir_t1_coregister,...
         parameters,           output_folder_for_check,outfolder_Template)
     
%parameters.bb
%parameters.vox
%parameters.AffineRegularisation='mni';  European brains (mni)
%parameters.AffineRegularisation='eastern'; East Asian brains (eastern)
%Normalize InDir_Img by dartel
%outfodr_ChekNorm = ''; do not creat folder for check normalize

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


t1_new_segment_path=outdir_t1_new_segment;  
set_spm_path('default');
indir_Coregister(indir_t1img,indir_realignparameter,outdir_t1_coregister);
set_spm_path('default');
indir_NewSegment(outdir_t1_coregister,t1_new_segment_path,parameters);
set_spm_path('default');
indir_dartel_creat_templates(t1_new_segment_path,outfolder_Template);
set_spm_path('default');
indir_Normalize_dartel(indir_epi_img,outfolder_Template,t1_new_segment_path,outdir_normalized_epi,output_folder_for_check,parameters);

end