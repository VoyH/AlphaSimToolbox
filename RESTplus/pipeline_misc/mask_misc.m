function varargout = mask_misc(AOperation,varargin)
% MaskInfo = mask_misc('getGUImaskinfo',handles)
% Maskpath = mask_misc('Maskinfo2MaskPath',Maskinfo,indir_Fun)
% defaultmaskpath = mask_misc('MatchDefaultMask',indir_Fun)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com





switch AOperation
    case 'getGUImaskinfo'
        varargout{1}=get_GUIMaskfile(varargin{1});
    case 'Maskinfo2MaskPath'
        varargout{1}=MaskinfoToMaskpath(varargin{1},varargin{2});
    case 'MatchDefaultMask'
        varargout{1}=match_DefaultMask(varargin{1});
    otherwise
            error('wrong in mask_misc')
        
        
end
end

function MaskInfo=get_GUIMaskfile(handles)                                                                
    if 1==get(handles.UIhandles.DefaultmaskRadioBtn.handle ,'value')
        MaskInfo= 1; %'DefaultMask';
    elseif 1==get(handles.UIhandles.NoMaskRadioBtn.handle ,'value')
        MaskInfo= 0; %'NoMask';
    elseif 1== get(handles.UIhandles.UserDefinedMaskRadioBtn.handle ,'value')
       MaskInfo=get(handles.hPara.UserMask.Edit,'string');
    else
        error('did not select any mask radio button');
    end
end


function Maskpath=MaskinfoToMaskpath(Maskinfo,indir_Fun)
% Maskinfo 1;0;path
if isnumeric(Maskinfo)
   if 1==Maskinfo
      Maskpath=mask_misc('MatchDefaultMask',indir_Fun);
   elseif 0==Maskinfo
        Maskpath=0; % Do not use any mask
   else
       error('error mask_info');
   end    
elseif ischar(Maskinfo)
   Maskpath=Maskinfo;     
else
    error('mask_misc wrong');
end

end




function defaultmaskpath=match_DefaultMask(indir_Fun)

    ImgPath=inpath_Misc(indir_Fun,'GetIndir1stSubject1stSubImgPath');
    ImgStruct=nifti(ImgPath);
    ImgSize=size(ImgStruct.dat);
    ImgSize=ImgSize(1:3);
    defaultmaskpath=load_DefaultMaskPath(ImgSize);
end


function maskpath=load_DefaultMaskPath(BrainSize)
    MainPath=get_Parameters('MASKPATH');
    switch int2str(BrainSize)
            case '79  95  69'   % 'default''[2 2 2]'
                maskpath=([MainPath filesep 'BrainMask_05_79x95x69.img']); 
            case '53  63  46'   % 'default''[3 3 3]'	        
                maskpath=([MainPath filesep 'BrainMask_05_53x63x46.img']); 
            case '91  109   91'  % 'template''[2 2 2]'	        
                maskpath=([MainPath filesep 'BrainMask_05_91x109x91.img']); 
            case '61  73  61'   % 'template' '[3 3 3]'	        
                maskpath=([MainPath  filesep 'BrainMask_05_61x73x61.img']);
            otherwise
                error(sprintf('There are no appropriate default mask file:\n\tVolume size=79*95*69 ,Voxel size=2*2*2;\n\tVolume size=53*63*46, Voxel size=3*3*3;\n\tVolume size=91*109*91, Voxel size=2*2*2;\n\tVolume size=61*73*61, Voxel size=3*3*3;\n Please set MaskDataIn = 0.'));
    end %end switch
end