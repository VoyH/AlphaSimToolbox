function in3dfile_normalize_seg(in_img,out_img,mat_file,Parameter)
%Parameter.BoundingBox
%Parameter.VoxSize
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


SpmBatch.jobs = init_SpmBatch('Normalizewrite');
SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.subj.matname = {mat_file};
SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.subj.resample = {in_img}; 
if isfield(Parameter,'BoundingBox')
    SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.bb = Parameter.BoundingBox;
end

if isfield(Parameter,'VoxSize')
    SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.vox = Parameter.VoxSize;
end

SpmBatch.jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.prefix = get_Postfix('Normalize');
[pathstr, name, ext]=fileparts(in_img);
run_SpmBatch(SpmBatch)
move_brainimage_file([pathstr filesep get_Postfix('Normalize') name ext],out_img);
end