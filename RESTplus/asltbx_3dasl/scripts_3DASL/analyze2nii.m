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

PAR.anatname='Anatomy';    % Anatomical directory name
PAR.groupname={''}; 
if ~exist('groupnum','var') groupnum=1; end
PAR.subjects={ 'sub01' 'sub02' 'sub03' 'sub04' 'sub05' 'sub06'};
PAR.sess= {'rest' 'task'};
PAR.confilters={'2015'};
PAR.perffoldfilters={'ASL'};
PAR.aslcbffilters={'2015'};
PAR.cbffoldfilters={'CBF'};
PAR.structprefs = '2015';
% PAR.confilters={'CerebralBloodFlow1'  'CerebralBloodFlow2'};
nsubs = length(PAR.subjects);
PAR.nsubs=nsubs;
for i=1:PAR.nsubs
    
    PAR.subs(i).nsess=2;
    for t=1:PAR.subs(i).nsess
        % get the session name
        sfolders = dir(fullfile(PAR.root,PAR.subjects{i}, [PAR.sess{t} '*']));
      PAR.subs(i).ses(t).name=char(sfolders(1).name);
      
      PAR.subs(i).ses(t).path=fullfile(PAR.root, PAR.subjects{i}, PAR.subs(i).ses(t).name);
      anatmp=dir(fullfile(PAR.subs(i).ses(t).path,['*' PAR.anatname '*']));
      PAR.subs(i).ses(t).nt1=size(anatmp,1);
      
      for j=1:size(anatmp,1)
        PAR.subs(i).ses(t).structdir{j}=fullfile(PAR.subs(i).ses(t).path, spm_str_manip(char(anatmp(j).name),'d'));
        P=spm_select('FPList', PAR.subs(i).ses(t).structdir{j}, ['^' PAR.structprefs '.*.img']);
        nP=fullfile(PAR.subs(i).ses(t).structdir{j}, 't1struc.nii');
        spm_file_merge(P, nP);
      end
      % get the function data folders (here it's ASL)
      functmp=dir(fullfile(PAR.subs(i).ses(t).path,['*' PAR.perffoldfilters{1} '*']));
      functmp2=dir(fullfile(PAR.subs(i).ses(t).path,['*' PAR.cbffoldfilters{1} '*']));
      PAR.subs(i).ses(t).nasl=size(functmp,1);
      for j=1:size(functmp,1)
        PAR.subs(i).ses(t).perffolders{j}=fullfile(PAR.subs(i).ses(t).path, spm_str_manip(char(functmp(j).name),'d'));
        P=spm_select('FPList', PAR.subs(i).ses(t).perffolders{j}, ['^' PAR.confilters{1} '.*.img']);
        nP=fullfile(PAR.subs(i).ses(t).perffolders{j}, 'PerfM0.nii');
        spm_file_merge(P, nP);
        PAR.subs(i).ses(t).cbffolders{j}=fullfile(PAR.subs(i).ses(t).path, spm_str_manip(char(functmp2(j).name),'d'));
        P=spm_select('FPList', PAR.subs(i).ses(t).cbffolders{j}, ['^' PAR.aslcbffilters{1} '.*.img']);
        nP=fullfile(PAR.subs(i).ses(t).cbffolders{j}, 'CBFmap.nii');
        spm_file_merge(P, nP);
      end
    end
end

%prefixes for structural 3D image, supposed to be the same for every subj.

PAR.localtemplate = 'template';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Smoothing for normalized images
PAR.FWHM = [6 6 6];
PAR.dartel.bb=[NaN NaN NaN
    NaN NaN NaN  ];
PAR.dartel.vx=[2 2 2];
PAR.dartel.vxxx=2;
PAR.STATSDIR='STATS';
PAR.ASLGROUPDIR='CBFres';
PAR.T1GROUPDIR='T1STATS';
PAR.orgT1GROUPDIR='orgT1STATS';



