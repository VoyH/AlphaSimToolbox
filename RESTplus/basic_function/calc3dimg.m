function varargout = calc3dimg(AOperation,varargin) 
%mResultMap = calc3dimg('DivideMeanWithinMask',ASrcImg, ADstImg, AMaskFilename) 
%zResultMap = calc3dimg('CalcZscoreWithinMask',ASrcImg, ADstImg, AMaskFilename) 

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


switch AOperation
    case 'DivideMeanWithinMask'
       varargout{1}=DivideMeanWithinMask(varargin{1},varargin{2},varargin{3}); 
    case 'CalcZscoreWithinMask'
       varargout{1}=CalcZscoreWithinMask(varargin{1},varargin{2},varargin{3});         
    otherwise
            error('error calc3dimg');
end

end




function ResultMap= DivideMeanWithinMask(ASrcImg, ADstImg, AMaskFilename)
	if ~(nargin==3) error(' Error using ==> DivideMaskMean. 3 arguments wanted.'); end
	%Load the original ReHo map file
	[brainMap,vsize, Header]=read_To3d(ASrcImg);
	M = size(brainMap,1); N = size(brainMap,2); O = size(brainMap,3);
	isize = [M N O]; vsize =vsize';
	[mask,maskvsize, maskHeader]=read_To3d(AMaskFilename);

	%Calcute the mean and divide ReHo map by the mean
	pos=find(mask);
	masked_brainMap=zeros(size(brainMap,1),size(brainMap,2),size(brainMap,3));
	masked_brainMap(pos)=brainMap(pos);
	mean_value=reshape(masked_brainMap, size(masked_brainMap,1)*size(masked_brainMap,2)*size(masked_brainMap,3), 1);
	mean_value=double(sum(mean_value)) / double(length(pos));
	ResultMap=brainMap./mean_value;
	write_To3dNifti(single(ResultMap),ADstImg,isize,vsize,Header, 'single'); %Revised by YAN Chao-Gan, 090321. Result data will be stored in 'single' format. %'double');
end



function ResultMap=CalcZscoreWithinMask(ASrcImg,ADstImg,AMaskFilename)

[AllVolume,VoxDim,Header]=read_To3d(ASrcImg);
[BrainMaskData,MaskVox,MaskHeader]=read_To3d(AMaskFilename);

ResultMap=((AllVolume - mean(AllVolume(find(BrainMaskData)))) ./ std(AllVolume(find(BrainMaskData)))) .* (BrainMaskData~=0);
write_To3dNifti(ResultMap,ADstImg,Header.dim,VoxDim,Header,'single');
end