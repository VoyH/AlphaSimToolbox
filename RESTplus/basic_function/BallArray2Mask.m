function SphereMask=BallArray2Mask(ABallArray, TheReference, Unit, OutMaskName)
%ABallArray [CenterX, CenterY, CenterZ, Radius]
%ABallArray [CenterI, CenterJ, CenterK, Radius]
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
     
     
     ChekInput(Unit);
     SphereMask=OutPut_SphereMask(TheReference,ABallArray,Unit);
   

    if ~isempty(OutMaskName)
        OutPutSphereMaskFile(SphereMask,TheReference,OutMaskName);
    end

end

function ChekInput(Unit)
    if (~strcmpi(Unit,'MNI'))&&(~strcmpi(Unit,'IJK'))
       error('wrong for Unit in BallArray2Mask function!');
    end
end

function SphereMask=OutPut_SphereMask(TheReference,ABallArray,Unit)
    BallCenter=ABallArray(1:3);
    Radius=ABallArray(4);
    Header=GetHeader(TheReference);
    
    [CenterArray_IJK,RadiusArray_IJK]=ConvertBallArray(BallCenter,Radius,Header,Unit);
    BallCenterRevised=Header.mat*ctranspose([CenterArray_IJK,1]);%Center voxel IJK rounded, so revise the XYZ mm
    BallCenterRevised=ctranspose(BallCenterRevised(1:3)); 
    [RangeMin,RangeMax]=CalcSphereRange(CenterArray_IJK,RadiusArray_IJK,Header);
    SphereMask=DrawSphere(RangeMin,RangeMax,BallCenterRevised,Radius,Header,Unit);
        
end


function Header=GetHeader(TheReference)
    if ~isstruct(TheReference) %TheReference is a NIfTI file
        [Outdata,VoxDim,Header] = read_To3d(TheReference);
    else %TheReference is actually a NIfTI Header struct
        Header = TheReference;
    end

end
    
function [CenterArray_IJK,RadiusArray_IJK]=ConvertBallArray(BallCenter,Radius,Header,Unit)
    VoxelSize=HeaderCalc('CalcVoxelSize',Header);
    
    switch upper(Unit)
        case 'MNI'
             CenterArray_IJK=HeaderCalc('MNI2IJK',BallCenter,Header); 
             RadiusArray_IJK=[Radius/VoxelSize(1),Radius/VoxelSize(2),Radius/VoxelSize(3)];
        case 'IJK'
             CenterArray_IJK=BallCenter;
             RadiusArray_IJK=[Radius,Radius,Radius];
    end
end
    
function [RangeMin,RangeMax]=CalcSphereRange(CenterArray_IJK,RadiusArray_IJK,Header)
    [nDim1,nDim2,nDim3]=HeaderCalc('Get3DBrainDim',Header);            
    RangeMin = CenterArray_IJK - RadiusArray_IJK;
    RangeMin = fix(max(1,RangeMin));
    RangeMax = CenterArray_IJK + RadiusArray_IJK;
    RangeMax = ceil(min([nDim1,nDim2,nDim3],RangeMax));
end



function ASphereMatrix=DrawSphere(RangeMin,RangeMax,BallCenterRevised,Radius,Header,Unit)
    [nDim1,nDim2,nDim3]=HeaderCalc('Get3DBrainDim',Header);            
    BoundingMatrix = zeros(nDim1,nDim2,nDim3);
    
        for i=RangeMin(1):RangeMax(1)
            for j=RangeMin(2):RangeMax(2)
                for k=RangeMin(3):RangeMax(3)
                    BoundingMatrix=FillBoundingMatrix(BoundingMatrix,[i j k],BallCenterRevised,Radius,Header,Unit);
                end
            end
        end
        
        
    ASphereMatrix=BoundingMatrix;
end

function BoundingMatrix=FillBoundingMatrix(BoundingMatrix,Coordinate,BallCenterRevised,Radius,Header,Unit)
    switch upper(Unit)
            case 'MNI'
                  MNI_Coordinate=HeaderCalc('IJK2MNI',Coordinate,Header); 
                   if norm(MNI_Coordinate-BallCenterRevised)<=Radius
                       BoundingMatrix(Coordinate(1),Coordinate(2),Coordinate(3)) = 1;
                   end
            case 'IJK' 
                   if norm(Coordinate-BallCenterRevised)<=Radius
                       BoundingMatrix(Coordinate(1),Coordinate(2),Coordinate(3)) = 1;
                   end
    end
end


function OutPutSphereMaskFile(SphereMask,TheReference,OutMaskName)
    Header=GetHeader(TheReference);
    VoxelSize=HeaderCalc('CalcVoxelSize',Header);
    write_To3dNifti(SphereMask,OutMaskName,Header.dim,VoxelSize,Header,'single')
end