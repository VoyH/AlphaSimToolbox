% File: batch_pairedT_CBF;
%-----------------------------------------------------------------------
% Job saved on 17-May-2015 11:47:51 by cfg_util (rev $Rev: 6134 $)
% spm SPM - SPM12 (6225)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
clear pair scans
nsb=0;
for sb=1:PAR.nsubs
    P=[];
    nimgs=0;
    for s=1:PAR.subs(sb).nsess
        for j=1%:PAR.subs(sb).ses(s).nasl
            file=spm_select('EXTFPList', PAR.subs(sb).ses(s).aslcbffolders{j}, ['^sw.*\.nii'], 1);
            if isempty(file)==0
                nimgs=nimgs+1;
                P=strvcat(P, file);
            end
            
        end
    end
    v=spm_vol(P);
    dat=spm_read_vols(v);
    difcbf=dat(:,:,:,1)-dat(:,:,:,2);
    vo=v(1);
    vo.fname=spm_file(vo.fname, 'prefix', 'PRE_POS');
    vo=spm_write_vol(vo,difcbf);
end


