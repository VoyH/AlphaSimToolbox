par;
opts = struct('biascor',0,'GM',[0 0 1],'WM',[0 0 1],'CSF',[0 0 1],'cleanup',0);
for groupnum=1:2%:length(PAR.groupname)
par;
% get the subdirectories in the main directory
for sb =1:length(PAR.subjects) % for each subject 
    fprintf('Extracting C1 C2 C3 for %s'' data...%g subjects left...\n', char(PAR.subjects{sb}),length(PAR.subjects)-sb);
    for nses = 1:PAR.nsess(sb)
        if isempty(PAR.structdir{sb,nses}) continue; end
        PF=spm_select('FPList',PAR.structdir{sb,nses},['^' PAR.subjects{sb} '.*' PAR.structprefs '.*\.img$']);
        if isempty(PF)
            fprintf('No T1 exist for %s session %s!\n',PAR.subjects{sb},PAR.strudirses{sb,nses});
            continue;
        end
        
        T1 = PF(1,:);
                
        % Make the default normalization parameters file name
        matname = [spm_str_manip(T1,'sdr') '_seg_sn.mat'];
        
        p=load(matname);
        spm_preproc_writezw(p,opts);

    end
end
end