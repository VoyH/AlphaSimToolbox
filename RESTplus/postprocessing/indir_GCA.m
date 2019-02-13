function indir_GCA(indir_FunImg,outfodr_GCA,infilepath_Mask,Parameter)
% Parameter.GCAtype: residual
%                    coefficient
% Parameter.AROIDef: cell     -> ROI wise
%                    not cell -> Voxel wise
% Parameter.Order
% 
% Parameter.CoefficientMode: 'BivariateMode'
%                            'MulivariateMode'
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



AROIDef=Parameter.AROIDef;
inpath_Misc(outfodr_GCA,'MakeCurrentDir');
SubfodrList=dir_NameList(indir_FunImg);
ACovariablesDef.ort_file='';
Order=Parameter.Order;


for i=1:length(SubfodrList)
    DataDir=[indir_FunImg filesep SubfodrList{i}];
    AResultFilename=[outfodr_GCA filesep 'GCA_' SubfodrList{i}];
    
    if strcmp(Parameter.GCAtype,'residual')
      rp_gca_residual(DataDir,infilepath_Mask, AROIDef,AResultFilename, ACovariablesDef,Order);
    elseif strcmp(Parameter.GCAtype,'coefficient')
        if strcmp(Parameter.CoefficientMode,'BivariateMode')
           CoefficientMode=1; 
        elseif strcmp(Parameter.CoefficientMode,'MulivariateMode')
           CoefficientMode=0;
        end
        rp_gca_coefficient(DataDir,infilepath_Mask, AROIDef,AResultFilename, ACovariablesDef,Order,CoefficientMode);
    end 
    
end

GCAFilelist = dir([outfodr_GCA filesep 'GCA_*.nii']); 
[pathstr, name, ext]=fileparts(outfodr_GCA);
outfodr_zGCA=[pathstr filesep 'Z' name];
for j=1:length(GCAFilelist),
    theOrigGCAMap = [outfodr_GCA filesep GCAFilelist(j).name];
    theMeanGCAMap = [outfodr_zGCA filesep 'Z' GCAFilelist(j).name];
    rp_gca_Std(theOrigGCAMap, theMeanGCAMap, infilepath_Mask);
end   






end