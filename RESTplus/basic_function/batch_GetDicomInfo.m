function batch_GetDicomInfo(indir,dicominfotxtpath)
% batch_GetDicomInfo(indir,dicominfotxtpath)
% get dicom information
% Input:
%   indir - input directory 
%   dicominfotxtpath - output path for dicom information text.
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201410
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com

subfodrlist=dir_NameList(indir);
fid=fopen(dicominfotxtpath,'a+');
fprintf(fid,['PatientID\tPatientName\tPatientSex\tPatientAge\tStudyDate' ,...
             '\tStudyDescription\tSeriesDescription\tSequenceName\tProtocolName\n\n']);
for i=1:length(subfodrlist)
    subfodrpath=[indir filesep subfodrlist{i}];
    subfilelist=dir_NameList(subfodrpath);
    firstDicomFilePath=[subfodrpath filesep subfilelist{1}];
    dicominfo_struct=dicominfo(firstDicomFilePath);
    
    PatientID=dicominfo_struct.PatientID;   
    PatientName=dicominfo_struct.PatientName;
    PatientSex=dicominfo_struct.PatientSex;
    PatientAge=dicominfo_struct.PatientAge;
    
    StudyDate=dicominfo_struct.StudyDate;
    StudyDescription=dicominfo_struct.StudyDescription;
    SeriesDescription=dicominfo_struct.SeriesDescription;
    if isfield(dicominfo_struct,'SequenceName')
       SequenceName=dicominfo_struct.SequenceName;
    else
       SequenceName='';
    end
    ProtocolName=dicominfo_struct.ProtocolName;
    fprintf(fid,['%s\t%s\t%s\t%s\t%s' ,...
             '\t%s\t%s\t%s\t%s\n'],...
                PatientID,[PatientName.FamilyName PatientName.GivenName],PatientSex,PatientAge,StudyDate,StudyDescription,SeriesDescription,...
                SequenceName,ProtocolName);
end

fclose(fid);

end