function p=use_p_asltbx_pcasl()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


Xmargin=0.15;
line_number=57;

for i=1:line_number
    p.asltbx_pcasl.(['line' num2str(i)]).x=Xmargin;
    p.asltbx_pcasl.(['line' num2str(i)]).y=0.95-0.038*(i-1);
end

end