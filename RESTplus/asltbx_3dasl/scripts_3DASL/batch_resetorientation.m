% File: batch_reset_orientation.m
% Ze Wang 2015
P=[];
for sb=1:PAR.nsubs
    for s=1:PAR.subs(sb).nsess
        for j=1:PAR.subs(sb).ses(s).nasl
            P=spm_select('FPList', PAR.subs(sb).ses(s).perffolders{j}, ['^' PAR.perfimgfilters{1} '.*.nii']);
            ASLtbx_resetimgorgASL(P);
            P=spm_select('FPList', PAR.subs(sb).ses(s).perffolders{j},  ['^' PAR.cbfimgfilters{1} '.*.nii']);
            ASLtbx_resetimgorgASL(P);
        end
        for j=1:PAR.subs(sb).ses(s).nt1
            P=spm_select('FPList', PAR.subs(sb).ses(s).structdir{j}, ['.*' PAR.structprefs '.*.nii']);
            ASLtbx_resetimgorgASL(P);
        end
    end
end
