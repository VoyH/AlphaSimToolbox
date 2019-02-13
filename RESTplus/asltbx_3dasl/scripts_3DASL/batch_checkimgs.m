clear P
P=[];
for sb=1:PAR.nsubs
    for s=1:PAR.subs(sb).nsess
        for j=1%:PAR.subs(sb).ses(s).nasl
            P=strvcat(P, spm_select('EXTFPList', PAR.subs(sb).ses(s).aslfolders{j}, ['^CBF\.nii'], 1));
        end
    end
   
end
nn=floor(PAR.nsubs*2/8);
for i=1:nn
    idx=(i-1)*12+(1:8);
    spm_chk_reg(P(idx,:), 0, 70);
    P(idx,:)
    pause;
end