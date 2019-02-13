% File: batch_coreg_func2anat.m
% purpose: to coregister ASL images to the structure image. This step is needed before normalization.  You can choose different image such as the perfusion difference,
%   M0 or additionally acquired EPI image as the source to be registered.
% ???????????????????????????????????????????perfusion difference image???????????????
% Ze Wang 2015
par

for sb=1:PAR.nsubs
    % will use the average T1 from the 1st scan of both sessions (pre and
    % post drug here) as the source
       
    for s=1:PAR.subs(sb).nsess
        target=spm_select('FPList', PAR.subs(sb).ses(s).structdir{1}, ['.*' PAR.structprefs '.*.nii']);   % T1 image (????)
        for j=1:PAR.subs(sb).ses(s).nasl
            P=spm_select('EXTFPList', PAR.subs(sb).ses(s).perffolders{j}, ['^' PAR.perfimgfilters{1} '.*\.nii'], 1:4);    
            source=P(2,:);    % use the M0 map as the source (????)          
            img=strvcat(P, spm_select('FPList', PAR.subs(sb).ses(s).perffolders{j}, ['^' PAR.cbfimgfilters{1} '.*.nii']));
            ASLtbx_spmcoreg(target, source, img);    % get the transform M from source to target, and apply to img, ?????????????????????????????????
            
      end
    
    end
 
end



