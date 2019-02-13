function OutputStr=get_PreParaStr(AOperation)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


switch AOperation
    case 'blank'
        OutputStr='blank';
    case 'KccReHo'
        OutputStr='KccReHo';
    case 'ALFF'
        OutputStr='ALFF';        
    case 'fALFF'
        OutputStr='fALFF';                
    case 'PerAF'
        OutputStr='PerAF';                
    case 'DegreeCentrality'
        OutputStr='DegreeCentrality';                        
    case 'VMHC'
        OutputStr='VMHC';                        
    otherwise
    error('wrong get_PreParaStr');
end


end