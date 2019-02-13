% File: batch_nsegment_norm.m
clear matlabbatch
matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
for sb=1:PAR.nsubs
    for s=1:PAR.subs(sb).nsess   % avg image is saved in the folder of the first session
        for j=1:PAR.subs(sb).ses(s).nasl
            P=spm_select('FPList', PAR.subs(sb).ses(s).perffolders{j},  ['^' PAR.cbfimgfilters{1} '.*.nii']);
            clear imgs;     
            imgs{1,1}=deblank(P);
        
            P=spm_select('FPList', PAR.subs(sb).ses(s).structdir{1}, ['^' PAR.structprefs '.*.nii']);
            matname = fullfile(PAR.subs(sb).ses(s).structdir{1}, ['y_' spm_str_manip(P,'drst') '.nii']);
            
            % matname is the segmentation file name
            matlabbatch{1}.spm.spatial.normalise.write.subj.def{1} = matname;
            matlabbatch{1}.spm.spatial.normalise.write.subj.resample = imgs;
            cfg_util('run', matlabbatch);
            
        end
    end
end
PAR.outputprefix='w';


