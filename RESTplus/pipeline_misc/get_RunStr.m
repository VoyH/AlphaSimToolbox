function RunStr = get_RunStr(AOperation)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    switch AOperation            
        case 'DicomToNifti'
            RunStr='DicomToNifti';
        case 'EpiDicomtoNifti'
             RunStr='EpiDicomtoNifti';
        case 'T1DicomToNifti'
            RunStr='T1DicomToNifti';
        case 'RemoveFirstTimePoints'
            RunStr='RemoveFirstTimePoints';
        case 'SliceTiming'
            RunStr='SliceTiming';
        case 'Realign'
            RunStr='Realign';
        
        case 'Reorient'
            RunStr='Reorient';
        case 'ReorientFunBeforeCoreg'
            RunStr='ReorientFunBeforeCoreg';
        case 'ReorientT1BeforeCoreg'
            RunStr='ReorientT1BeforeCoreg';
        case 'ReorientT1AfterCoreg'
            RunStr='ReorientT1AfterCoreg';
        
        case 'Normalize'
            RunStr='Normalize';
        case 'NormalizeEpi'
            RunStr='NormalizeEpi';
        case 'T1CoregisterFun'
            RunStr='T1CoregisterFun';
        case 'T1Segment'
            RunStr='T1Segment';
        case 'NormalizeSeg'
            RunStr='NormalizeSeg';
        case 'NormalizeSymSeg'
            RunStr='NormalizeSymSeg';
        case 'NormalizeNewSeg_dartel'
            RunStr='NormalizeNewSeg_dartel';
        case 'Smooth'
            RunStr='Smooth';
        case 'Detrend'
            RunStr='Detrend';
        case 'Filter'
            RunStr='Filter';
        case 'RegressOutCovariates'
            RunStr='RegressOutCovariates';
        case 'Alff'
            RunStr='Alff';
        case 'fALFF'
            RunStr='fALFF';
        case 'KccReHo'
            RunStr='KccReHo';
        case 'CoHeReHo'
            RunStr='CoHeReHo';
        case 'FunctionalConnectivity'
            RunStr='FunctionalConnectivity';
        case 'VMHC'
            RunStr='VMHC';
        case 'PerAF'
            RunStr='PerAF';
        case 'DegreeCentrality'
            RunStr='DegreeCentrality';
        case 'GCA'
            RunStr='GCA';
        otherwise
                error('get_RunStr is wrong');
    end
end