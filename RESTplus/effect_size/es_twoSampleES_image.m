function [Es] = es_twoSampleES_image(DependentDirs, OutputName, MaskFile)
% function [Es] = effect_size(DependentDirs, OutputName, MaskFile)
% Compute the effect size for Two sample t-test.
% Input:
%   DependentDirs: the directory of the data;
%   OutputDirs: the directory to stroe the result;
%   MaskFile: the path of mask file.
% Output:
%   Es: the matrix of effect size;
%___________________________________________________________________________
% By Gao Zhong-Zhan and Li Xun, 20140814.
%  gaozhongzhan@126.com, lixun2011@126.com
theElapsedTime =cputime;

fprintf('\nComputing effect size...');

if nargin<=2
    MaskFile=[];
end

%151118 Jia Xi-Ze remove this part to GUI code
% [a,b,c]=fileparts(OutputName);
% b = strcat('estbx_TwoSample_EffectSize',b);

[Situation1Volume,VoxelSize,theImgFileList, Header,nVolumn] =rp_to4d(DependentDirs{1});
fprintf('\n\tImage Files in Condition 1:\n');
for itheImgFileList=1:length(theImgFileList)
    NSituation1 = length(theImgFileList);
    fprintf('\t%s\n',theImgFileList{itheImgFileList});
end
[Situation2Volume,VoxelSize,theImgFileList, Header,nVolumn] =rp_to4d(DependentDirs{2});
fprintf('\n\tImage Files in Condition 2:\n');
for itheImgFileList=1:length(theImgFileList)
    NSituation2 = length(theImgFileList);
    fprintf('\t%s\n',theImgFileList{itheImgFileList});
end

[nDim1,nDim2,nDim3,nDimTimePoints]=size(Situation1Volume);

Df_E=NSituation1 + NSituation2-1;
BrainSize = [nDim1 nDim2 nDim3];

if ~isempty(MaskFile)
    [MaskData,MaskVox,MaskHead]=rp_readfile(MaskFile);
else
    MaskData=ones(nDim1,nDim2,nDim3);
end

rp_waitbar;
Es=zeros(nDim1,nDim2,nDim3);
fprintf('\nEs Calculating...\n');


MeanVarSituation1 = mean(Situation1Volume,4);
MeanVarSituation2 = mean(Situation2Volume,4);
StdVarSituation1=std(Situation1Volume,0,4);
StdVarSituation2=std(Situation2Volume,0,4);
Std_all = sqrt(((NSituation1-1)*(StdVarSituation1.^2)+(NSituation2-1)*(StdVarSituation2.^2))/(NSituation1+NSituation2));

Es = (MeanVarSituation1-MeanVarSituation2)./Std_all;

Es(~isfinite(Es))=0;
Es=Es.*MaskData;

% Header.descrip=sprintf('ES{T_[%.1f,%.1f]}',NSituation1,NSituation2);
% 160113 jiaxize

% rp_writefile(Es,[a,filesep,b,c],[nDim1,nDim2,nDim3],VoxelSize, Header,'double');
rp_writefile(Es,OutputName,[nDim1,nDim2,nDim3],VoxelSize, Header,'double');

% es_WriteNiftiImage(TTestPaired_T,Header,OutputName);
% Es_Large=Es;
% Es_Large(find(abs(Es)<0.8))=0;
% es_writefile(Es_Large,[a,filesep,'Large_',b,c],[nDim1,nDim2,nDim3],VoxelSize, Header,'double');
rp_waitbar;
fprintf('\n\tES Calculation finished.\n');



