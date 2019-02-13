function IccMatrix=InFodr_ICC(SessionFolderList,OutIccName,MaskFileName)
%SessionFolderList{1}
%SessionFolderList{2}
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


 SessionAmount=length(SessionFolderList);
 [Volume4D_Session,VoxelSize_Session,ImgFileList_Session,Header_Session,SubjectAmount_Session]=init_MultiTo4d(SessionAmount);

%% Volume4dUseMask
for i=1:SessionAmount
    [Volume4D_Session{i}, VoxelSize_Session{i},  ...
    ImgFileList_Session{i}, Header_Session{i},  ...
    SubjectAmount_Session(i)] =  read_To4d(SessionFolderList{i});

    Volume4D_Session{i}      = Volume4dUseMask(Volume4D_Session{i},MaskFileName);                                                                                                                                            
end

[DimX,DimY,DimZ,SubjectAmount]=isequal_Multi4dDim(Volume4D_Session);

%% Init OperationMatrix
Matrix5D=zeros(DimX,DimY,DimZ,SubjectAmount,SessionAmount);
Matrix3D=zeros(DimX,DimY,DimZ);
OperationMatrix=zeros(DimX*DimY*DimZ,SubjectAmount,SessionAmount);

for i=1:length(SessionFolderList)
        Matrix5D(:,:,:,:,i)=Volume4D_Session{i};
        for j=1:SubjectAmount_Session(i)
            Matrix3D(:,:,:)=Matrix5D(:,:,:,j,i);
            OperationMatrix(:,j,i)=reshape(Matrix3D,[DimX*DimY*DimZ,1]);
        end
end

%% CalcIcc
Icc1DMatrix=CalcIcc(OperationMatrix,SubjectAmount,SessionAmount);
IccMatrix=reshape(Icc1DMatrix,[DimX,DimY,DimZ]);
IccMatrix=Volume3dUseMask(IccMatrix,MaskFileName);

write_To3dNifti(IccMatrix,OutIccName,[DimX,DimY,DimZ],VoxelSize_Session{1},Header_Session{1},'single');


function Volume4dAfterMask = Volume4dUseMask(Volume4D,MaskFileName)
[DimX,DimY,DimZ,DimN]=size(Volume4D);
Mask3D=load_Mask(DimX,DimY,DimZ,MaskFileName);
Mask4D=repmat(Mask3D,[1,1,1,DimN]);
Volume4dAfterMask=Volume4D.*logical(Mask4D);

function Volume3dAfterMask = Volume3dUseMask(Volume3D,MaskFileName)
[DimX,DimY,DimZ]=size(Volume3D);
Mask3D=load_Mask(DimX,DimY,DimZ,MaskFileName);
Volume3dAfterMask=Volume3D.*logical(Mask3D);

function Icc1DMatrix=CalcIcc(OperationMatrix,SubjectAmount,SessionAmount)
%OperationMatrix=zeros(DimX*DimY*DimZ,SubjectAmount,SessionAmount)

%mean per target
mpt=mean(OperationMatrix,3);

%mean per rater/rating
mpr=mean(OperationMatrix,2);

%get total mean
tm=sum(sum(OperationMatrix,3),2)/(SubjectAmount*SessionAmount);

%within target sum sqrs
tmp=(OperationMatrix-repmat(mpt,[1,1,SessionAmount])).^2;
WSS=sum(sum(tmp,3),2);
WSS=squeeze(WSS);

%within target mean sqrs
WMS=WSS/(SubjectAmount*(SessionAmount-1));

%between target sum sqrs
BSS=sum((mpt-repmat(tm,[1,SubjectAmount])).^2,2)*SessionAmount;

%between targets mean squares
BMS=BSS/(SubjectAmount-1);

Icc1DMatrix=(BMS-WMS)./(BMS+(SessionAmount-1)*WMS);













