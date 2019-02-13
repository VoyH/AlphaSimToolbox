function infodr_NormalizePET(indir_FunImg,indir_SourceImage,current_subject,ImgType,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

    SpmBatch.jobs = init_SpmBatch('NormalizeEPI');
    Parameter=init_PETParameter(indir_FunImg,indir_SourceImage,current_subject,ImgType,Parameter);
    SpmBatch = output_SpmBatch4_norm_estwrite(SpmBatch,Parameter);
    run_SpmBatch(SpmBatch);    
end


function Parameter=init_PETParameter(indir_FunImg,indir_RealignParameter,SubfodrNam,ImgType,Parameter)
Parameter.FileList=spread_Fodr4SPM([indir_FunImg filesep SubfodrNam],ImgType);

Parameter.MeanFilePath=inpath_Misc ([indir_RealignParameter filesep SubfodrNam],'Get1stSubImgPath');

SpmPath=get_Parameters('SpmFunctionPath');
Parameter.Template=[SpmPath filesep 'templates' filesep,'PET.nii'];

end