% batch_usegment_extractGM;
% extracting segmented GM map based on usegment-ed mat file
% Toolbox for batch processing ASL perfusion based fMRI data.
% All rights reserved.
% Ze Wang @ TRC, CFN, Upenn 2004
%
%segment spm
% apply segm to already normalized images

% Get subject etc parameters
addpath /big1/zwang/Ze_scripts/
if strcmp(spm('ver'),'SPM5')==0 || strcmp(spm('ver'),'SPM8')==0
   close all;
    addpath /pkg/spm8 -begin
end

global defaults;
spm_defaults;


opts = struct('biascor',0,'GM',[0 0 1],'WM',[0 0 0],'CSF',[0 0 0],'cleanup',0);

for groupnum=1:length(PAR.groupname)
    par;
for sb =1:length(PAR.subjects) % for each subject 
    sb
    fprintf('Batch extracting GM for subject %d, %d left....\n',sb,length(PAR.subjects)-sb);
    for nses = 1:PAR.nsess(sb)
        clear P;
        T1=spm_select('FPList',PAR.structdir{sb,nses},['^' PAR.subjects{sb} '.*' PAR.structprefs '.*\.img$']);
        if strcmp(deblank(T1),'/')||isempty(T1)
            fprintf('No T1 exist for %s %s !\n',PAR.subsjects{sb}, PAR.sess{nses});
            continue;
        end
        % Make the default normalization parameters file name
        matname = [spm_str_manip(T1,'sd') '_seg_sn.mat'];
        p=load(matname);
        spm_preproc_writezw(p,opts);

    end
end
end