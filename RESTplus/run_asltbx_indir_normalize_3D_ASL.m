function run_asltbx_indir_normalize_3D_ASL()

indir_t1img='/Users/jiaxize/datatest/ASL_Normalize/T1';
indir_m0='/Users/jiaxize/datatest/ASL_Normalize/M0';
indir_cbf='/Users/jiaxize/datatest/ASL_Normalize/CBF';


parameters.M0_name='m0.nii';
parameters.CBF_name='cbf.nii';
parameters.T1_name='t1.nii';
parameters.AffineRegularisation='mni';  %European brains (mni)
parameters.outfodr_ChekNorm='/Users/jiaxize/datatest/ASL_Normalize_pic';
parameters.BoundingBox=[-90,-126,-72;90,90,108];
parameters.VoxSize=[3 3 3];
parameters.m0_index=2;
asltbx_indir_normalize_3D_ASL(indir_t1img,indir_m0,indir_cbf,parameters);

end