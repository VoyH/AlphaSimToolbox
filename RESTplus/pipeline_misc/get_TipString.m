function TipString = get_TipString(AOperation)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


switch AOperation
    case 'DicomToNifti'
        TipString='DICOM TO NIFTI';
    case 'RemoveFirstTimePoints'
        TipString='Remove First Time Points';
    case 'SliceTiming'
        TipString='SliceTiming';
    case 'Realign'
        TipString='Realign';
    case 'Reorient'
        TipString='Reorient';
    case 'Normalize'
        TipString='Normalize';
    case 'Smooth'
        TipString='Smooth';
    case 'Detrend'
        TipString='Detrend';
    case 'Filter'
        TipString='Filter';
    case 'RegressOutNuisance'
        TipString='RegressOutNuisance';
    otherwise
            error('get_TipString wrong');
end

end