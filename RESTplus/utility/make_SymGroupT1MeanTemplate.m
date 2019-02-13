function [GroupT1Img_mean_path GroupT1Img_mean_sym_path] = make_SymGroupT1MeanTemplate(indir_NormalizedT1,outfolder_Template)


% Normalize T1Img
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



GroupT1Img_sum=0;
subfolderlist=dir_NameList(indir_NormalizedT1);
for i=1:length(subfolderlist)
    current_subject_path=[indir_NormalizedT1 filesep subfolderlist{i}];
    w_t1imgpath=inpath_Misc(current_subject_path,'Get1stSubImgPath');
    [Data Vox Header]=read_To3d(w_t1imgpath); 
    GroupT1Img_sum = GroupT1Img_sum + Data;
end


GroupT1Img_mean=GroupT1Img_sum./length(subfolderlist);
GroupT1Img_mean_path=[outfolder_Template filesep 'GroupT1MeanTemplate.nii'];
write_To3dNifti(GroupT1Img_mean,GroupT1Img_mean_path,size(GroupT1Img_mean),Vox,Header,'single');

GroupT1Img_mean_sym = (GroupT1Img_mean + flipdim(GroupT1Img_mean,1))/2;
GroupT1Img_mean_sym_path = [outfolder_Template filesep,'SymmetricGroupT1MeanTemplate.nii'];
write_To3dNifti(GroupT1Img_mean_sym,GroupT1Img_mean_sym_path,size(GroupT1Img_mean_sym),Vox,Header,'single');



end


