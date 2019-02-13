for groupnum=1:length(PAR.groupname)
    par;

for sb =1:length(PAR.subjects) % for each subject 
    clear P;
    fprintf('Batch dartel importing for subject %d, %d left....\n',sb,PAR.nsubs-sb);
    for nses = 1:PAR.nsess(sb)
        if  isempty(PAR.structdir{sb,nses}), continue; end
        clear matlabbatch;
        matname=spm_select('FPList',PAR.structdir{sb,nses},'\w*.*_seg8\.mat$');

        if strcmp(deblank(matname),'/')    
            fprintf('No usegment mat file exist for %s!\n',PAR.subs(sb).ses(nses).name);
            continue;
        end
        res=load(matname);
        N   = numel(res.image);
        Kb  = max(res.lkp);
        tc   = false(Kb,4);  % native, import, warped, warped-mod
        tc(1:2, 2) = true;       % only create imported maps
        bf = false(N,2);      % field, corrected: true will produce bias field and/or bias field corrected images
        df = false(1,2);      % inverse, forward, true will generate iy and/or y file
        spm_preproc_write8(res,tc,bf,df);
         
        end        
    end
end

