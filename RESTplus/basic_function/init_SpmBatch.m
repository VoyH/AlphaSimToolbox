function jobs=init_SpmBatch(Option)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;


switch Option
    case 'SliceTiming'
        jobs{1,1}.temporal{1,1}.st.scans{1}={};
        jobs{1,1}.temporal{1,1}.st.nslices = [];
        jobs{1,1}.temporal{1,1}.st.tr=[];
        jobs{1,1}.temporal{1,1}.st.ta=[];
        jobs{1,1}.temporal{1,1}.st.so = [];
        jobs{1,1}.temporal{1,1}.st.refslice =[];
        jobs{1,1}.temporal{1,1}.st.prefix={};
    case 'Realign'
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.data = {};
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.eoptions.quality = 0.9;
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.eoptions.sep = 4;
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.eoptions.fwhm = 5;
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.eoptions.rtm = 1;
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.eoptions.interp = 2;
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.eoptions.wrap = [0 0 0];
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.eoptions.weight = '';
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.roptions.which = [2 1];
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.roptions.interp = 4;
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.roptions.wrap = [0 0 0];
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.roptions.mask = 1;
        jobs{1,1}.spatial{1,1}.realign{1,1}.estwrite.roptions.prefix = '';
    case 'NormalizeEPI'
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj.source = '';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj.wtsrc = {};
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj.resample = '';       
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.template = '';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.weight = {};
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.smosrc = 8;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.smoref = 0;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.regtype = 'mni';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.cutoff = 25;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.nits = 16;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.reg = 1;       
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.preserve = 0;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.bb = [-90,-126,-72;90,90,108];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.vox = [3 3 3];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.interp = 1;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.wrap = [0 0 0];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.prefix = '';
        
    case 'NormalizeSeg_Sym'
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj.source = '';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj.wtsrc = '';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.subj.resample = '';       
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.template = '';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.weight = '';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.smosrc = 8;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.smoref = 0;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.regtype = 'mni';
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.cutoff = 25;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.nits = 16;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.eoptions.reg = 1;       
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.preserve = 0;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.bb = [-78,-112,-50;78,76,85];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.vox = [2 2 2];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.interp = 1;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.wrap = [0 0 0];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.estwrite.roptions.prefix = '';  
    case 'run_dartel_creat_templates'
        jobs{1,1}.spm.tools.dartel.warp.images = {};
        jobs{1,1}.spm.tools.dartel.warp.settings.template = 'Template';
        jobs{1,1}.spm.tools.dartel.warp.settings.rform = 0;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,1).its = 3;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,1).rparam = [4 2 1e-06];
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,1).K = 0;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,1).slam = 16;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,2).its = 3;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,2).rparam = [2 1 1e-06];
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,2).K = 0;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,2).slam = 8;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,3).its = 3;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,3).rparam = [1 0.5 1e-06];
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,3).K = 1;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,3).slam = 4;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,4).its = 3;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,4).rparam = [0.5 0.25 1e-06];
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,4).K = 2;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,4).slam = 2;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,5).its = 3;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,5).rparam = [0.25 0.125 1e-06];
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,5).K = 4;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,5).slam = 1;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,6).its = 3;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,6).rparam = [0.25 0.125 1e-06];
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,6).K = 6;
        jobs{1,1}.spm.tools.dartel.warp.settings.param(1,6).slam = 0.5;
        jobs{1,1}.spm.tools.dartel.warp.settings.optim.lmreg = 0.01;
        jobs{1,1}.spm.tools.dartel.warp.settings.optim.cyc = 3;
        jobs{1,1}.spm.tools.dartel.warp.settings.optim.its = 3;
    case 'dartel_normalise_to_mni_space'
        jobs{1,1}.spm.tools.dartel.mni_norm.template = '<UNDEFINED>';
        jobs{1,1}.spm.tools.dartel.mni_norm.data = '<UNDEFINED>';
        jobs{1,1}.spm.tools.dartel.mni_norm.vox = [3 3 3];
        jobs{1,1}.spm.tools.dartel.mni_norm.bb = [-90,-126,-72;90,90,108];
        jobs{1,1}.spm.tools.dartel.mni_norm.preserve = 0;
        jobs{1,1}.spm.tools.dartel.mni_norm.fwhm = [4 4 4];
    case 'Coregister'
        jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.ref = '';
        jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.source = '';
        jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.other = {''};
        jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.eoptions.cost_fun = 'nmi';
        jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.eoptions.sep = [4 2];
        jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.eoptions.tol = [0.02 0.02 0.02 0.001 0.001 0.001 0.01 0.01 0.01 0.001 0.001 0.001];
        jobs{1,1}.spatial{1,1}.coreg{1,1}.estimate.eoptions.fwhm = [7 7];
    case 'Segmentation'
        jobs{1,1}.spatial{1,1}.preproc.data = '<UNDEFINED>';
        jobs{1,1}.spatial{1,1}.preproc.output.GM = [1 1 1];
        jobs{1,1}.spatial{1,1}.preproc.output.WM = [1 1 1];
        jobs{1,1}.spatial{1,1}.preproc.output.CSF = [1 1 1];
        jobs{1,1}.spatial{1,1}.preproc.output.biascor = 1;
        jobs{1,1}.spatial{1,1}.preproc.output.cleanup = 1;
        jobs{1,1}.spatial{1,1}.preproc.opts.tpm = {};
        jobs{1,1}.spatial{1,1}.preproc.opts.ngaus = [2,2,2,4];
        jobs{1,1}.spatial{1,1}.preproc.opts.regtype = 'eastern';
        jobs{1,1}.spatial{1,1}.preproc.opts.warpreg = 1;
        jobs{1,1}.spatial{1,1}.preproc.opts.warpco = 25;
        jobs{1,1}.spatial{1,1}.preproc.opts.biasreg = 0.0001;
        jobs{1,1}.spatial{1,1}.preproc.opts.biasfwhm = 60;
        jobs{1,1}.spatial{1,1}.preproc.opts.samp = 3;
        jobs{1,1}.spatial{1,1}.preproc.opts.msk = {''};
    case 'NewSegment'
        jobs{1,1}.spm.tools.preproc8.channel.vols = '';
        jobs{1,1}.spm.tools.preproc8.channel.biasreg = 0.0001;
        jobs{1,1}.spm.tools.preproc8.channel.biasfwhm = 60;
        jobs{1,1}.spm.tools.preproc8.channel.write = [1,1];
        jobs{1,1}.spm.tools.preproc8.tissue(1,1).tpm{1,1} = '';
        jobs{1,1}.spm.tools.preproc8.tissue(1,1).ngaus = 2;
        jobs{1,1}.spm.tools.preproc8.tissue(1,1).native = [1 1];
        jobs{1,1}.spm.tools.preproc8.tissue(1,1).warped = [0 0];
        jobs{1,1}.spm.tools.preproc8.tissue(1,2).tpm{1,1} = '';
        jobs{1,1}.spm.tools.preproc8.tissue(1,2).ngaus = 2;
        jobs{1,1}.spm.tools.preproc8.tissue(1,2).native = [1 1];
        jobs{1,1}.spm.tools.preproc8.tissue(1,2).warped = [0 0];
        jobs{1,1}.spm.tools.preproc8.tissue(1,3).tpm{1,1} = '';
        jobs{1,1}.spm.tools.preproc8.tissue(1,3).ngaus = 2;
        jobs{1,1}.spm.tools.preproc8.tissue(1,3).native = [1 1];
        jobs{1,1}.spm.tools.preproc8.tissue(1,3).warped = [0 0];
        jobs{1,1}.spm.tools.preproc8.tissue(1,4).tpm{1,1} = '';
        jobs{1,1}.spm.tools.preproc8.tissue(1,4).ngaus = 3;
        jobs{1,1}.spm.tools.preproc8.tissue(1,4).native = [1 1];
        jobs{1,1}.spm.tools.preproc8.tissue(1,4).warped = [0 0];
        jobs{1,1}.spm.tools.preproc8.tissue(1,5).tpm{1,1} = '';
        jobs{1,1}.spm.tools.preproc8.tissue(1,5).ngaus = 4;
        jobs{1,1}.spm.tools.preproc8.tissue(1,5).native = [1 1];
        jobs{1,1}.spm.tools.preproc8.tissue(1,5).warped = [0 0];
        jobs{1,1}.spm.tools.preproc8.tissue(1,6).tpm{1,1} = '';
        jobs{1,1}.spm.tools.preproc8.tissue(1,6).ngaus = 2;
        jobs{1,1}.spm.tools.preproc8.tissue(1,6).native = [1 1];
        jobs{1,1}.spm.tools.preproc8.tissue(1,6).warped = [0 0];
%         jobs{1,1}.spm.tools.preproc8.warp.mrf = 0;
        jobs{1,1}.spm.tools.preproc8.warp.reg = 4;
        jobs{1,1}.spm.tools.preproc8.warp.affreg = 'mni';
        jobs{1,1}.spm.tools.preproc8.warp.samp = 3;
        jobs{1,1}.spm.tools.preproc8.warp.write = [1 1];
    case 'Normalizewrite'
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.subj.matname = {};
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.subj.resample = {}; 
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.preserve = 0;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.bb = [-90 -126 -72;90 90 108];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.vox = [2 2 2];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.interp = 1;
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.wrap = [0 0 0];
        jobs{1,1}.spatial{1,1}.normalise{1,1}.write.roptions.prefix = '';
    case 'SPMdefaultSmooth'
        jobs{1,1}.spatial{1,1}.smooth.data = {};
        jobs{1,1}.spatial{1,1}.smooth.fwhm = [];
        jobs{1,1}.spatial{1,1}.smooth.dtype = 0;
        jobs{1,1}.spatial{1,1}.smooth.prefix = '';
    case 'DeformationInverse'            
        jobs{1,1}.util{1,1}.defs.comp{1}.inv.comp{1}.sn2def.matname = {};
        jobs{1,1}.util{1,1}.defs.comp{1}.inv.comp{1}.sn2def.vox = [NaN NaN NaN];
        jobs{1,1}.util{1,1}.defs.comp{1}.inv.comp{1}.sn2def.bb = [NaN NaN NaN
                                                                  NaN NaN NaN];
        jobs{1,1}.util{1,1}.defs.comp{1}.inv.space = {};
        jobs{1,1}.util{1,1}.defs.ofname = '';
        jobs{1,1}.util{1,1}.defs.fnames = {};
              
        jobs{1,1}.util{1,1}.defs.savedir.saveusr = {};
        jobs{1,1}.util{1,1}.defs.interp = 1;% Interpolation: Nearest neighbour=0; Trilinear=1;
        
        
    case 'DICOM_import'
        jobs{1,1}.spm.util.dicom.data = {};
        jobs{1,1}.spm.util.dicom.root = 'flat';
        jobs{1,1}.spm.util.dicom.outdir = {};
        jobs{1,1}.spm.util.dicom.convopts.format = 'nii';
        jobs{1,1}.spm.util.dicom.convopts.icedims = 0;
end

