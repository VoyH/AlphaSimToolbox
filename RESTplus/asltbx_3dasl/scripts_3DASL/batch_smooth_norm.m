% File: batch_nsegment_norm.m
clear matlabbatch;
matlabbatch{1}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                          78 76 85];
matlabbatch{1}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
matlabbatch{1}.spm.spatial.normalise.write.woptions.interp = 4;
for sb=1:PAR.nsubs
    for s=1:PAR.subs(sb).nsess   % avg image is saved in the folder of the first session
        for j=1:PAR.subs(sb).ses(s).nasl
            P=[];
    %         P=spm_select('EXTFPList', PAR.subs(sb).ses(s).structdir{1}, ['^wc1' PAR.structprefs '.*.nii'],1);
            P=strvcat(P, spm_select('FPList', PAR.subs(sb).ses(s).perffolders{j}, ['^w' PAR.cbfimgfilters{1} '.*.nii']));
            for im=1:size(P,1)
                Pim=P(im,:);
                [pth,name,ext,num]=spm_fileparts(Pim);
                Qim=fullfile(pth,['s' name '.nii']);
                spm_smooth(Pim,Qim,[8]);
            end
        end
    end
end
if isempty(PAR.outputprefix)
    PAR.outputprefix='sw';
elseif PAR.outputprefix(1)~='s'
    PAR.outputprefix=['s' PAR.outputprefix];
end



