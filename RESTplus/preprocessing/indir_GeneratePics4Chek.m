function indir_GeneratePics4Chek(indir_Fun,outfodr_Pics)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

    SubfodrList=dir_NameList(indir_Fun);
    for i=1:length(SubfodrList)
        EpiImageIn=inpath_Misc([indir_Fun filesep SubfodrList{i}],'Get1stSubImgPath');
        PicResultNam=[outfodr_Pics filesep SubfodrList{i}];
        generate_Pic4Chek(EpiImageIn,PicResultNam);
    end

end