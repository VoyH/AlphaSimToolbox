function indir_T1_NormalizeSeg(InDir_T1Img,OutDir_T1Normalized,InDir_T1Seg,Parameter)
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


SubfodrList=init_InDirAndOutDir(InDir_T1Img,OutDir_T1Normalized);
indir_CopyT1(InDir_T1Img,OutDir_T1Normalized,SubfodrList);
indir_NormalizeSeg(OutDir_T1Normalized,OutDir_T1Normalized,InDir_T1Seg,'',Parameter);
delete_originalT1(SubfodrList,OutDir_T1Normalized);

end


function delete_originalT1(SubfodrList,OutDir_T1Normalized)
for i=1:length(SubfodrList)
    subjectt1folder_path=[OutDir_T1Normalized filesep SubfodrList{i}];
    t1filelist=dir_NameList(subjectt1folder_path);
    for j=1:length(t1filelist)
        if ~strcmpi(t1filelist{j}(1),get_Postfix('Normalize'))
            delete([subjectt1folder_path filesep t1filelist{j}]);
        end
    end
end
end