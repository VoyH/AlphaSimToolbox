function asltbx_mutex(tbx_name)
%151108
pasl_path=[fileparts(which('restplus.m')) filesep 'asltbx_pasl' filesep 'scripts_PASL'];
pcasl_path=[fileparts(which('restplus.m')) filesep 'asltbx_pcasl' filesep 'scripts_PCASL'];
asltbx_3dasl_path=[fileparts(which('restplus.m')) filesep 'asltbx_3dasl' filesep 'scripts_3DASL'];

if strcmp(tbx_name,'pasl')
   addpath(pasl_path); 
   rmpath(pcasl_path); 
   rmpath(asltbx_3dasl_path);
   fprintf('\n current batch is for alstbx_pasl, asltbx_pcasl and asltbx_3dasl was removed!\n');
elseif strcmp(tbx_name,'pcasl')
   addpath(pcasl_path);       
   rmpath(pasl_path);
   rmpath(asltbx_3dasl_path);
   fprintf('\n current batch is for alstbx_pcasl, asltbx_pasl and asltbx_3dasl was removed!\n');
elseif strcmp(tbx_name,'3dasl')
   addpath(asltbx_3dasl_path);
   rmpath(pasl_path);
   rmpath(pcasl_path);
   fprintf('\n current batch is for alstbx_3dasl, asltbx_pasl and asltbx_pcasl was removed!\n');
else
    error('asltbx');
end