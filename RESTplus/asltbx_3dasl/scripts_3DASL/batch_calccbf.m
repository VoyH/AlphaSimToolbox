% File: batch_calccbf.m
% purpose: to calculate CBF using the mean Perf difference image and M0wm
%          M0wm is extracted from a white matter mask
defaults=spm_get_defaults;
%spm_defaults;

for sb=1:PAR.nsubs
    
    for s=1:PAR.subs(sb).nsess
        for j=1:PAR.subs(sb).ses(s).nasl
            perfimg=spm_select('EXTFPList', PAR.subs(sb).ses(s).perffolders{j}, ['^' PAR.perfimgfilters{1} '.*\.nii'], 1);    % this is specific to the GE data
            M0img=spm_select('EXTFPList', PAR.subs(sb).ses(s).perffolders{j}, ['^' PAR.perfimgfilters{1} '.*\.nii'], 2)

            v=spm_vol(perfimg);
            perf=spm_read_vols(v);
            v=spm_vol(M0img);
            M0=spm_read_vols(v);
            brainidx=perf>20;
            idx=dat>0.99;
            v=spm_vol(perfimg);
            cbf=aslsimpsub(1, perf, M0, 1450, 1525, 0, 0.85, brainidx);
            v.fname=fullfile(PAR.subs(sb).ses(s).aslfolders{j}, ['CBF.nii']);
            v.n=[1 1];
            v=spm_write_vol(v,cbf/80);
      end
    
    end
 
end
