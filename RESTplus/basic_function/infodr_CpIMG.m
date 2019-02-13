function CpList=infodr_CpIMG(InFodr,OutFodr,Option,Parameter)
%Parameter.Prefix
%Parameter.IMGext
%Parameter.SubfodrNam
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

if nargin<=3
    Parameter='';
end
inpath_Misc(OutFodr,'MakeCurrentDir');
switch Option
    case 'Prefix'
        CpList=CpIMG_Prefix(InFodr,OutFodr,Parameter);
    case 'All'
        CpList=CpIMG_All(InFodr,OutFodr);
end








function FileList=CpIMG_Prefix(InFodr,OutFodr,Parameter)
if ~isfield(Parameter,'IMGext');
    Parameter.IMGext=infodr_IMGinfo(InFodr,'IMGext',Parameter);     
end

FileList=dir_4RegExp(InFodr,[Parameter.Prefix '*' Parameter.IMGext]);

if isempty(FileList)
    fprintf('\n%s in %s not exsit\n',[Parameter.Prefix '*' Parameter.IMGext],InFodr);
end

if strcmp(Parameter.IMGext,'.img')
   copyfile([InFodr filesep Parameter.Prefix '*.img'],OutFodr);
   copyfile([InFodr filesep Parameter.Prefix '*.hdr'],OutFodr);   
else
   copyfile([InFodr filesep Parameter.Prefix '*' Parameter.IMGext],OutFodr);           
end

function CpList=CpIMG_All(InFodr,OutFodr)
IMG_liststruct=dir_IMG(InFodr);
CpList='';
j=1;
for i=1:length(IMG_liststruct.img)
    copyfile([InFodr filesep IMG_liststruct.img{i}],[OutFodr filesep IMG_liststruct.img{i}]);
    CpList{j}=IMG_liststruct.img{i};
    j=j+1;
end

for i=1:length(IMG_liststruct.hdr)
    copyfile([InFodr filesep IMG_liststruct.hdr{i}],[OutFodr filesep IMG_liststruct.hdr{i}]);
    CpList{j}=IMG_liststruct.hdr{i};
    j=j+1;
end

for i=1:length(IMG_liststruct.nii)
    copyfile([InFodr filesep IMG_liststruct.nii{i}],[OutFodr filesep IMG_liststruct.nii{i}]);
    CpList{j}=IMG_liststruct.nii{i};
    j=j+1;
end

for i=1:length(IMG_liststruct.niigz)
    copyfile([InFodr filesep IMG_liststruct.niigz{i}],[OutFodr filesep IMG_liststruct.niigz{i}]);
    CpList{j}=IMG_liststruct.niigz{i};
    j=j+1;
end





