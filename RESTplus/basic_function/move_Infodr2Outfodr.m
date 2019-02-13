function move_Infodr2Outfodr(Infodr,Outfodr,Option,varargin)
% move_Infodr2Outfodr(Infodr,Outfodr,'RegExp',RegularExpression)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

inpath_Misc(Outfodr,'MakeCurrentDir');
switch Option
    case 'RegExp' %RegularExpression
        RegularExpression=varargin{1};
        move_RegExp(Infodr,Outfodr,RegularExpression);
end

end


function move_RegExp(Infodr,Outfodr,RegularExpression)
    
    FileList=dir_4RegExp(Infodr,RegularExpression);
    if isempty(FileList)
        error('no exist file in %s',Infodr);
    else    
        for i=1:length(FileList)
            movefile([Infodr filesep FileList{i}],[Outfodr filesep FileList{i}]);
        end   
    end

end