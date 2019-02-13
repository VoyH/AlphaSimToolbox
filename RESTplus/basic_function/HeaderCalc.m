function varargout=HeaderCalc(AOperation, varargin)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

    switch upper(AOperation)
        case 'CALCVOXELSIZE'  %CalcVoxelSize
              ChekInput(AOperation,nargin);
              varargout{1}=CalcVoxelSize(varargin{1});
        case 'MNI2IJK'        %mni2jjk
              ChekInput(AOperation,nargin);
              varargout{1}=CalcMNI2IJK(varargin{1},varargin{2});
        case 'IJK2MNI'        %ijk2mni
              ChekInput(AOperation,nargin);
              varargout{1}=CalcIJK2MNI(varargin{1},varargin{2});
        case 'GET3DBRAINDIM'   %Get3DBrainDim
              ChekInput(AOperation,nargin);
              [varargout{1},varargout{2},varargout{3}]=Get3DBrainDim(varargin{1});


    end
end




function ChekInput(AOperation,NarginValue)
     switch upper(AOperation)
            case 'CALCVOXELSIZE'  %CalcVoxelSize
                 if 2~=NarginValue
                     error('Usage: VoxelSize =HeaderCalc( ''CalcVoxelSize'' , AHeader);');
                 end
            case 'MNI2IJK'
                 if 3~=NarginValue
                     error('Usage: AIJKCoordinate =HeaderCalc( ''MNI2IJK'' , AMNICoordinate , AHeader);');
                 end
           case 'IJK2MNI'
                 if 3~=NarginValue
                     error('Usage: AMNICoordinate =HeaderCalc( ''IJK2MNI'' , AIJKCoordinate , AHeader);');
                 end               
           case 'GET3DBRAINDIM'   %Get3DBrainDim
                 if 2~=NarginValue
                     error('Usage: [nDim1,nDim2,nDim3] =HeaderCalc( ''Get3DBrainDim'' , AHeader);');
                 end
      end
end

function VoxelSize=CalcVoxelSize(Header)
         VoxelSize = sqrt(sum(Header.mat(1:3,1:3).^2));
end


function IJK_Coordinate=CalcMNI2IJK(MNI_Coordinate,Header)
   if isfield(Header,'mat')
        IJK_Coordinate=round(inv(Header.mat)*[MNI_Coordinate,1]'); %Get the center voxel IJK from input center MNI mm
        IJK_Coordinate=IJK_Coordinate(1:3);
        IJK_Coordinate=reshape(IJK_Coordinate, 1,length(IJK_Coordinate));
   else
        AOrigin=Header.Origin;
        AVoxelSize=HeaderCalc('CalcVoxelSize', Header);
        MNI_Coordinate(1)=-MNI_Coordinate(1);                     %20150107 suggested by LDQ
        IJK_Coordinate =round(MNI_Coordinate./AVoxelSize) +AOrigin;
   end
end



	
    

function MNI_Coordinate=CalcIJK2MNI(IJK_Coordinate,Header)
   if isfield(Header,'mat')
        MNI_Coordinate = Header.mat*[IJK_Coordinate(1) IJK_Coordinate(2) IJK_Coordinate(3) 1]';
        MNI_Coordinate = MNI_Coordinate(1:3);
        MNI_Coordinate=reshape(MNI_Coordinate, 1,length(MNI_Coordinate));
   else
       error('mat is not a field for Header');
   end
end


function [nDim1,nDim2,nDim3]=Get3DBrainDim(Header)
    nDim1 = Header.dim(1);
    nDim2 = Header.dim(2);
    nDim3 = Header.dim(3);
end

