% batch_norm_generaltemplate2MNI
% normalizing dartel template to MNI
% Get subject etc parameters
par
global PAR

% global defaults;
% spm_defaults;
defaults=spm_get_defaults;  %this is new in spm8
defs = defaults.normalise;
defs.normalise.estimate.reg=Inf;   % affine transform
defs.normalise.estimate.cutoff=Inf; % affine registration only
defs.normalise.estimate.nits=0;

% Turn off template weighting  --> it's turned off by default!
%defs.estimate.weight = '';
%structural images have better resolution. Let's put them to 1x1x1 (instead
%of 2x2x2
%defs.write.vox= [1 1 1];
defs.write.vox= [2 2 2];
% defs.write.bb=[-90 -126 -72
%                 90    90  108];
defs.write.bb=[-80  -112   -65
           80    80    90];
% Template image; here NOT skull stripped template image ???
% temp_imgs = fullfile(spm('Dir'),'templates', 'T1.nii');   % use T1.mnc in spm2 
sourceimg = spm_select('ExtFPList',fullfile(spm('Dir'),'apriori'), 'grey.nii',1);

clear imgs;
newdir=fullfile(PAR.root,PAR.localtemplate);
P=spm_select('ExtFPList',newdir,'^Template_6.nii',1);
if strcmp(P,'/')||isempty(P)
    fprintf('No general template found for the two groups!\n');
    return;
end
objmask='';
matname=['template2MNI_sn.mat'];
spm_normalise(sourceimg, P, matname,...
		defs.estimate.weight, objmask, ...
		defs.estimate);
