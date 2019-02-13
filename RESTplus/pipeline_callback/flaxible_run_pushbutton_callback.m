function flaxible_run_pushbutton_callback(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201507
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com






                                






ProcessQueue=creat_ProcessQueue(handles);
[InputParameter,ProcessLog]=get_io_parameter_and_log(ProcessQueue,handles);
[ParameterLog InputParameter]= get_gui_parameter_and_log(ProcessQueue,InputParameter,handles);

handles.PostProcessMaskfile=0;
 

restgui_misc('AutoSavePara','advance',handles); 
restgui_misc('AutoSaveLog','advance',handles,ProcessLog,ParameterLog);



checking_result=call_pipeline_check(ProcessQueue,InputParameter,handles);
if strcmpi(checking_result,'yes')
   call_pipeline_batch(ProcessQueue,InputParameter,handles);
end


end


function ProcessQueue=creat_ProcessQueue(handles)
VersionStr='advance';    
[ListboxPre,ListboxPost]=restgui_misc('Sort_ListboxStr',VersionStr,handles);
ProcessQueue=[ListboxPre,ListboxPost] ; 
end



function [InputParameter,ProcessLog]=get_io_parameter_and_log(ProcessQueue,handles)

InputParameter='';
AnalysisDir=get(handles.UIhandles.WorkDirectoryEdit.handle,'string');
% Notice the filesep

queue_length=length(ProcessQueue);
ProcessLog=cell(queue_length+1,5);
ProcessLog{1,1}='[PROCESS METHOD]';
ProcessLog{1,2}='[EPI AND OTHER INPUT]';
ProcessLog{1,3}='[EPI AND OTHER OUTPUT]';
ProcessLog{1,4}='[T1 INPUT]';
ProcessLog{1,5}='[T1 OUTPUT]';


IOListOut_ind_FunIn=1;
IOListOut_ind_FunOut=2;
IOListOut_ind_T1In=3;
IOListOut_ind_T1Out=4;


for i=1:length(ProcessQueue)
    current_operation=ProcessQueue{i};
    [InputParameter IOListOut]=flaxible_get_IOParameters(current_operation,InputParameter,AnalysisDir,handles);
    ProcessLog{i+1,1}=current_operation;
    ProcessLog{i+1,2}=IOListOut{IOListOut_ind_FunIn};
    ProcessLog{i+1,3}=IOListOut{IOListOut_ind_FunOut};
    ProcessLog{i+1,4}=IOListOut{IOListOut_ind_T1In};
    ProcessLog{i+1,5}=IOListOut{IOListOut_ind_T1Out};
end


end



