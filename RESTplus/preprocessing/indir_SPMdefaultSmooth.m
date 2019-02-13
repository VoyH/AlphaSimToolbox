function indir_SPMdefaultSmooth(indir_FunImg,outdir_FunImg,Parameter)
    % Parameter.FWHM
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    [ImgType,ImgExt]=indir_Chek(indir_FunImg);
    
    SubfodrList=dir_NameList(indir_FunImg);
    
    SpmBatch=cell(length(SubfodrList),1);
    for i=1:length(SubfodrList)
        SpmBatch{i}.jobs = init_SpmBatch('SPMdefaultSmooth');
        Parameter=init_SmoothParameter(indir_FunImg,SubfodrList{i},ImgType,Parameter);
        SpmBatch{i} = output_SpmBatch4Smooth(SpmBatch{i},Parameter);
    end
    
    
    batch_run_spm_jobman(SubfodrList,SpmBatch);
    
    
    move_InDir2OutDir(indir_FunImg,outdir_FunImg,'RegularExpression',[get_Postfix('Smooth') '*']);

end

function Parameter=init_SmoothParameter(InDir,SubfodrNam,ImgType,Parameter)
    Parameter.FileList=spread_Fodr4SPM([InDir filesep SubfodrNam],ImgType);
end

function SpmBatch = output_SpmBatch4Smooth(SpmBatch,Parameter)
    SpmBatch.jobs{1,1}.spatial{1,1}.smooth.data = Parameter.FileList; 
    SpmBatch.jobs{1,1}.spatial{1,1}.smooth.fwhm =Parameter.FWHM;
    SpmBatch.jobs{1,1}.spatial{1,1}.smooth.prefix =get_Postfix('Smooth');
end

