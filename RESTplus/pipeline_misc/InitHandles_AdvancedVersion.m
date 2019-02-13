function handles=InitHandles_AdvancedVersion(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



handles.runstring.Preprocesstype={  get_RunStr('DicomToNifti');
                                    get_RunStr('EpiDicomtoNifti');
                                    get_RunStr('T1DicomToNifti');
                                    get_RunStr('RemoveFirstTimePoints');
                                    get_RunStr('SliceTiming');
                                    get_RunStr('Realign');
                                    get_RunStr('Reorient');
                                    get_RunStr('ReorientFunBeforeCoreg');
                                    get_RunStr('ReorientT1BeforeCoreg');
                                    get_RunStr('ReorientT1AfterCoreg');
                                    get_RunStr('Normalize');
                                    get_RunStr('NormalizeEpi');
                                    get_RunStr('NormalizeNewSeg_dartel');
                                    get_RunStr('T1CoregisterFun');
                                    get_RunStr('T1Segment');
                                    get_RunStr('NormalizeSeg');
                                    get_RunStr('Smooth');
                                    get_RunStr('Detrend');
                                    get_RunStr('Filter');
                                    get_RunStr('RegressOutCovariates');
                };

handles.runstring.Postprocesstype={  get_RunStr('Alff');
                                     get_RunStr('fALFF');
                                     get_RunStr('KccReHo');
                                     get_RunStr('CoHeReHo');
                                     get_RunStr('FunctionalConnectivity');
                                     get_RunStr('VMHC');
                                     get_RunStr('PerAF');
                                     get_RunStr('DegreeCentrality');
                                     get_RunStr('GCA')};

%%  AllUIhandles
obj___handles_UIhandles_struct=struct_operation(handles.UIhandles);
handles.AllUIhandles=obj___handles_UIhandles_struct.spread_to_number_array___all_subfield_value;
     
                                                                                   
%%                        
  handles.RadioBtnArray.SetMask=[handles.UIhandles.DefaultmaskRadioBtn.handle;
                                  handles.UIhandles.NoMaskRadioBtn.handle;
                                  handles.UIhandles.UserDefinedMaskRadioBtn.handle];

%% Version radio button
handles.VersionRadioBtn.Array=[handles.UIhandles.BasicVersionRadioBtn.handle;
                               handles.UIhandles.AdvancedVersionRadioBtn.handle];
%% hParaArray
all___hPara_fieldnames=fieldnames(handles.hPara);
for i=1:length(all___hPara_fieldnames)       
    obj___handles_hPara_struct=struct_operation(handles.hPara.(all___hPara_fieldnames{i}));
    handles.hParaArray.(all___hPara_fieldnames{i})=...
                        obj___handles_hPara_struct.spread_to_number_array___all_subfield_value;    
end

%% hParaAll
obj___handles_hParaArray_struct=struct_operation(handles.hParaArray);
handles.hParaAll=obj___handles_hParaArray_struct.spread_to_number_array___all_subfield_value;

end

