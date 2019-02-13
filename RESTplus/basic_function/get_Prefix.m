function Prefix = get_Prefix(Option)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

switch Option
    case 'DivideMeanWithinMask'
        Prefix='m';
    case 'CalcZscoreWithinMask'
        Prefix='z';
    otherwise
         error('get_Prefix!!');

end


end