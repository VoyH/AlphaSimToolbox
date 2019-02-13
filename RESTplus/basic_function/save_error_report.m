function save_error_report(ME,report_path)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150905
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

rep = getReport(ME, 'extended', 'hyperlinks', 'off');
fid = fopen(report_path, 'w+t','n');
fprintf(fid, 'Error message\n-------------\n\n');
fprintf(fid, '%s\n', rep);
fclose('all');
end