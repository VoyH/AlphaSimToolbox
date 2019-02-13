par;
orgpath=pwd;
newdir=fullfile(PAR.root,PAR.localtemplate)
if ~exist(newdir,'dir')
    mdir=['!mkdir ' newdir];
    eval(mdir);
end
cd(newdir);
clear jobs images
ST=1;   % right now we only consider the first scan
gmimgs=[];
wmimgs=[];
for sb=1:PAR.nsubs
    for s=1%:PAR.subs(sb).nsess   % avg image is saved in the folder of the first session
        t1img=spm_select('EXTFPList', PAR.subs(sb).ses(s).structdir{ST}, ['^rc1avg.*.nii'], 1);
        gmimgs=strvcat(gmimgs, t1img);
        t1img=spm_select('EXTFPList', PAR.subs(sb).ses(s).structdir{ST}, ['^rc2avg.*.nii'], 1);
        wmimgs=strvcat(wmimgs, t1img);
    end
end
   
ASLtbx_dartel_createtpl(2, PAR.nsubs, gmimgs, wmimgs)

cd(orgpath);