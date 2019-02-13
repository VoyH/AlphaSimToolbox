% File: batch_reset_orientation_t1.m
P=[];
for sb=1:PAR.nsubs
    for s=1:PAR.subs(sb).nsess
        for j=1:PAR.subs(sb).ses(s).nt1
            P=strvcat(P,spm_select('EXTFPList', PAR.subs(sb).ses(s).structdir{j}, ['.*' PAR.anatname '.*.nii'], 1));
            P=strvcat(P,spm_select('EXTFPList', PAR.subs(sb).ses(s).structdir{j}, ['.*' PAR.anatname2 '.*.nii'], 1));
        end
    end
end
ASLtbx_resetimgorg(P);