function ASLtbx_dartelwarp2mni_manysubs(template, fields, images, mod)
%-----------------------------------------------------------------------
% Job saved on 08-May-2015 12:23:16 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
% mod: 0 - no modulation, 1 - with modulation
tpl{1}=deblank(template);
matlabbatch{1}.spm.tools.dartel.mni_norm.template = tpl;
nsbs=size(fields,1);
clear uflows imgs
for s=1:nsbs
    uflows{s,1}=char(deblank(fields(s,:)));
    imgs{s,1}=char(deblank(images(s,:)));
end
imgarr{1}=imgs;
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields = uflows;
matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = imgarr;
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = mod;  
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [8 8 8];
cfg_util('run', matlabbatch);
clear matlabbatch;
