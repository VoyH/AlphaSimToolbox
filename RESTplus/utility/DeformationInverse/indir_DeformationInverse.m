function indir_DeformationInverse(indir_RealignParameter,indir_T1ImgSegment,input_AppliedImages,snmat_RegExp,output_path)
% input_AppliedImages FunImgARW
%                     Results/mALFF
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


   subfolderlist=dir_NameList(indir_T1ImgSegment);
   for i=1:length(subfolderlist)
       infodr_RealignParameter=[indir_RealignParameter filesep subfolderlist{i}];
       infodr_T1ImgSegment=[indir_T1ImgSegment filesep subfolderlist{i}];    
       [output_path,input_AppliedImages]=get_InOutputpath(input_AppliedImages,output_path,subfolderlist{i});
       infodr_DeformationInverse(infodr_RealignParameter,infodr_T1ImgSegment,input_AppliedImages,snmat_RegExp,output_path);
   end
   
end


    
 function [output_path,input_AppliedImages]=get_InOutputpath(input_AppliedImages,output_path,subfolderNam)
    % indir_AppliedImages
    % FunImgARWSD
    % Result/mALFF
    sublist=dir_4RegExp(input_AppliedImages,['*' subfolderNam '*']);
    subpath=[input_AppliedImages filesep sublist{1}];
          
    if 7==exist(subpath,'file')%folder | input_AppliedImages= FunImgARWSD
       output_path=[output_path filesep subfolderNam];
    end
    input_AppliedImages=subpath;

 end
    
    