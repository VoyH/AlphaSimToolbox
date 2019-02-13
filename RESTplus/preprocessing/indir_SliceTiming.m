function indir_SliceTiming(InDir,OutDir,Parameter)
%Slice Timing
%---Parameter.SliceNumber
%---Parameter.SliceOrder
%---Parameter.ReferenceSlice
%---Parameter.TR

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



SubfodrList=dir_NameList(InDir);
[ImgType,ImgExt]=indir_Chek(InDir);

SpmBatch='';
for i=1:length(SubfodrList)
    SpmBatch{i}.jobs = init_SpmBatch('SliceTiming');
    Parameter.FileList=spread_Fodr4SPM([InDir filesep SubfodrList{i}],ImgType);
    SpmBatch{i} = output_SpmBatch4SliceTiming(SpmBatch{i},Parameter); 
    Parameter.FileList='';
end


batch_run_spm_jobman(SubfodrList,SpmBatch);



move_InDir2OutDir(InDir,OutDir,'RegularExpression',[get_Postfix('SliceTiming') '*']);




    
    

 function SpmBatch=output_SpmBatch4SliceTiming(SpmBatch,Parameter)
SpmBatch.jobs{1,1}.temporal{1,1}.st.scans{1}=Parameter.FileList;
SpmBatch.jobs{1,1}.temporal{1,1}.st.nslices = Parameter.SliceNumber;
SpmBatch.jobs{1,1}.temporal{1,1}.st.tr=Parameter.TR;
SpmBatch.jobs{1,1}.temporal{1,1}.st.ta=Parameter.TR-(Parameter.TR/Parameter.SliceNumber);
SpmBatch.jobs{1,1}.temporal{1,1}.st.so = Parameter.SliceOrder;
SpmBatch.jobs{1,1}.temporal{1,1}.st.refslice =Parameter.ReferenceSlice;
SpmBatch.jobs{1,1}.temporal{1,1}.st.prefix=get_Postfix('SliceTiming'); 








