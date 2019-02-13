% clc
clear
par;
batch_resetorientation;   % reset orientation and the origin
batch_coreg_func2anat;    % register perfusion difference image to T1. ?????????
%batch_nsegment;           % segmentation and normalization.            ?????????(???????)
batch_normspm12_est;
batch_norm_cbfimgs;       % registering CBF images to the MNI space    ???????MNI????
batch_smooth_norm;
% batch_pairedT_CBF;       % comparing CBF between the two conditions
