function varargout= batch_calc3dimg(AOperation,varargin) 
% batch_calc3dimg('DivideMeanWithinMask',infodr,outfodr,maskfile);
% batch_calc3dimg('CalcZscoreWithinMask',infodr,outfodr,maskfile);
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


    switch AOperation
        case 'DivideMeanWithinMask'
            batch_DivideMeanWithinMask(varargin{1},varargin{2},varargin{3});
        case 'CalcZscoreWithinMask'
            batch_CalcZscoreWithinMask(varargin{1},varargin{2},varargin{3});
        otherwise
                error('wrong calc3dimgfodr');
    end

end


function batch_DivideMeanWithinMask(infodr,outfodr,maskfile)
    subfilelist=dir_NameList(infodr);
    for i=1:length(subfilelist)
        calc3dimg('DivideMeanWithinMask',[infodr filesep subfilelist{i}],...
                                         [outfodr filesep get_Postfix('DivideMeanWithinMask') subfilelist{i}],...
                                         maskfile); 
    end
end


function batch_CalcZscoreWithinMask(infodr,outfodr,maskfile)
    subfilelist=dir_NameList(infodr);
    for i=1:length(subfilelist)
        calc3dimg('CalcZscoreWithinMask',[infodr filesep subfilelist{i}],...
                                         [outfodr filesep get_Postfix('CalcZscoreWithinMask') subfilelist{i}],...
                                         maskfile); 
    end
end