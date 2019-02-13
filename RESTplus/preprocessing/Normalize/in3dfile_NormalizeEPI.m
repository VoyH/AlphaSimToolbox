function in3dfile_NormalizeEPI(image_to_write,source_image,output_image,Parameter)
%Parameter.BoundingBox
%Parameter.VoxSize
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%   151208 jiaxize, support SPM12
    SpmBatch.jobs = init_SpmBatch('NormalizeEPI');
    Parameter.FileList={image_to_write};
    Parameter.MeanFilePath=source_image;
    SpmPath=get_Parameters('SpmFunctionPath');
    
    if (~isfield(Parameter,'Template'))&&(strcmp(SPMversion,'SPM8'))
        Parameter.Template=[SpmPath filesep 'templates' filesep,'EPI.nii'];
    elseif (~isfield(Parameter,'Template'))&&(strcmp(SPMversion,'SPM12'))
        Parameter.Template=[SpmPath filesep 'toolbox' filesep 'OldNorm' filesep 'EPI.nii'];  
    else
       fprintf('\nNormalize Template is %s\n',Parameter.Template);    
    end
    
    
    SpmBatch = output_SpmBatch4_norm_estwrite(SpmBatch,Parameter);
    run_SpmBatch(SpmBatch); 
    
    [pathstr, name, ext]=fileparts(image_to_write);
    move_brainimage_file([pathstr filesep get_Postfix('Normalize') name ext],output_image);
end


