% File: batch_coreg_anat2func.m
% purpose: to coregister structure image with functional image (ASL here)
% and resample the segmented images into the functional image space.
defaults=spm_get_defaults;
%spm_defaults;
flags = defaults.coreg;
resFlags = struct(...
        'interp', 1,...                       % trilinear interpolation
        'wrap', flags.write.wrap,...           % wrapping info (ignore...)
        'mask', flags.write.mask,...           % masking (see spm_reslice)
        'which',1,...                         % write reslice time series for later use, don't write the first 1
        'mean',0);                            % do write mean image
for sb=1:PAR.nsubs
    % will use the average T1 from the 1st scan of both sessions (pre and
    % post drug here) as the source
    source=spm_select('FPList', PAR.subs(sb).ses(1).structdir{1}, ['^avg.*.nii']);
    c1img=spm_select('FPList', PAR.subs(sb).ses(1).structdir{1}, ['^c1avg.*.nii']);
    c2img=spm_select('FPList', PAR.subs(sb).ses(1).structdir{1}, ['^c2avg.*.nii']);
    for s=1:PAR.subs(sb).nsess
        for j=1:PAR.subs(sb).ses(s).nasl
            target=spm_select('EXTFPList', PAR.subs(sb).ses(s).aslfolders{j}, ['^' PAR.confilters{1} '.*\.nii'], 2);    % this is specific to the GE data
            wmimg=fullfile(PAR.subs(sb).ses(s).aslfolders{j}, ['bk_' spm_str_manip(c2img,'t')]);
            gmimg=fullfile(PAR.subs(sb).ses(s).aslfolders{j}, ['bk_' spm_str_manip(c1img,'t')]);
            cpstr=['!cp '  c2img ' ' wmimg  ];
            eval(cpstr);    % make a copy of the T1
            cpstr=['!cp '  c1img ' ' gmimg  ];
            eval(cpstr);    % make a copy of the T1
            allimgs=strvcat(wmimg, gmimg);
            ASLtbx_spmcoreg(target, source, allimgs);
            allimgs=strvcat(target, allimgs);
            spm_reslice_flt(allimgs,resFlags);
            eval(['!rm -f '  PAR.subs(sb).ses(s).aslfolders{j} '/bk_*.nii']);
    
      end
    
    end
 
end



