function copy_brainimage_file(source,destination)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



[s_pathstr, s_name, s_ext]=fileparts(source);
[d_pathstr, d_name, d_ext]=fileparts(destination);

if ~strcmp(s_ext,d_ext)
    error('copy_brainimage_file');
end

if strcmp(s_ext,'.hdr')||strcmp(s_ext,'.img')
   copy_hdr_img(source,destination); 
else
   copyfile(source,destination,'f'); 
end

end


function copy_hdr_img(source,destination)
[s_pathstr, s_name, s_ext]=fileparts(source);
[d_pathstr, d_name, d_ext]=fileparts(destination);


if strcmp(s_ext,'.hdr')
    copyfile(source,destination,'f');
    copyfile([s_pathstr filesep s_name '.img'],...
             [d_pathstr filesep d_name '.img']);
elseif strcmp(s_ext,'.img')
    copyfile(source,destination,'f');
    copyfile([s_pathstr filesep s_name '.hdr'],...
             [d_pathstr filesep d_name '.hdr']);
else
    error('copy_hdr_img');
end

end