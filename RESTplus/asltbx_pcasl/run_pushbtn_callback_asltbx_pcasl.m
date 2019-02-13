function run_pushbtn_callback_asltbx_pcasl(handles)

global paslPC


paslPC.root=get(handles.h_UI.WorkDirectoryEdit,'string');
paslPC.TR=get(handles.h_UI.TREdit,'string');
paslPC.FWHM=get(handles.h_UI.smooth_fwhm_edit,'string');

if 1==get(handles.h_UI.save_4d_image_series.h_radiobtn.yes,'value')
   paslPC.D4Flag=1; %4D default=1
elseif 1==get(handles.h_UI.save_4d_image_series.h_radiobtn.no,'value')
   paslPC.D4Flag=0;  
end



if 1==get(handles.h_UI.magnetic_field.h_radiobtn.mf_1_5T,'value')
   paslPC.MagType=0; 
elseif 1==get(handles.h_UI.magnetic_field.h_radiobtn.mf_3_T,'value')
   paslPC.MagType=1;  %default MagType=1;
elseif 1==get(handles.h_UI.magnetic_field.h_radiobtn.mf_4_T,'value')
   paslPC.MagType=2; 
end



if 1==get(handles.h_UI.first_image_type.h_radiobtn.lable,'value')
   paslPC.FirstimageType=0; % 0 lable first  default FristimageType=0
elseif 1==get(handles.h_UI.first_image_type.h_radiobtn.control,'value')
   paslPC.FirstimageType=1;  % 1 control first
end



%SubtractionType
%PAR.SubtractionType=0;      % 0: simple subtraction, 1: surround subtraction, 2: sinc subtraction
if 1==get(handles.h_UI.subtraction_method.h_radiobtn.simple,'value')
   paslPC.SubtractionType=0; %default SubtractionType=0
elseif 1==get(handles.h_UI.subtraction_method.h_radiobtn.surround,'value')
   paslPC.SubtractionType=1;
elseif 1==get(handles.h_UI.subtraction_method.h_radiobtn.sinc,'value')
   paslPC.SubtractionType=2;    
end




%SubtractionOrder
%PAR.SubtractionOrder=1;     % 0: label - control, 1: control - label
if 1==get(handles.h_UI.subtraction_order.h_radiobtn.lable_control,'value')
   paslPC.SubtractionOrder=0; 
elseif 1==get(handles.h_UI.subtraction_order.h_radiobtn.control_lable,'value')
   paslPC.SubtractionOrder=1;  %default SubtractionOrder=1
end





%MaskFlag
%PAR.MaskFlag=1;    % Flag #1, 1 means masking out images using an implicit or explicit mask image
if 1==get(handles.h_UI.apply_the_mask.h_radiobtn.use_mask,'value')
   paslPC.MaskFlag=1;  %default=1
elseif 1==get(handles.h_UI.apply_the_mask.h_radiobtn.not_use_mask,'value')
   paslPC.MaskFlag=0;  
end




%OutPerfFlag
%PAR.OutPerfFlag=0; % Flag #5, 1 means saving the perfusion difference images (the perfusion weighted images)
if 1==get(handles.h_UI.save_delta_M.h_radiobtn.yes_save_delta ,'value')
   paslPC.OutPerfFlag=1; 
elseif 1==get(handles.h_UI.save_delta_M.h_radiobtn.no_save_delta,'value')
   paslPC.OutPerfFlag=0;  %default OutPerFlag=0;
end


%additional_M0
 % 0 means no. In CASL pCASL, if additional M0 is acquired, you can use it, otherwise the control image will be used.
% 1 means using additional M0 map. The M0 map should be saved in the same folder as in the ASL rawdata and should be named by "M0.nii"
if 1==get(handles.h_UI.additional_M0.h_radiobtn.yes_M0 ,'value')
   paslPC.additionalM0=1; 
elseif 1==get(handles.h_UI.additional_M0.h_radiobtn.no_M0,'value')
   paslPC.additionalM0=0;  %default=0
end




%Labeltime
%PAR.Labeltime = 0.7; % labeling time in secs. For PASL, this parameter is for passing the TI1. If it is >1, this value will be disabled.
paslPC.Labeltime=str2double(get(handles.h_UI.lable_time_edit,'string'));
%default Labletime=1.48


%Delaytime
%PAR.Delaytime = 1.5; % post labeling delay time. For QUIPSS, this should be set to TI2-TI1. 
paslPC.Delaytime=str2double(get(handles.h_UI.post_labeling_delay_edit,'string'));
%default Delaytime =1.5

%slicetime
%PAR.slicetime =40;   % slice acquisition time in msec.  Refer to the manual for how to calculate it.
paslPC.slicetime=str2double(get(handles.h_UI.slice_acquisition_time_edit,'string'));
%default 33.5


%TE
%PAR.TE = 17;         % in msecs
paslPC.TE=str2double(get(handles.h_UI.TE_for_M0_acquisition_edit,'string'));
%default TE=11;


%Labeff
%PAR.Labeff   = 0.9;  % label efficiency
paslPC.Labeff=str2double(get(handles.h_UI.labele_efficiency_edit,'string'));
% default 0.85
which batch_run
batch_run;


end