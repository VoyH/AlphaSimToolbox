function infodr_PerAF(AllVolume,outfile_PerAF,infilepath_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


rp_PerAF(AllVolume,outfile_PerAF,infilepath_Mask,0,0);
end



function rp_PerAF(InFodr,AResultFilename,AMaskFilename,Ifmean,Ifzscore)
%___________________________________________________________________________
%	Written by Xi-ze Jia
% 	Mail to Authors:  <a href="willbbetter@gmail.com">Xi-ze Jia</a>;
%	Release=20140509;
%   Version 1.0
%   Revised by Xi-ze Jia 2014
if nargin<=4
    Ifzscore=0;
    if nargin<=3
        Ifmean=0;
          if nargin<=2
              AMaskFilename=0;
          end
    end
end

    
    [AllVolume, VoxelSize, ImgFileList, Header, nVolumn]=rp_to4d(InFodr);             
    PSC_Brain4D=Data4d_PSC(AllVolume);
    PSC_Brain4D=abs(PSC_Brain4D);
    PSC_Brain=mean_4dTo3d(PSC_Brain4D);  
    if AMaskFilename~=0
       MaskData=rp_loadmask(size(AllVolume,1),size(AllVolume,2),size(AllVolume,3),AMaskFilename);                       
       PSC_Brain=PSC_Brain.*MaskData;              
    end
    rp_writefile(PSC_Brain,AResultFilename,Header.dim,VoxelSize,Header,'single');
    
    if (1==Ifmean)&&(~isempty(AMaskFilename))
        [pathstr, name, ext]=fileparts(AResultFilename);
        AmResultFilename=[pathstr filesep 'm' name ext];
        rp_DivideMeanWithinMask(AResultFilename, AmResultFilename, AMaskFilename);
    end
    
    if (1==Ifzscore)&&(~isempty(AMaskFilename))
        [pathstr, name, ext]=fileparts(AResultFilename);
        AzResultFilename=[pathstr filesep 'z' name ext];
        calc_ZscoreFor3dBrain(AResultFilename,AzResultFilename,AMaskFilename)
    end
end

function [PSC_Brain4D]=Data4d_PSC(AllVolume)

    AllVolume_2D=reshape(AllVolume,[],size(AllVolume,4));%each row=the position of voxel in each volumn?each column=time points
    InData_meantp=mean(AllVolume_2D,2);%average all the timepoint in one voxel 
    InData_meantp=repmat(InData_meantp,1,size(AllVolume,4));%make the demention same as InData_2D for minus
    PSC_Brain4D = (AllVolume_2D-InData_meantp)./InData_meantp; % Caculate the Signal change rate.
    PSC_Brain4D = reshape(PSC_Brain4D,size(AllVolume,1),size(AllVolume,2),size(AllVolume,3),size(AllVolume,4));
end


function[SubMatrix_3D]= mean_4dTo3d(AllVolume)

 
     [dim1,dim2,dim3,dim4]=size(AllVolume);   
     SubMatrix_2D = reshape(AllVolume,dim1*dim2*dim3,dim4);
     Matrix_meantp=mean(SubMatrix_2D,2);
     SubMatrix_3D=reshape(Matrix_meantp,dim1,dim2,dim3);
end
     

function calc_ZscoreFor3dBrain(InFile,OutFile,InMsk)

[AllVolume,VoxDim,Header]=rp_readfile(InFile);
BrainMaskData=rp_loadmask(Header.dim(1),Header.dim(2),Header.dim(3), InMsk);
ZscoreAllVolume=((AllVolume - mean(AllVolume(find(BrainMaskData)))) ./ std(AllVolume(find(BrainMaskData)))) .* (BrainMaskData~=0);
rp_writefile(ZscoreAllVolume,OutFile,Header.dim,VoxDim,Header,'single');
end