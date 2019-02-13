function [ImgType,ImgExt]=indir_Chek(InDir)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

Subfodr_TypeChek(InDir);
AmountOk=Subfodr_AmountChek(InDir);
[ImgType,ImgExt]=Subfolder1st_chekImgType(InDir);
HdrOk=SubfodrHdrChek(InDir,ImgType);



if ~AmountOk
    error('Img Amount is not equal for each subject folder');
elseif ~HdrOk
    error('Hdr and Img are not pair for each subject folder');
end


function TypeOk=Subfodr_TypeChek(InDir)
 
[Subfolder1st_ImgType,Subfolder1st_ImgExt]=Subfolder1st_chekImgType(InDir);
SubfolderList=dir_NameList(InDir);

for i=1:length(SubfolderList)
    SubFileList=dir_NameList([InDir filesep SubfolderList{i}]);
    for j=1:length(SubFileList)
         SubFileExt=inpath_Misc([InDir filesep SubfolderList{i} filesep SubFileList{j}],'GetPathExt');
         if strcmp(Subfolder1st_ImgType,'.img')
              TypeOk=IsEqualType4ImgHdr(SubFileExt);
         else
              TypeOk=IsEqualType4File(SubFileExt,Subfolder1st_ImgExt);
         end
         
         if (~TypeOk)&&(~strcmp(SubFileExt,'.mat'))
              fprintf('%s ~= %s\n',SubFileExt,Subfolder1st_ImgExt);
              error('Img Type is not equal in each subject folder');
         end
    end
end


function IsEqual=IsEqualType4ImgHdr(FileExt)
IsEqual=1;
if (~strcmp(FileExt,'.img'))&&(~strcmp(FileExt,'.hdr'))
   IsEqual=0;
end




function IsEqual=IsEqualType4File(FileExt,Subfolder1st_ImgExt)
IsEqual=1;
if ~strcmp(FileExt,Subfolder1st_ImgExt)
   IsEqual=0;
end


function [ImgType,ImgExt]=Subfolder1st_chekImgType(InDir)

FirstSubfolderPath=inpath_Misc(InDir,'Get1stSubPath');
[ImgType,ImgExt]=infodr_ChekImgTyp(FirstSubfolderPath);




function AmountOk=Subfodr_AmountChek(InDir)
AmountOk=1;
FirstSubAmount=inpath_Misc(InDir,'Get1stSubAmount');
SubfodrList=dir_NameList(InDir);
for i=1:length(SubfodrList)
    SubFileAmount=length(dir_NameList([InDir filesep SubfodrList{i}]));
    if SubFileAmount~=FirstSubAmount
       AmountOk=0;
    end
end




function HdrOk=SubfodrHdrChek(InDir,ImgType)
 HdrOk=1;
if strcmp(ImgType,'.img')
     SubfodrList=dir_NameList(InDir);
    for i=1:length(SubfodrList)
        ImgAmount=length(dir([InDir filesep SubfodrList{i} filesep '*.img']));
        HdrAmount=length(dir([InDir filesep SubfodrList{i} filesep '*.hdr']));
        if ImgAmount~=HdrAmount
           HdrOk=0;
        end
    end
end




