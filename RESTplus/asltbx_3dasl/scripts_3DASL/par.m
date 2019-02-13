% Adapted from my fMRI data analysis spm2 batch scripts.
% Created: 4-28-2006
% Batch mode scripts for fMRI data analysis using spm2 
% Created by Ze Wang, 08-05-2004
% zewang@mail.med.upenn.edu
% processing order: float2int realignment, coregistration, smoothing,
% subtraction, outlier cleaning, normalization, GLM, contrast, 2nd analysis
% clear
PAR=[];
global PAR asl3D_P
PAR.SPM_path=spm('Dir');
addpath(PAR.SPM_path);
PAR.batchcode_which= mfilename('fullpath');
PAR.batchcode_which=fileparts(PAR.batchcode_which);
addpath(PAR.batchcode_which);
old_pwd=pwd;
cd(PAR.batchcode_which);
% cd ../data
% data_root=pwd;
% cd(old_pwd);
cd(asl3D_P.root);
% PAR.root=data_root; %by jiaxize 160109
PAR.root=asl3D_P.root;

PAR.anatname='STRUC';          % structural directory name
PAR.structprefs = 'T1';     % structural image name

PAR.groupname={''}; 
if ~exist('groupnum','var') groupnum=1; end
% PAR.subjects={ 'sub01' 'sub02' 'sub03' 'sub04' 'sub05'}; % by jiaxize
% 160109

PAR.subjects=dir_NameList(asl3D_P.root);

PAR.sess= {''};  % each subject has two scan sessions, this can be scan 1 or scan 2 or day1 or day2 etc

PAR.perffoldfilters={'FUNC'};     % perf difference map and M0 folder name
PAR.perfimgfilters={'PerfM0'};   % perfusion difference image and M0 image name. The 1 is the perfusion difference, the 2nd is the M0 map
PAR.cbfimgfilters={'CBF'};    % CBF map name

% PAR.aslcbffolders={'CerebralBloodFlow'};

nsubs = length(PAR.subjects);
PAR.nsubs=nsubs;
for i=1:PAR.nsubs
    PAR.subs(i).nsess=length(PAR.sess);
    for t=1:PAR.subs(i).nsess
        if isempty(PAR.sess{t}) 
            PAR.subs(i).ses(t).name=PAR.sess{t};
            PAR.subs(i).ses(t).path=fullfile(PAR.root, PAR.subjects{i});
        else
            sfolders = dir(fullfile(PAR.root,PAR.subjects{i}, [PAR.sess{t} '*']));
            PAR.subs(i).ses(t).name=char(sfolders(1).name);

            PAR.subs(i).ses(t).path=fullfile(PAR.root, PAR.subjects{i}, PAR.subs(i).ses(t).name);
        end
        anatmp=dir(fullfile(PAR.subs(i).ses(t).path,['*' PAR.anatname '*']));
        PAR.subs(i).ses(t).nt1=size(anatmp,1);

        for j=1:size(anatmp,1)
            PAR.subs(i).ses(t).structdir{j}=fullfile(PAR.subs(i).ses(t).path, spm_str_manip(char(anatmp(j).name),'d'));
        end
        % get ASL perfusion image and CBF image folders
        functmp=dir(fullfile(PAR.subs(i).ses(t).path,['*' PAR.perffoldfilters{1} '*']));

        PAR.subs(i).ses(t).nasl=length(PAR.perffoldfilters);
        for j=1:PAR.subs(i).ses(t).nasl
            functmp=dir(fullfile(PAR.subs(i).ses(t).path,['*' PAR.perffoldfilters{j} '*']));
           PAR.subs(i).ses(t).perffolders{j}=fullfile(PAR.subs(i).ses(t).path, spm_str_manip(char(functmp(1).name),'d'));
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
PAR.outputprefix='';




