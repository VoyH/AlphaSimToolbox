function  T1path=infodr_getT1(Infodr_T1Img)
%img
%nii
%nii.gz
%co

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com




Prefix='co';
CoimgList=dir_IMG(Infodr_T1Img,Prefix);
ImgList=dir_IMG(Infodr_T1Img);

if ~isempty(CoimgList)
    T1path=get_coT1file(Infodr_T1Img,CoimgList);
elseif isempty(CoimgList)&&(~isempty(ImgList))
    T1path=get_T1file(Infodr_T1Img,ImgList);
else 
    T1path='';   
    fprintf('There is no img file in \n%s\n',Infodr_T1Img);
end

function T1path=get_coT1file(Infodr_T1Img,CoimgList)
% there is co* in T1Img
if ~isempty(CoimgList.nii)
    T1path{1}=[Infodr_T1Img filesep CoimgList.nii{1}];
elseif ~isempty(CoimgList.niigz)
    T1path{1}=inpath_Misc([Infodr_T1Img filesep CoimgList.niigz{1}],'GunzipNiigzPath');
elseif ~isempty(CoimgList.img)
    T1path{1}=[Infodr_T1Img filesep CoimgList.img{1}];
    T1path{2}=[Infodr_T1Img filesep CoimgList.hdr{1}];    
end


function T1path=get_T1file(Infodr_T1Img,ImgList)
% there is no co* in T1Img
if ~isempty(ImgList.nii)
    T1path{1}=[Infodr_T1Img filesep ImgList.nii{1}];
elseif ~isempty(ImgList.niigz)
    T1path{1}=inpath_Misc([Infodr_T1Img filesep ImgList.niigz{1}],'GunzipNiigzPath');
elseif ~isempty(ImgList.img)
    T1path{1}=[Infodr_T1Img filesep ImgList.img{1}];
    T1path{2}=[Infodr_T1Img filesep ImgList.hdr{1}];    
end    
    
    
   