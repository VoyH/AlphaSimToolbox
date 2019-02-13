function call_DicomConvert(InDicomFile, OutSubjectFolder, Option)
% function Call_DicomConvert(InDicomFile, OutSubjectFolder, Option)
% Call Chris Rorden's dcm2nii for different platform as well as for parfor usage. ('eval' is not suitable for 'parfor')
% Input:
% 	InDicomFile	            -   The Input File name. Could be one of the DICOM file
% 	                            or the T1 image want to perfrom reorient and crop
%   OutSubjectFolder        -   The output directory.
% 	Option       	        -   The option for calling dcm2nii. Could be:
%                              'DefaultINI': use dcm2nii.ini under the directory of dcm2nii
%                               Options for dcm2nii: e.g. '-g N -m N -n Y -r Y -v N -x Y': 
% Output:
%	                 -   The NIfTI images or the reoriented and cropped T1 image 
%-----------------------------------------------------------
% Rewritten by Xi-ze Jia 141008.
% Create by Chao-gan Yan

RestPlus_Path=get_Parameters('MainFunctionPath');

OldDirTemp=pwd;
cd([RestPlus_Path,filesep,'dcm2nii']);
if ispc
    if strcmpi(Option,'DefaultINI')
        Option='-b dcm2nii.ini';
    end
    eval(['!dcm2nii.exe ',Option,' -o ',OutSubjectFolder,' ',InDicomFile]);
elseif ismac
    if strcmpi(Option,'DefaultINI')
        Option='-b ./dcm2nii_linux.ini';
    end
    eval(['!./dcm2nii_mac ',Option,' -o ',OutSubjectFolder,' ',InDicomFile]);
else
    if strcmpi(Option,'DefaultINI')
        Option='-b ./dcm2nii_linux.ini';
    end
    eval(['!chmod +x dcm2nii_linux']);
    eval(['!./dcm2nii_linux ',Option,' -o ',OutSubjectFolder,' ',InDicomFile]);
end
cd(OldDirTemp);