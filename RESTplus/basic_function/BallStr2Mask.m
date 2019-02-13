function SphereMask=BallStr2Mask(ABallStr,TheReference, Unit, OutMaskName)
%ABallStr='ROI Center(mm)=(CenterX, CenterY, CenterZ); Radius=6.00 mm.'
%ABallStr='ROI Center(mm)=(CenterI, CenterJ, CenterK); Radius=6.00 mm.'
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


 if nargin <=3
     OutMaskName='';
     if nargin <=2 
         Unit='MNI';
     end
 end
ABallArray= SphereROI('BallStr2BallArray', ABallStr);
SphereMask= SphereROI('BallArray2Mask', ABallArray,TheReference, Unit, OutMaskName);  
end