% registering local template to MNI and warp individual images to MNI space
clear matlabbatch ufiles images
matlabbatch{1}.spm.tools.dartel.mni_norm.vox = [2 2 2];
matlabbatch{1}.spm.tools.dartel.mni_norm.bb = [NaN NaN NaN
                                               NaN NaN NaN];
matlabbatch{1}.spm.tools.dartel.mni_norm.preserve = 1;
matlabbatch{1}.spm.tools.dartel.mni_norm.fwhm = [8 8 8];

loctpldir=fullfile(PAR.root,PAR.localtemplate);
% P=spm_select('ExtFPList',loctpldir,'^Template_6.nii',1);
P=spm_select('FPList',loctpldir,'^Template_6.nii');  % the affix ,1 should be removed in order to use the lateste version
if strcmp(P,'/')||isempty(P)
    fprintf('No general template found for the two groups!\n');
    return;
end
matlabbatch{1}.spm.tools.dartel.mni_norm.template={P};
for groupnum=1:length(PAR.groupname)
    groupnum
    clear PAR
    par;
    idx=0;
    up=[];
    gp=[];
    wp=[];
    for sb =1:PAR.nsubs % for each subject
        clear P;
        for nses=1:PAR.nsess(sb)
            fprintf('Searching segmented images for subject %d, %d left....\n',sb,PAR.nsubs-sb);

            gmfile=spm_select('FPList',PAR.structdir{sb,nses},'^c1\w*[^nsk]\.nii$');
            wmfile=spm_select('FPList',PAR.structdir{sb,nses},'^c2\w*[^nsk]\.nii$');
            if strcmp(deblank(gmfile),'/')
                fprintf('No usegment mat file exist for %s!\n',PAR.subs(sb).ses(nses).name);
                continue;
            end
            idx=idx+1;
            up=strvcat(up,spm_select('FPList',loctpldir,['^u_.*' PAR.subjects{sb} '_' num2str(nses) '_.*\.nii']));
            gp=strvcat(gp,gmfile);
            wp=strvcat(wp,wmfile);
            
        end
    end
    for im=1:idx
        ufiles{im}=char(deblank(up(im,:)));
        images{1}{im,1}=char(deblank(gp(im,:)));
        images{2}{im,1}=char(deblank(wp(im,:)));
    end
    matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.flowfields=ufiles;
    matlabbatch{1}.spm.tools.dartel.mni_norm.data.subjs.images = images;
    cfg_util('run', matlabbatch);
end
