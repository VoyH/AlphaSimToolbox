% File: batch_nsegment.m
% batch segmentation using the new segmentation approach in spm8
% Toolbox for batch processing ASL perfusion based fMRI data.
% All rights reserved.
% Ze Wang @ TRC, CFN, Upenn 2004


imgs=[];
for sb=1:PAR.nsubs
    for s=1:PAR.subs(sb).nsess   % avg image is saved in the folder of the first session
        for j=1:PAR.subs(sb).ses(s).nt1
            t1img=spm_select('FPList', PAR.subs(sb).ses(s).structdir{j}, ['.*' PAR.structprefs '.*.nii']);
            imgs=strvcat(imgs, t1img);
        end
    end
end
ASLtbx_spmnsegment(imgs);



