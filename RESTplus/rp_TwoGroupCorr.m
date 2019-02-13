function rp_TwoGroupCorr(Group1Dir,Group2Dir,flag,outdir,maskfile)
% FORMAT rp_TwoGroupCorr(Group1Dir,Group2Dir)
%   Input:
%     Group1Dir - directory of the first group
%     Group2Dir - directory of the the second group
%     flag - identify 'temporal' of 'spatial'
%     outdir - directory of output
%   Output for spatial:
%     rGroup.img - image with Pearson's Correlation Coefficient
%     pGroup.img - image with significance of Pearson's Correlation Coefficient
%   Output for temporal:
%      RandP.txt - r and p value for every point
%__________________________________________________________________________
% Written by YAN Chao-Gan 090302.
% State Key Laboratory of Cognitive Neuroscience and Learning, Beijing Normal University, China, 100875
% ycg.yan@gmail.com
%__________________________________________________________________________
%   Revised by Dong Zhang-Ye, 100530. Add the function to calculate spatial correlation of two single image.
%   Revised by Jia Xi-Ze 160101, support MASK
%   Revised by Jia Xi-Ze 160110, have to select a mask for spatial  correlation

if nargin <= 4
   maskfile='';
end

if strcmp(flag,'temporal')
    temcorr(Group1Dir,Group2Dir,outdir,maskfile);
else
    if isempty(maskfile) % add by Jia Xi-Ze 160110
       uiwait(msgbox('You need select a mask file for spatial correlation!'));
       [filename,pathname]=uigetfile({'*.nii;*.img'},'Select a maskfile for spatial correlation');
       if 0~=filename
           maskfile=[pathname filename];
       else
           error('you have to select a mask for spatial correlation');
       end
    end
    spcorr(Group1Dir,Group2Dir,outdir,maskfile);
end

function spcorr(Group1Dir,Group2Dir,outdir,maskfile)
olddir=pwd;
if ~isempty(maskfile)
    [MaskData, Mask_VoxelSize, Mask_Header]=rp_readfile(maskfile);
end

if isdir(Group1Dir)&&isdir(Group2Dir)
    [Group1Series, VoxelSize, ImgFileList, Header,nVolumn] =rp_to4d(Group1Dir);
    [Group2ConSeries, VoxelSize, ImgFileList, Header,nVolumn] =rp_to4d(Group2Dir);
else
    [Group1Series, VoxelSize, Header] =rp_readfile(Group1Dir); %dong 100530
    [Group2ConSeries, VoxelSize, Header] =rp_readfile(Group2Dir);
    ImgFileList=1;
    nVolumn=1; %YAN Chao-Gan, 130423
end

cd(olddir);
rGroup=zeros(size(Group1Series,1),size(Group1Series,2),size(Group1Series,3));
pGroup=zeros(size(Group1Series,1),size(Group1Series,2),size(Group1Series,3));
rp_waitbar;
%for i=1:nVolumn
            %[r p]=corrcoef(squeeze(Group1Series(i,:,:,:)),squeeze(Group2ConSeries(i,:,:,:)));
Maskind=find(MaskData);            
for i=1:nVolumn
    rp_waitbar(i/size(Group1Series,1),'Computing','Computing','Parent');
    
            corr_data1=squeeze(Group1Series(:,:,:,i)); %160101 Jia Xi-Ze
            corr_data2=squeeze(Group2ConSeries(:,:,:,i)); %160101 Jia Xi-Ze
%             [r p]=corrcoef(squeeze(Group1Series(:,:,:,i)),squeeze(Group2ConSeries(:,:,:,i)));
           [r p]=corrcoef(squeeze(corr_data1(Maskind)),squeeze(corr_data2(Maskind)));
            rGroup(i)=r(1,2);
            pGroup(i)=p(1,2);
end
rGroup(isnan(rGroup))=0;
pGroup(isnan(pGroup))=1;
fid=fopen([outdir,filesep,'R_P.txt'],'w');
if(fid>0)   
     fprintf(fid,'ID\tR\t\tP\n');
     for i=1:size(ImgFileList,1)
         fprintf(fid,'%d\t%f\t%f\n',i,rGroup(i),pGroup(i));
     end
end
 fclose(fid); %160101 Jia Xi-Ze





function temcorr(Group1Dir,Group2Dir,outdir,maskfile)
olddir=pwd;


[Group1Series, VoxelSize, ImgFileList, Header,nVolumn] =rp_to4d(Group1Dir);
[Group2ConSeries, VoxelSize, ImgFileList, Header,nVolumn] =rp_to4d(Group2Dir);

cd(olddir);
rGroup=zeros(size(Group1Series,1),size(Group1Series,2),size(Group1Series,3));
pGroup=zeros(size(Group1Series,1),size(Group1Series,2),size(Group1Series,3));
rp_waitbar;
%for i=1:nVolumn
            %[r p]=corrcoef(squeeze(Group1Series(i,:,:,:)),squeeze(Group2ConSeries(i,:,:,:)));
for i=1:size(Group1Series,1) %YAN Chao-Gan, 20130423. ZHANG Han found this bug.
    rp_waitbar(i/size(Group1Series,1),'Computing','Computing','Parent');
    for j=1:size(Group1Series,2)
        for k=1:size(Group1Series,3)
            [r p]=corrcoef(squeeze(Group1Series(i,j,k,:)),squeeze(Group2ConSeries(i,j,k,:)));
            rGroup(i,j,k)=r(1,2);
            pGroup(i,j,k)=p(1,2);
        end
    end
end
rGroup(isnan(rGroup))=0;
pGroup(isnan(pGroup))=1;

if ~isempty(maskfile)
    [MaskData, Mask_VoxelSize, Mask_Header]=rp_readfile(maskfile);
    rGroup=rGroup.*MaskData;
    pGroup=rGroup.*MaskData;
end


rp_WriteNiftiImage(rGroup,Header,[outdir,filesep,'rGroup.img']);
rp_WriteNiftiImage(pGroup,Header,[outdir,filesep,'pGroup.img']);
