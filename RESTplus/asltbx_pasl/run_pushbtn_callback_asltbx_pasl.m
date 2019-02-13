function run_pushbtn_callback_asltbx_pasl(handles)

global paslP


paslP.root=get(handles.h_UI.WorkDirectoryEdit,'string');
paslP.TR=get(handles.h_UI.TREdit,'string');
paslP.FWHM=get(handles.h_UI.smooth_fwhm_edit,'string');

if 1==get(handles.h_UI.save_4d_image_series.h_radiobtn.yes,'value')
   paslP.D4Flag=1; %4D
elseif 1==get(handles.h_UI.save_4d_image_series.h_radiobtn.no,'value')
   paslP.D4Flag=0;  
end



if 1==get(handles.h_UI.magnetic_field.h_radiobtn.mf_1_5T,'value')
   paslP.MagType=0; 
elseif 1==get(handles.h_UI.magnetic_field.h_radiobtn.mf_3_T,'value')
   paslP.MagType=1;  
elseif 1==get(handles.h_UI.magnetic_field.h_radiobtn.mf_4_T,'value')
   paslP.MagType=2; 
end



if 1==get(handles.h_UI.first_image_type.h_radiobtn.lable,'value')
   paslP.FirstimageType=0; % 0 lable first 
elseif 1==get(handles.h_UI.first_image_type.h_radiobtn.control,'value')
   paslP.FirstimageType=1;  % 1 control first
end



%SubtractionType
%PAR.SubtractionType=0;      % 0: simple subtraction, 1: surround subtraction, 2: sinc subtraction
if 1==get(handles.h_UI.subtraction_method.h_radiobtn.simple,'value')
   paslP.SubtractionType=0; 
elseif 1==get(handles.h_UI.subtraction_method.h_radiobtn.surround,'value')
   paslP.SubtractionType=1;
elseif 1==get(handles.h_UI.subtraction_method.h_radiobtn.sinc,'value')
   paslP.SubtractionType=2;    
end




%SubtractionOrder
%PAR.SubtractionOrder=1;     % 0: label - control, 1: control - label
if 1==get(handles.h_UI.subtraction_order.h_radiobtn.lable_control,'value')
   paslP.SubtractionOrder=0; 
elseif 1==get(handles.h_UI.subtraction_order.h_radiobtn.control_lable,'value')
   paslP.SubtractionOrder=1;  
end





%MaskFlag
%PAR.MaskFlag=1;    % Flag #1, 1 means masking out images using an implicit or explicit mask image
if 1==get(handles.h_UI.apply_the_mask.h_radiobtn.use_mask,'value')
   paslP.MaskFlag=1; 
elseif 1==get(handles.h_UI.apply_the_mask.h_radiobtn.not_use_mask,'value')
   paslP.MaskFlag=0;  
end




%OutPerfFlag
%PAR.OutPerfFlag=0; % Flag #5, 1 means saving the perfusion difference images (the perfusion weighted images)
if 1==get(handles.h_UI.save_delta_M.h_radiobtn.yes_save_delta ,'value')
   paslP.OutPerfFlag=1; 
elseif 1==get(handles.h_UI.save_delta_M.h_radiobtn.no_save_delta,'value')
   paslP.OutPerfFlag=0;  
end


%Labeltime
%PAR.Labeltime = 0.7; % labeling time in secs. For PASL, this parameter is for passing the TI1. If it is >1, this value will be disabled.
paslP.Labeltime=str2double(get(handles.h_UI.lable_time_edit,'string'));



%Delaytime
%PAR.Delaytime = 1.5; % post labeling delay time. For QUIPSS, this should be set to TI2-TI1. 
paslP.Delaytime=str2double(get(handles.h_UI.post_labeling_delay_edit,'string'));

%slicetime
%PAR.slicetime =40;   % slice acquisition time in msec.  Refer to the manual for how to calculate it.
paslP.slicetime=str2double(get(handles.h_UI.slice_acquisition_time_edit,'string'));



%TE
%PAR.TE = 17;         % in msecs
paslP.TE=str2double(get(handles.h_UI.TE_for_M0_acquisition_edit,'string'));


%Labeff
%PAR.Labeff   = 0.9;  % label efficiency
paslP.Labeff=str2double(get(handles.h_UI.labele_efficiency_edit,'string'));

which batch_run
batch_run;


end