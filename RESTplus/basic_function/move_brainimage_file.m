function move_brainimage_file(source,destination)
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

if ~isdir(d_pathstr)
    mkdir(d_pathstr);
end

if strcmp(s_ext,'.hdr')||strcmp(s_ext,'.img')
   move_hdr_img(source,destination); 
else
   movefile(source,destination,'f'); 
end

end


function move_hdr_img(source,destination)
[s_pathstr, s_name, s_ext]=fileparts(source);
[d_pathstr, d_name, d_ext]=fileparts(destination);


if strcmp(s_ext,'.hdr')
    movefile(source,destination,'f');
    movefile([s_pathstr filesep s_name '.img'],...
             [d_pathstr filesep d_name '.img']);
elseif strcmp(s_ext,'.img')
    movefile(source,destination,'f');
    movefile([s_pathstr filesep s_name '.hdr'],...
             [d_pathstr filesep d_name '.hdr']);
else
    error('copy_hdr_img');
end

end