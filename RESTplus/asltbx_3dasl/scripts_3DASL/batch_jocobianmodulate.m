
addpath /pkg/spm8/toolbox/HDW
orgpath=pwd;
for groupnum=2:3
par;
grouploctemplatedir=fullfile(PAR.root,PAR.localtemplate)

clear jobs images

    for sb =1:length(PAR.subjects)
%         sublocdir=fullfile(PAR.root, PAR.groupname{groupnum},PAR.subjects{sb},PAR.anatname);
        for nses = 1%:PAR.nsess(sb)
            grouplocfield=spm_select('FPList',grouploctemplatedir,['^u_.*' PAR.subjects{sb} '.*_'  num2str(nses) '_.*nii']);

            combinedfield=spm_select('FPList',grouploctemplatedir,['^y_combined.*' PAR.subjects{sb} '.*_RP'  num2str(nses) '.nii']);
%             ofieldname=['y_combined' PAR.groupname{groupnum} '_' PAR.subjects{sb} num2str(nses,'_RP%d.nii')];
            if strcmp(combinedfield,'/')||isempty(combinedfield),fprintf('\n No locfield map found for %s sess:%d',PAR.subjects{sb},nses);continue;end
%             ofieldname=fullfile(sublocdir,['combined' PAR.subjects{sb} num2str(nses,'_RP%d.nii')]);
            getjocobian(combinedfield);
            jacobian=spm_select('FPList',grouploctemplatedir,['jy_combined.*' PAR.subjects{sb} '_RP' num2str(nses) '.*nii']);
%             t1=spm_select('FPList',sublocdir,['^w' PAR.groupname{groupnum} '_c1' PAR.subjects{sb} num2str(nses,'_RP%d_.*nii')]);
            t1=spm_select('ExtFPList',grouploctemplatedir,['^wc1' PAR.subjects{sb} '_' num2str(nses) '_.*nii']);
%             t1=spm_select('ExtFPList',sublocdir,['^wc1\w*' PAR.subjects{sb} num2str(nses,'_RP%d_.*img')],1);
%             cbf=spm_select('ExtFPList',grouploctemplatedir,['^wPVEclCBF_' PAR.groupname{groupnum} '_' PAR.subjects{sb} num2str(nses,'_RP_%d.*nii')],1);
            vja=spm_vol(jacobian);
            jdat=spm_read_vols(vja);
            if ~(strcmp(t1,'/')||isempty(t1))
                vt1=spm_vol(t1);
                t1dat=spm_read_vols(vt1);
                t1dat=t1dat.*jdat;
                vt1.fname=fullfile(spm_str_manip(t1,'H'),['j_' spm_str_manip(t1,'tr') '.nii']);
                vt1=spm_write_vol(vt1,t1dat);
            end
                        
%             if ~(strcmp(cbf,'/')||isempty(cbf))  
%                 vcbf=spm_vol(cbf);
%                 cbfdat=spm_read_vols(vcbf);5acdersw
%                 cbfdat=cbfdat.*jdat;
%                 vcbf.fname=fullfile(spm_str_manip(cbf,'H'),['j_' spm_str_manip(cbf,'t')]);
%                 vcbf=spm_write_vol(vcbf,cbfdat);
%             end
     
    end
    end
end

