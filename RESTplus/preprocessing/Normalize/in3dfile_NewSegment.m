function in3dfile_NewSegment(in_t1,out_new_segment,Parameter)
%InDir_T1=T1ImgCoreg; Or InDir_T1=T1Img
%Parameter.AffineRegularisation='mni';  European brains (mni)
%Parameter.AffineRegularisation='eastern'; East Asian brains (eastern)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

SpmBatch.jobs = init_SpmBatch('NewSegment');
Parameter.SPMPath=get_Parameters('SpmFunctionPath');
copy_brainimage_file(in_t1,out_new_segment);
  
if strcmpi(spm('ver'),'SPM8')
    for i=1:6
       SpmBatch.jobs{1,1}.spm.tools.preproc8.tissue(1,i).tpm{1,1} =...
                           [Parameter.SPMPath filesep 'toolbox' filesep 'Seg' filesep 'TPM.nii' ',' num2str(i)];
       SpmBatch.jobs{1,1}.spm.tools.preproc8.tissue(1,i).warped = [0 0];% Do not need warped results. Warp by DARTEL
    end
elseif strcmpi(spm('ver'),'SPM12')
   for i=1:6
       SpmBatch.jobs{1,1}.spm.tools.preproc8.tissue(1,i).tpm{1,1} =...
                           [Parameter.SPMPath filesep 'tpm' filesep 'TPM.nii' ',' num2str(i)];
   end   
end


SpmBatch.jobs{1,1}.spm.tools.preproc8.warp.affreg=Parameter.AffineRegularisation;
SpmBatch.jobs{1,1}.spm.tools.preproc8.channel.vols={out_new_segment};


 run_SpmBatch(SpmBatch);


end