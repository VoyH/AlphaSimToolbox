function ReorientImage(ImageIn,outpath_ReorientMat)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


inpath_Misc(outpath_ReorientMat,'MakeParentDir');
ImageName=inpath_Misc(ImageIn,'GetPathWholeName');
ParentFodrName=inpath_Misc(ImageIn,'GetParentWholeName');
% fprintf('Reorienting image for %s: \n',[ParentFodrName filesep ImageName]);

global use_spm_image_Parameters
use_spm_image_Parameters.ReorientFileList={[ImageIn,',1']};
uiwait(use_spm_image('init',ImageIn));
mat=use_spm_image_Parameters.ReorientMat;


save(outpath_ReorientMat,'mat')
clear global use_spm_image_Parameters
fprintf('Reorienting image for %s: OK \n',[ParentFodrName filesep ImageName]);
end






