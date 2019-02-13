% File: batch_pairedT_CBF;
%-----------------------------------------------------------------------
% Job saved on 17-May-2015 11:47:51 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear matlabbatch pair scans
if isempty(PAR.outputprefix) PAR.outputprefix='sw'; end
for sb=1:PAR.nsubs
    for s=1:PAR.subs(sb).nsess
        for j=1:PAR.subs(sb).ses(s).nasl
            scans{j,:}=deblank(spm_select('EXTFPList', PAR.subs(sb).ses(s).perffolders{j}, ['^' PAR.outputprefix PAR.cbfimgfilters{1} '.*.nii'], 1));
        end
    end
    pair(sb).scans=scans;
end
% create a folder for holding the statistical analysis results
group_dir=fullfile(PAR.root, PAR.STATSDIR);
if ~exist(group_dir)
    %mkdir(group_dir);
    mdir=['!mkdir ' group_dir];
    eval(mdir);
end
subdir=fullfile(group_dir, PAR.ASLGROUPDIR);
if ~exist(subdir)
    %mkdir(group_dir);
    mdir=['!mkdir ' subdir];
    eval(mdir);
end
% using SPM to do the paired-t test
matlabbatch{1}.spm.stats.factorial_design.dir = { subdir};
matlabbatch{1}.spm.stats.factorial_design.des.pt.pair=pair;
matlabbatch{1}.spm.stats.factorial_design.des.pt.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.pt.ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov = struct('files', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {fullfile(PAR.root, 'ch2betmask.nii')};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;
cfg_util('run', matlabbatch);
clear matlabbatch;
cd(subdir);
load SPM.mat
SPM = spm_spm(SPM);

% defining the contrasts
load('SPM.mat');
allcon=[-1 1 zeros(1, PAR.nsubs)
    1 -1 zeros(1, PAR.nsubs)];
direction={'task-rest' 'rest-task'};
% now put T contrast per row into SPM structure
xcon_1 = length(SPM.xCon)+1;
ncons=size(allcon,1);		
	              % now put T contrast per row into SPM structure
 for cn = 1:size(allcon,1)
     if cn==1&& (isempty(SPM.xCon))                 % setting for spm5
        SPM.xCon=spm_FcUtil('Set',...
                         [direction{cn}],...
                         'T',...
                         'c',...
                         allcon(cn,:)', ...
                         SPM.xX.xKXs);
     else
       SPM.xCon(end + 1)= spm_FcUtil('Set',...
                          [direction{cn}],...
                         'T',...
                         'c',...
                         allcon(cn,:)', ...
                         SPM.xX.xKXs);
     end
end
		
	% Estimate only the contrasts we've added
	spm_contrasts(SPM, xcon_1:xcon_1+ncons-1);
