% Adapted from my fMRI data analysis spm2 batch scripts.
% Created: 4-28-2006
% Batch mode scripts for fMRI data analysis using spm2 
% Created by Ze Wang, 08-05-2004
% zewang@mail.med.upenn.edu
% processing order: float2int realignment, coregistration, smoothing,
% subtraction, outlier cleaning, normalization, GLM, contrast, 2nd analysis
% clear
PAR=[];
global PAR
PAR.SPM_path=spm('Dir');
addpath(PAR.SPM_path);
PAR.batchcode_which= mfilename('fullpath');
PAR.batchcode_which=fileparts(PAR.batchcode_which);
addpath(PAR.batchcode_which);
old_pwd=pwd;
cd(PAR.batchcode_which);
cd ../data
data_root=pwd;
cd(old_pwd);

PAR.root=data_root;

PAR.anatname='3DT1';    % Anatomical directory name
PAR.anatname2='3D_T1';
PAR.groupname={''}; 
if ~exist('groupnum','var') groupnum=1; end
PAR.subjects={ 'A1_SUB02'  'A1_SUB08'  'A1_SUB09'   'A1_SUB11'  'A1_SUB13'  'A1_SUB21'  'A1_SUB23'  'A1_SUB26'  ...
               'A2_SUB04'  'A2_SUB06'  'A2_SUB10'   'A2_SUB14'  'A2_SUB18'  'A2_SUB22'  'A2_SUB27'  'A2_SUB38' ...
               };    % day1 for these subjects is post drug
n1=length(PAR.subjects);

for sb=1:n1
    cd(fullfile(PAR.root, PAR.subjects{sb}));
    pwd
    eval(['!mv day1   posdrug_day1']);
    eval(['!mv day2   predrug_day2']);
end
           
PAR.subjects={           
               'A_GHB'     'A_GW'      'A_HBB'      'A_HYX'     'A_JSW'     'A_LZL'     'A_SL'      'A_TML'    ...
               'A_XGJ'     'A_ZB'      'A_ZXB'   ...
               };
           % day 1 for these subjects is pre drug
n1=length(PAR.subjects);
for sb=1:n1
    cd(fullfile(PAR.root, PAR.subjects{sb}));
    eval(['!mv day1*   predrug_day2']);
    eval(['!mv day2*   posdrug_day1']);
end
PAR.subjects={ 'B1_SUB03'  'B1_SUB12'  'B1_SUB17'   'B1_SUB19'  'B1_SUB20'  'B1_SUB24'  'B1_SUB25'  'B1_SUB29' ...
               'B2_SUB05'  'B2_SUB07'  'B2_SUB15'   'B2_SUB16'  'B2_SUB28'  'B2_SUB30'  'B2_SUB33'  'B2_SUB37' ...
               'B_LYL'     'B_LZZ'     'B_QHY'      'B_TL'      'B_WJB'     'B_XHX'     'B_ZHY' ...
               };
n1=length(PAR.subjects);
for sb=1:n1
    cd(fullfile(PAR.root, PAR.subjects{sb}));
    eval(['!mv day1*   predrug_day1']);
    eval(['!mv day2*   posdrug_day2']);
end
cd(old_pwd);


