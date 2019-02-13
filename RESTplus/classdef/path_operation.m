classdef path_operation < handle
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201411
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

   properties(Access=private)
       init_path
       prefix
   end

   
   
    methods 
        function obj=path_operation(input_path)
            obj.init_path=input_path;
        end
        
        function the_brain_image_path=must_1_brain_image_with_prefix(obj,input_prefix)
            
            obj.prefix=input_prefix;
            make_sure_if_directory(obj.init_path);
            the_brain_image_path=get_must_1_brain_image_with_prefix(obj);
        end
        
        
        function the_brain_image_path=first_brain_image_with_prefix(obj,input_prefix)
            obj.prefix=input_prefix;
            make_sure_if_directory(obj.init_path);
            the_brain_image_path=get_1st_brain_image_with_prefix(obj);
        end
        
    end
    
    

end

function make_sure_if_directory(input_path)
    if ~isdir(input_path)
        error('input path must be a directory:%s',input_path);
    end
end






function the_brain_image_path=get_1st_brain_image_with_prefix(obj)
 nii_filelist=dir_4RegExp(obj.init_path,[obj.prefix '*.nii']);
 nii_gz_filelist=dir_4RegExp(obj.init_path,[obj.prefix '*.nii.gz']);
 img_file_list=dir_4RegExp(obj.init_path,[obj.prefix '*.img']);
 
 
 
 if ~isempty(nii_filelist)
     the_brain_image_path=[obj.init_path filesep nii_filelist{1}];
 elseif ~isempty(nii_gz_filelist)
     the_brain_image_path=inpath_Misc([obj.init_path filesep nii_gz_filelist{1}],'GunzipNiigzPath');
 elseif ~isempty(img_file_list)
     the_brain_image_path=[obj.init_path filesep img_file_list{1}];    
 elseif isempty(nii_filelist)...
        &&isempty(nii_gz_filelist)...
        &&isempty(img_file_list)
     error('There is no image file with prefix %s in %s\n',obj.prefix,obj.init_path);
 end    

end



function the_brain_image_path=get_must_1_brain_image_with_prefix(obj)
 nii_filelist=dir_4RegExp(obj.init_path,[obj.prefix '*.nii']);
 nii_gz_filelist=dir_4RegExp(obj.init_path,[obj.prefix '*.nii.gz']);
 img_file_list=dir_4RegExp(obj.init_path,[obj.prefix '*.img']);
 
 if (length(nii_filelist)+length(nii_gz_filelist)+length(img_file_list))...
    >1
    error('more than 1 brain image in this path:%s',obj.init_path);
 end
 
 
 if (~isempty(nii_filelist))&&(1==length(nii_filelist))
     the_brain_image_path=[obj.init_path filesep nii_filelist{1}];
 elseif (~isempty(nii_gz_filelist))&&(1==length(nii_gz_filelist))
     the_brain_image_path=inpath_Misc([obj.init_path filesep nii_gz_filelist{1}],'GunzipNiigzPath');
 elseif (~isempty(img_file_list))&&(1==length(img_file_list))
     the_brain_image_path=[obj.init_path filesep img_file_list{1}];    
 elseif isempty(nii_filelist)...
        &&isempty(nii_gz_filelist)...
        &&isempty(img_file_list)
     error('There is no image file with prefix %s in %s\n',obj.prefix,obj.init_path);
 end            

end

