function dirlist=rp_DicomSorter(rawdir,outdir,dicomtype,DirectoryHierarchy)
% FORMAT dirlist=rp_DicomSorter(rawdir,outdir,dicomtype,DirectoryHierarchy)
%   Input:
%     rawdir - directory of source files
%     outdir - directory to store the sorted dir
%     dicomtype - The File name surfix of the DICOM files. e.g. IMA, dcm or none.
%     DirectoryHierarchy - The Hierarchy of Directory: 0 - SubjectName/SeriesName; 1 - SeriesName/SubjectName.
%   Output:
%     *.IMA/*.dcm/*.* - Sorted DICOM images.
%   By YAN Chao-Gan and Dong Zhang-Ye 091212.
%   State Key Laboratory of Cognitive Neuroscience and Learning, Beijing Normal University, China, 100875
%	http://www.restfmri.net
% 	Mail to Authors:  <a href="ycg.yan@gmail.com">YAN Chao-Gan</a>; <a href="dongzy08@gmail.com">DONG Zhang-Ye</a>
%	Version=1.0;
%	Release=20091215;
%   20151203, Jia Xi-Ze fix bug (protocol name, patientID support : and -)
%------------------------------------------------------------------------------------------------------------------------------


if strcmp(dicomtype,'none')
    rawdatatmp=dir([rawdir,filesep,'*']);
    rawdata= rawdatatmp(3:end);
else
    rawdata=dir([rawdir,filesep,'*.',dicomtype]);
end
dirlist={};
for i=1:length(rawdata)
     rp_waitbar(i/length(rawdata), ...
					rawdir, ...
					'DICOM Sorting','Child','NeedCancelBtn');
    dicominfotmp = dicominfo([rawdir,filesep,rawdata(i).name]);
    Indextmp=['0000',int2str(dicominfotmp.SeriesNumber)];
    
 %151203 Jia Xi-Ze      
    PatientID_string=dicominfotmp.PatientID;
    ProtocolName_string=dicominfotmp.ProtocolName;
    if ~isempty(strfind(PatientID_string,':'))||~isempty(strfind(PatientID_string,'-'))
        PatientID_string=strrep(PatientID_string,':','_');
        PatientID_string=strrep(PatientID_string,'-','_');
    end

    if ~isempty(strfind(ProtocolName_string,':'))||~isempty(strfind(ProtocolName_string,'-'))
        ProtocolName_string=strrep(ProtocolName_string,':','_');
        ProtocolName_string=strrep(ProtocolName_string,'-','_');
    end
    
    
    if DirectoryHierarchy==0
        dirname=[outdir,filesep,PatientID_string,filesep,Indextmp(end-3:end),'_',ProtocolName_string];
    else
        dirname=[outdir,filesep,Indextmp(end-3:end),'_',ProtocolName_string,filesep,PatientID_string];
    end
    

    
    if ~isdir(dirname)
        mkdir(dirname);
        dirlist=[dirlist;dirname];
    end
    copyfile([rawdir,filesep,rawdata(i).name],dirname);
end