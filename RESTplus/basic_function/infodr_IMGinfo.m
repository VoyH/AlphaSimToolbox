function IMGinfo=infodr_IMGinfo(InFodr,Option,Parameter)
%Parameter.Prefix
%Parameter will reduce range
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if nargin<=2
    Parameter='';
end
InitValue=init_IMGinfo(InFodr,Parameter);
switch Option
    case 'All'
          IMGinfo.ext=InitValue.IMGext;
          IMGinfo.amount=get_IMGamount(InitValue);
    case 'IMGext'
          IMGinfo=InitValue.IMGext;
    case 'IMGamount'
          IMGinfo=get_IMGamount(InitValue);        
end


function InitValue=init_IMGinfo(InFodr,Parameter)
    if isfield(Parameter,'Prefix')
        ImgList=dir_4RegExp(InFodr,[Parameter.Prefix '*.img']);
        NiiList=dir_4RegExp(InFodr,[Parameter.Prefix '*.nii']);
        NiigzList=dir_4RegExp(InFodr,[Parameter.Prefix '*.nii.gz']);
    else
        ImgList=dir_4RegExp(InFodr, '*.img');
        NiiList=dir_4RegExp(InFodr,'*.nii');
        NiigzList=dir_4RegExp(InFodr,'*.nii.gz');        
    end
    FileList=dir_NameList(InFodr);
    InitValue.IMGext=InitValue_IMGext(ImgList,NiiList,NiigzList);
    InitValue.Amount=InitValue_Amount(ImgList,NiiList,NiigzList,FileList);
    
    
function IMGamount=get_IMGamount(InitValue)
TotalIMGAmount=InitValue.Amount.Img+InitValue.Amount.Nii+InitValue.Amount.Niigz;
if isequal(TotalIMGAmount,InitValue.Amount.Img)
   IMGamount=InitValue.Amount.Img;
elseif isequal(TotalIMGAmount,InitValue.Amount.Nii)
   IMGamount=InitValue.Amount.Nii;
elseif isequal(TotalIMGAmount,InitValue.Amount.Niigz)
   IMGamount=InitValue.Amount.Niigz;    
else
   IMGamount.Img=InitValue.Amount.Img;
   IMGamount.Nii=InitValue.Amount.Nii;
   IMGamount.Niigz=InitValue.Amount.Niigz;
   IMGamount.other=InitValue.Amount.AllFile-TotalIMGAmount;
end
    

 
function IMGext=InitValue_IMGext(ImgList,NiiList,NiigzList)    
if (length(ImgList)>=1)&&(isempty(NiiList))&&(isempty(NiigzList))
   IMGext='.img';
elseif (length(NiiList)>=1)&&(isempty(ImgList))&&(isempty(NiigzList))
   IMGext='.nii';        
elseif (length(NiigzList)>=1)&&(isempty(ImgList))&&(isempty(NiiList))
   IMGext='.nii.gz'; 
else
   IMGext='mix'; 
end  

function Amount=InitValue_Amount(ImgList,NiiList,NiigzList,FileList)
Amount.Img=length(ImgList);
Amount.Nii=length(NiiList);
Amount.Niigz=length(NiigzList);
Amount.AllFile=length(FileList);