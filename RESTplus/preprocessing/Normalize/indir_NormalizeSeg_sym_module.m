function indir_NormalizeSeg_sym_module(ori_funimg,normsym_funimg,ori_t1Img,realignpara,ChekNorm,Parameter)
% Normalized T1Img and FunImg to sym template
%Parameter.AffineRegularisation
% T1 normalized predefined
%............................
% sym template
% Parameter.BoundingBox=[-60 -40 -60;60 80 60];
% Parameter.VoxSize=[0.5 0.5 0.5];
% sym T1
% Parameter.VoxSize=[2 2 2];
%..........................
%Parameter.BoundingBox
%Parameter.VoxSize

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

    
 [workdir_pathstr, t1foldername, ext]=fileparts(ori_t1Img);    
coregistered_t1img=do_T1coregister(ori_t1Img,realignpara);
segmented_t1img=do_T1segment(coregistered_t1img,Parameter);
normalized_t1img=do_t1normalize(coregistered_t1img,segmented_t1img); % do not set Parameter in this function!
[GroupT1Img_mean_path template_sym_path]=...
      make_SymGroupT1MeanTemplate(normalized_t1img,[workdir_pathstr filesep get_Postfix('sym_groupt1_mean_temp')]); 
  
  
indir_NormalizeSeg_Sym_run(ori_funimg,normsym_funimg,normalized_t1img,template_sym_path,ChekNorm,Parameter); 
normsym_t1img=[normalized_t1img get_Postfix('Normalize_sym')];

Parameter.VoxSize=[2 2 2];
indir_NormalizeSeg_Sym_run(normalized_t1img,normsym_t1img,normalized_t1img,template_sym_path,'',Parameter); 

end


function coregistered_t1img=do_T1coregister(original_t1Img,InDir_RealignParameter)
    [workdir_pathstr, t1foldername, ext]=fileparts(original_t1Img);
    coregistered_t1img=[workdir_pathstr filesep t1foldername get_Postfix('T1CoregisterFun')];
    indir_Coregister(original_t1Img,InDir_RealignParameter,coregistered_t1img);
end


function segmented_t1img=do_T1segment(coregistered_t1img,Parameter)
[workdir_pathstr, t1foldername, ext]=fileparts(coregistered_t1img);
segmented_t1img=[workdir_pathstr filesep t1foldername get_Postfix('T1Segment')];
indir_Segmentation(coregistered_t1img,segmented_t1img,Parameter);
end


function normalized_t1img=do_t1normalize(coregistered_t1img,segmented_t1img)

[workdir_pathstr, t1foldername, ext]=fileparts(coregistered_t1img);
Parameter.BoundingBox=[-60 -40 -60;60 80 60];
Parameter.VoxSize=[0.5 0.5 0.5];
normalized_t1img=[workdir_pathstr filesep t1foldername get_Postfix('Normalize')];
indir_T1_NormalizeSeg(coregistered_t1img,normalized_t1img,segmented_t1img,Parameter);

end


