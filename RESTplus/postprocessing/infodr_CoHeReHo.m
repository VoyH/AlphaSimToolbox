function infodr_CoHeReHo(AllVolume,outfile_CoHeReHo,infile_Mask,Parameter)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    NVoxel=Parameter.NVoxel;
    ASamplePeriod=Parameter.SamplePeriod;
    ALowPass_HighCutoff=Parameter.LowPass_HighCutoff;
    AHighPass_LowCutoff=Parameter.HighPass_LowCutoff;
    Auto=Parameter.Auto;
    TimeP=Parameter.TimeP;
    Overlap=Parameter.Overlap;

    rp_Cohe_ReHo_Brain(AllVolume, NVoxel, infile_Mask, outfile_CoHeReHo,ASamplePeriod,AHighPass_LowCutoff,ALowPass_HighCutoff,Auto,TimeP,Overlap);
end