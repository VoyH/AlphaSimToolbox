function indir_Realign(InDir_FunImg,OutDir_FunImg,OutDir_RealignParameter,If_Check_motion)
% InDir_FunImg='FunImgA';
% OutDir_FunImg='FunImgAR';
% OutDir_RealignParameter='RealignParameter';
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201502
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


if nargin<=3
    If_Check_motion=1;
end
    
[ImgType,ImgExt]=indir_Chek(InDir_FunImg);
SubfodrList=dir_NameList(InDir_FunImg);

SpmBatch='';
for i=1:length(SubfodrList)
        SpmBatch{i}.jobs = init_SpmBatch('Realign');
        Parameter.FileList=spread_Fodr4SPM([InDir_FunImg filesep SubfodrList{i}],ImgType);
        SpmBatch{i}.jobs = init_SpmBatch('Realign');
        SpmBatch{i} = output_SpmBatch4Realign(SpmBatch{i},Parameter);  
        Parameter.FileList='';
end

batch_run_spm_jobman(SubfodrList,SpmBatch);


sort_RealignResult(InDir_FunImg,OutDir_FunImg,OutDir_RealignParameter);

if 1==If_Check_motion
    chek_HeadMotion(InDir_FunImg,OutDir_RealignParameter);
    calculate_FD(SubfodrList,OutDir_RealignParameter);
end



function SpmBatch = output_SpmBatch4Realign(SpmBatch,Parameter)
SpmBatch.jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.data{1,1} = Parameter.FileList;
SpmBatch.jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.roptions.prefix = get_Postfix('Realign');


function sort_RealignResult(InDir_FunImg,OutDir_FunImg,OutDir_RealignParameter)
move_RealignParameterFile(InDir_FunImg,OutDir_RealignParameter);
move_InDir2OutDir(InDir_FunImg,OutDir_FunImg,'RegularExpression',[get_Postfix('Realign') '*']);


function move_RealignParameterFile(InDir_FunImg,OutDir_RealignParameter)
move_InDir2OutDir(InDir_FunImg,OutDir_RealignParameter,'RegularExpression','mean*');
move_InDir2OutDir(InDir_FunImg,OutDir_RealignParameter,'RegularExpression','rp*');
move_InDir2OutDir(InDir_FunImg,OutDir_RealignParameter,'RegularExpression','*.ps');


function chek_HeadMotion(InDir_FunImg,OutDir_RealignParameter)
SubfodrList=dir_NameList(InDir_FunImg);
SubHeadMotionMtrx=save_HeadMotionMat(SubfodrList,OutDir_RealignParameter);
save_ExcludeSubTex(SubHeadMotionMtrx,SubfodrList,OutDir_RealignParameter);


       
function SubHeadMotionMtrx=save_HeadMotionMat(SubfodrList,OutDir_RealignParameter)
SubHeadMotionMtrx=[];
for i=1:length(SubfodrList)
    SubjPath_RealignParameter=[OutDir_RealignParameter filesep SubfodrList{i}];
    [HeadMotionMtrxIn,rpfilepath]=load_rpfile(SubjPath_RealignParameter);   
    Max_HeadMotion=max(abs(HeadMotionMtrxIn));
    Max_HeadMotion(4:6)=Max_HeadMotion(4:6)*180/pi;
    SubHeadMotionMtrx=[SubHeadMotionMtrx;Max_HeadMotion];
end
save([OutDir_RealignParameter filesep 'HeadMotion.mat'],'SubHeadMotionMtrx');


function save_ExcludeSubTex(SubHeadMotionMtrx,SubfodrList,OutDir_RealignParameter)
ExcludeSub_Text=[];
     for ExcludingCriteria=3:-0.5:0.5
         ExcludeSubList=get_HeadMotionSubject(SubHeadMotionMtrx,SubfodrList,ExcludingCriteria);        
         ExcludeSub_Text=sprintf('%s\nExcluding Criteria: %2.1fmm and %2.1f degree\n%s\n\n\n', ...
                                 ExcludeSub_Text,ExcludingCriteria,ExcludingCriteria,ExcludeSubList);
    end
    fid = fopen([OutDir_RealignParameter filesep 'ExcludeSubjects.txt'],'at+');
    fprintf(fid,'%s',ExcludeSub_Text);
    fclose(fid);
    
    
function ExcludeSubList=get_HeadMotionSubject(SubHeadMotionMtrx,SubfodrList,ExcludingCriteria)
         ExcludeMtrxIndex=find(SubHeadMotionMtrx>ExcludingCriteria);
        if ~isempty(ExcludeMtrxIndex)
            [II JJ]=ind2sub([length(SubfodrList),6],ExcludeMtrxIndex);
            ExcludeSubIndex=unique(II);
            ExcludeSubInCell=SubfodrList(ExcludeSubIndex);
            ExcludeSubList='';
            for iExcludeSub=1:length(ExcludeSubInCell)
                ExcludeSubList=sprintf('%s%s\n',ExcludeSubList,ExcludeSubInCell{iExcludeSub});
            end
        else
            ExcludeSubList='None';
        end
        
        
function calculate_FD(SubfodrList,OutDir_RealignParameter)


for i=1:length(SubfodrList)
    SubjPath_RealignParameter=[OutDir_RealignParameter filesep SubfodrList{i}];
    [HeadMotionMtrxIn,rpfilepath]=load_rpfile(SubjPath_RealignParameter); 
    calc_FD_Van_Dijk(HeadMotionMtrxIn,SubjPath_RealignParameter,SubfodrList{i});
    calc_FD_Power(HeadMotionMtrxIn,SubjPath_RealignParameter,SubfodrList{i});
    calc_FD_Jenkinson(rpfilepath,SubjPath_RealignParameter,SubfodrList{i});
end



function [HeadMotionMtrxIn,rpfilepath]=load_rpfile(SubjPath_RealignParameter)
 rpfilepath=get_rpfilepath(SubjPath_RealignParameter);
 HeadMotionMtrxIn=load(rpfilepath); 

 
function rpfilepath=get_rpfilepath(SubjPath_RealignParameter)
 rpfilepathlist=dir_4RegExp(SubjPath_RealignParameter,'rp*');
 if length(rpfilepathlist)>1
     warning('more than 1 rp* file');
 end
 rpfilepath=[SubjPath_RealignParameter filesep rpfilepathlist{1}];
 
function calc_FD_Van_Dijk(HeadMotionMtrxIn,SubjPath_RealignParameter,SubfodrNam)
% Calculate FD Van Dijk 
% Van Dijk, K.R., Sabuncu, M.R., Buckner, R.L., 
% 2012. 
% The influence of head motion on intrinsic functional connectivity MRI. 
% Neuroimage 59, 431-438.        
RPRMS = sqrt(sum(HeadMotionMtrxIn(:,1:3).^2,2));
FD_VanDijk = abs(diff(RPRMS));
FD_VanDijk = [0;FD_VanDijk];
save([SubjPath_RealignParameter filesep 'FD_VanDijk_' SubfodrNam '.txt'], 'FD_VanDijk', '-ASCII', '-DOUBLE','-TABS');


function calc_FD_Power(HeadMotionMtrxIn,SubjPath_RealignParameter,SubfodrNam)
% Calculate FD Power 
% Power, J.D., Barnes, K.A., Snyder, A.Z., Schlaggar, B.L., Petersen, S.E., 
% 2012. 
% Spurious but systematic correlations in functional connectivity MRI networks arise from subject motion. 
% Neuroimage 59, 2142-2154.)
RPDiff=diff(HeadMotionMtrxIn);
RPDiff=[zeros(1,6);RPDiff];
RPDiffSphere=RPDiff;
RPDiffSphere(:,4:6)=RPDiffSphere(:,4:6)*50;
FD_Power=sum(abs(RPDiffSphere),2);
save([SubjPath_RealignParameter filesep 'FD_Power_' SubfodrNam '.txt'], 'FD_Power', '-ASCII', '-DOUBLE','-TABS');


function calc_FD_Jenkinson(rpfilepath,SubjPath_RealignParameter,SubfodrNam)
MeanFilePath=get_MeanImgPath(SubjPath_RealignParameter);
[FD_Jenkinson abs_rms]= rp_y_FD_Jenkinson(rpfilepath,MeanFilePath);
save([SubjPath_RealignParameter filesep 'FD_Jenkinson_' SubfodrNam '.txt'], 'FD_Jenkinson', '-ASCII', '-DOUBLE','-TABS');


function [rel_rms, abs_rms] = rp_y_FD_Jenkinson(RealignmentParameterFile,ReferenceImage)
% function [rel_rms, abs_rms] = y_FD_Jenkinson(RealignmentParameterFile,ReferenceImage)
% Calculate FD Jenkinson (relative RMS) and absolute RMS based on SPM's realignment parameters
% Reference: Jenkinson, M., Bannister, P., Brady, M., Smith, S., 2002. Improved optimization for the robust and accurate linear registration and motion correction of brain images. Neuroimage 17, 825-841.
%            Jenkinson, M. 1999. Measuring transformation error by RMS deviation. Internal Technical Report TR99MJ1, FMRIB Centre, University of Oxford. Available at www.fmrib.ox.ac.uk/analysis/techrep for downloading.
% Input:
% 	RealignmentParameterFile  -   The realignment parameter file for a given participant generated by SPM. E.g., rp***.txt
%   ReferenceImage            -   The reference image for realignment (usually the first time point (one-pass) or the mean image after an initial motion correction (two-pass))
% Output:
%	rel_rms      -   relative RMS (FD Jenkinson)
%	abs_rms      -   absolute RMS
%-----------------------------------------------------------
% Written by YAN Chao-Gan 120930.
% The Nathan Kline Institute for Psychiatric Research, 140 Old Orangeburg Road, Orangeburg, NY 10962, USA
% Child Mind Institute, 445 Park Avenue, New York, NY 10022, USA
% The Phyllis Green and Randolph Cowen Institute for Pediatric Neuroscience, New York University Child Study Center, New York, NY 10016, USA
% ycg.yan@gmail.com


rmax = 80.0; %The default radius (as in FSL) of a sphere represents the brain

RP=load(RealignmentParameterFile);
nTimePoint=size(RP,1);
sinq1=sin(RP(:,4));
sinq2=sin(RP(:,5));
sinq3=sin(RP(:,6));
cosq1=cos(RP(:,4));
cosq2=cos(RP(:,5));
cosq3=cos(RP(:,6));

[RefData,VoxDim,RefHead]=rp_readfile(ReferenceImage);

center = RefHead.mat*([0.5*(RefHead.dim(1));0.5*(RefHead.dim(2));0.5*(RefHead.dim(3));1]);
center = center(1:3); %Get the coordinate for the center

abs_rms = zeros(nTimePoint,1);
for t=1:nTimePoint

    M1=[1       0        0     0;...
        0    cosq1(t)  sinq1(t)  0;...
        0    -sinq1(t) cosq1(t)  0;...
        0       0        0     1;];
    
    M2=[cosq2(t)  0    sinq2(t)     0;...
        0        1       0        0;...
        -sinq2(t) 0    cosq2(t)     0;...
        0       0        0        1;];
    
    M3=[cosq3(t)   sinq3(t)   0     0;...
        -sinq3(t)  cosq3(t)   0     0;...
        0           0       1     0;...
        0           0       0     1;];
    
    MT=[1    0     0     RP(t,1);...
        0    1     0     RP(t,2);...
        0    0     1     RP(t,3);...
        0    0     0     1;];
    
    M_RigidBodyTransform=MT*M1*M2*M3;
    
    MA1=eye(4);
    MA2=(M_RigidBodyTransform);
    
    M = MA1*inv(MA2) - eye(4);
    
    A = M(1:3,1:3);
    
    T = M(1:3,4);
    
    abs_rms(t) = sqrt(rmax*rmax/5*trace(A'*A) + (T+A*center)'*(T+A*center));
end


rel_rms = zeros(nTimePoint-1,1);
for t=2:nTimePoint
    M1=[1       0        0     0;...
        0    cosq1(t)  sinq1(t)  0;...
        0    -sinq1(t) cosq1(t)  0;...
        0       0        0     1;];
    
    M2=[cosq2(t)  0    sinq2(t)     0;...
        0        1       0        0;...
        -sinq2(t) 0    cosq2(t)     0;...
        0       0        0        1;];
    
    M3=[cosq3(t)   sinq3(t)   0     0;...
        -sinq3(t)  cosq3(t)   0     0;...
        0           0       1     0;...
        0           0       0     1;];
    
    MT=[1    0     0     RP(t,1);...
        0    1     0     RP(t,2);...
        0    0     1     RP(t,3);...
        0    0     0     1;];
    
    M_RigidBodyTransform=MT*M1*M2*M3;
    
    
    M1=[1       0        0     0;...
        0    cosq1(t-1)  sinq1(t-1)  0;...
        0    -sinq1(t-1) cosq1(t-1)  0;...
        0       0        0     1;];
    
    M2=[cosq2(t-1)  0    sinq2(t-1)     0;...
        0        1       0        0;...
        -sinq2(t-1) 0    cosq2(t-1)     0;...
        0       0        0        1;];
    
    M3=[cosq3(t-1)   sinq3(t-1)   0     0;...
        -sinq3(t-1)  cosq3(t-1)   0     0;...
        0           0       1     0;...
        0           0       0     1;];
    
    MT=[1    0     0     RP(t-1,1);...
        0    1     0     RP(t-1,2);...
        0    0     1     RP(t-1,3);...
        0    0     0     1;];
    
    M_RigidBodyTransform_1=MT*M1*M2*M3;
    
    MA1=(M_RigidBodyTransform_1);
    MA2=(M_RigidBodyTransform);
    
    M = MA1*inv(MA2) - eye(4);
    
    A = M(1:3,1:3);
    
    T = M(1:3,4);
    
    rel_rms(t-1) = sqrt(rmax*rmax/5*trace(A'*A) + (T+A*center)'*(T+A*center));
    
end

rel_rms=[0;rel_rms]; %The FD_Jenkinson at time point t means the movement from time point t-1 to time point t. (Put the FD_Jenkinson for the first time point to "0".)



