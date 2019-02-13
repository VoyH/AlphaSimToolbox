function in3dfile_Normalize_newsegment_dartel_module...
        (in_epi_img,        in_t1img,          in_mean,...
         out_normalized_epi,out_t1_new_segment,out_t1_coregister,...
         parameters)
     
%parameters.bb
%parameters.vox
%parameters.AffineRegularisation='mni';  European brains (mni)
%parameters.AffineRegularisation='eastern'; East Asian brains (eastern)
%Normalize in_epi_img by dartel
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150728
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

t1_new_segment_path=out_t1_new_segment;  
in3dfile_Coregister(in_t1img,in_mean,out_t1_coregister);
in3dfile_NewSegment(out_t1_coregister,t1_new_segment_path,parameters);

[infodr_t1_newsegment, name, ext]=fileparts(t1_new_segment_path);
in3dfile_dartel_creat_templates(infodr_t1_newsegment);
in3dfile_Normalize_dartel(in_epi_img,out_normalized_epi,infodr_t1_newsegment,parameters);

end