function infodr_NormalizeEPI(indir_FunImg,indir_RealignParameter,current_subject,ImgType,Parameter)
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150201
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;
%   151208 jiaxize, support SPM12

    SpmBatch.jobs = init_SpmBatch('NormalizeEPI');
    Parameter=init_EPIParameter(indir_FunImg,indir_RealignParameter,current_subject,ImgType,Parameter);
    SpmBatch = output_SpmBatch4_norm_estwrite(SpmBatch,Parameter);
    run_SpmBatch(SpmBatch);    
end


function Parameter=init_EPIParameter(indir_FunImg,indir_RealignParameter,SubfodrNam,ImgType,Parameter)
Parameter.FileList=spread_Fodr4SPM([indir_FunImg filesep SubfodrNam],ImgType);
Parameter.MeanFilePath=get_MeanImgPath([indir_RealignParameter filesep SubfodrNam]);
SpmPath=get_Parameters('SpmFunctionPath');
[SPMversion,c]=spm('Ver');

if (~isfield(Parameter,'Template'))&&(strcmp(SPMversion,'SPM8'))
   Parameter.Template=[SpmPath filesep 'templates' filesep 'EPI.nii'];
elseif (~isfield(Parameter,'Template'))&&(strcmp(SPMversion,'SPM5'))
   Parameter.Template=[SpmPath filesep 'templates' filesep 'EPI.nii'];        
elseif (~isfield(Parameter,'Template'))&&(strcmp(SPMversion,'SPM12'))
   Parameter.Template=[SpmPath filesep 'toolbox' filesep 'OldNorm' filesep 'EPI.nii'];  
else
    fprintf('\nNormalize Template is %s\n',Parameter.Template);
end



end




