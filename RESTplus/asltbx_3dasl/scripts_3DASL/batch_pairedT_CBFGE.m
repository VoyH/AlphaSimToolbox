% File: batch_pairedT_CBF;
%-----------------------------------------------------------------------
% Job saved on 17-May-2015 11:47:51 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear pair scans
nsb=0;
for sb=1:PAR.nsubs
    nimgs=0;
    for s=1:PAR.subs(sb).nsess
        for j=1%:PAR.subs(sb).ses(s).nasl
            file=spm_select('EXTFPList', PAR.subs(sb).ses(s).aslcbffolders{j}, ['^sw.*\.nii'], 1);
            if isempty(file)==0
                nimgs=nimgs+1;
            end
            scans{s,:}=file;
        end
    end
    if nimgs==2,
        nsb=nsb+1;
        pair(nsb).scans=scans;
    end
end
group_dir=fullfile(PAR.root, PAR.STATSDIR);
if ~exist(group_dir)
    %mkdir(group_dir);
    mdir=['!mkdir ' group_dir];
    eval(mdir);
end
subdir=fullfile(group_dir, [PAR.GROUPDIR '_GE']);
if ~exist(subdir)
    %mkdir(group_dir);
    mdir=['!mkdir ' subdir];
    eval(mdir);
end
matlabbatch{1}.spm.stats.factorial_design.dir = { subdir};
matlabbatch{1}.spm.stats.factorial_design.des.pt.pair=pair;
matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {fullfile(PAR.SPM_path, 'tpm', 'mask_ICV.nii')};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
cfg_util('run', matlabbatch);
clear matlabbatch;
cd(subdir);
load SPM.mat
SPM = spm_spm(SPM);


load('SPM.mat');
contrast=[1 -1 zeros(1, nsb)];
% now put T contrast per row into SPM structure
if (isempty(SPM.xCon))                 % setting for spm5
    xcon_1 = 1;
    SPM.xCon=spm_FcUtil('Set',...
        'prepost',...
        'T',...
        'c',...
        contrast', ...
        SPM.xX.xKXs);
else
    xcon_1 = length(SPM.xCon)+1;
    SPM.xCon(end + 1)= spm_FcUtil('Set',...
        'prepost',...
        'T',...
        'c',...
        contrast', ...
        SPM.xX.xKXs);

end
spm_contrasts(SPM, xcon_1:xcon_1);

