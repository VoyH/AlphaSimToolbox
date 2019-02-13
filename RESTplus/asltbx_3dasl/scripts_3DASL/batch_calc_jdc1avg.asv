% File: batch_calc_jdc1avg.m
% batch calculate the jd*c1 image. c1 is the segmented gray matter of the
% average T1. jd is the jacobian difference.
% Toolbox for batch processing ASL perfusion based fMRI data.
% All rights reserved.
% Ze Wang @ TRC, CFN, Upenn 2004
% This file is made specifically for the longitudinal data. segmentation is
% applied to the mean image of the longitudinal scans
ST=1;   % right now we only consider the first scan
imgs=[];
for sb=1:PAR.nsubs
    for s=1%:PAR.subs(sb).nsess   % avg image is saved in the folder of the first session
        t1img=spm_select('EXTFPList', PAR.subs(sb).ses(s).structdir{ST}, ['^c1avg.*.nii'], 1);
        jdfile=spm_select('EXTFPList', PAR.subs(sb).ses(s).structdir{ST}, ['^jd_.*.nii'], 1);
        v1=spm_vol(t1img);
        dat=spm_read_vols(v1);
        v2=spm_vol(jdfile);
        dat2=spm_read_vols(v2);
        dat=dat.*dat2;
        v=v1;
        v.fname=fullfile(PAR.subs(sb).ses(s).structdir{ST}, 'jdc1avg.nii');
        v.n=[1 1];
        v=spm_write_vol(v,dat);
    end
end




