function generate_Pic4Chek(EpiImageIn,PicResultNam) 
% ResultPicFolder='/Users/jiaxize/datatest/Result/PicturesForChkNormalization'

% inpath_Misc(ResultPicFolder,'MakeCurrentDir');
% cd(ResultPicFolder);

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



    inpath_Misc(PicResultNam,'MakeParentDir');
    ResultPath=inpath_Misc(PicResultNam,'GetParentPath');
    ResultNam=inpath_Misc(PicResultNam,'GetPathName');

    if license('test','image_toolbox')
       global output_BrainPicture_Cfg; 
       BrainPictureHandle=output_BrainPicture;
       Ch2Filename=[get_Parameters('TemplatePath') filesep get_Parameters('Ch2FileName')];
       set(output_BrainPicture_Cfg.Config(1).hOverlayFile, 'String', Ch2Filename);
       output_BrainPicture_Cfg.Config(1).Overlay.Opacity=0.2;
       output_BrainPicture('ChangeOverlay', BrainPictureHandle);
       TempImage4Chek =fullfile(tempdir,['Img4Chek','_',rp_misc('GetCurrentUser'),'.img']);
       NewVoxSize=[1 1 1];
       InterpolationMethod_NearestNeighbour=0; 
       reslice_Image(EpiImageIn,TempImage4Chek,NewVoxSize,InterpolationMethod_NearestNeighbour);
       set(output_BrainPicture_Cfg.Config(1).hUnderlayFile, 'String', TempImage4Chek);
       set(output_BrainPicture_Cfg.Config(1).hMagnify ,'Value',2);
       output_BrainPicture('ChangeUnderlay', BrainPictureHandle);

       eval(['print(''-dtiff'',''-r100'',''',ResultPath,filesep,ResultNam,'.tif'',BrainPictureHandle);']);
       fprintf(['Generating the pictures for checking: ',ResultPath,filesep,ResultNam,'.tif',' OK\n']); 

       close(BrainPictureHandle);
    else  
        fprintf('Since Image Processing Toolbox of MATLAB is not valid, the pictures for checking will not be generated.\n');
        fid = fopen('Warning.txt','at+');
        fprintf(fid,'%s','Since Image Processing Toolbox of MATLAB is not valid, the pictures for checking  will not be generated.\n');
        fclose(fid);
    end
end