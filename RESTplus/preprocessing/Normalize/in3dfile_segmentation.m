function in3dfile_segmentation(in_t1_file,out_seg_file,Parameter)
%Parameter.AffineRegularisation
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;
%   151208 jiaxize, support SPM12


SpmBatch.jobs = init_SpmBatch('Segmentation');
copy_brainimage_file(in_t1_file,out_seg_file);
Parameter.SPMPath=get_Parameters('SpmFunctionPath');
if strcmpi(spm('ver'),'SPM8')
    SpmBatch.jobs{1,1}.spatial{1,1}.preproc.opts.tpm={[Parameter.SPMPath,filesep,'tpm',filesep,'grey.nii']; ...
                                                      [Parameter.SPMPath,filesep,'tpm',filesep,'white.nii']; ...
                                                      [Parameter.SPMPath,filesep,'tpm',filesep,'csf.nii']}; 
elseif strcmpi(spm('ver'),'SPM12')
    SpmBatch.jobs{1,1}.spatial{1,1}.preproc.opts.tpm={[Parameter.SPMPath,filesep,'toolbox',filesep,'OldSeg',filesep,'grey.nii']; ...
                                                      [Parameter.SPMPath,filesep,'toolbox',filesep,'OldSeg',filesep,'white.nii']; ...
                                                      [Parameter.SPMPath,filesep,'toolbox',filesep,'OldSeg',filesep,'csf.nii']};                                                  
end
SpmBatch.jobs{1,1}.spatial{1,1}.preproc.data={out_seg_file};
SpmBatch.jobs{1,1}.spatial{1,1}.preproc.opts.regtype=Parameter.AffineRegularisation;

run_SpmBatch(SpmBatch);


end