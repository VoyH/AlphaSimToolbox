function batch_run_spm_jobman(subject_list,spm_batch_list)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



if matlabpool('size')>0
    parfor i=1:length(subject_list)
        run_SpmBatch(spm_batch_list{i});
    end
else
    for i=1:length(subject_list)
        run_SpmBatch(spm_batch_list{i});
    end
end

end