function pipeline_run_pushbutton_callback(CB_value)

%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150830
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


 handles=CB_value.handles; 
[InputParameter,ProcessQueue,ProcessLog]=get_io_parameter_and_log(handles);
[ParameterLog InputParameter]=get_gui_parameter_and_log(ProcessQueue,InputParameter,handles);



restgui_misc('AutoSavePara','basic',handles); 
restgui_misc('AutoSaveLog','basic',handles,ProcessLog,ParameterLog);



checking_result=call_pipeline_check(ProcessQueue,InputParameter,handles);
if strcmpi(checking_result,'yes')
   call_pipeline_batch(ProcessQueue,InputParameter,handles);
end



end






function [InputParameter,ProcessQueue,ProcessLog]= get_io_parameter_and_log(handles)

StartFunImg=get(handles.UIhandles.StartDirectoryEpiEdit.handle,'string');
StartT1Img=get(handles.UIhandles.StartDirectoryT1Edit.handle,'string');
AnalysisDir=get(handles.UIhandles.WorkDirectoryEdit.handle,'string');



ProcessArray=InitStruct_BasicVersion('ProcessArray',handles);
ProcessStr=ProcessArray(:,1);
FunImgPostfix=ProcessArray(:,3);
T1ImgPostfix=ProcessArray(:,4);

ProcessLogical=cell2mat(ProcessArray(:,2));



ProcessQueue=ProcessStr(logical(ProcessLogical));
FunImgPostfixQueue=FunImgPostfix(logical(ProcessLogical));
T1ImgPostfixQueue=T1ImgPostfix(logical(ProcessLogical));
QueueLength=length(FunImgPostfixQueue);
IOArray=Generate_IOArray(StartFunImg,StartT1Img,FunImgPostfixQueue,T1ImgPostfixQueue,QueueLength);


ProcessLog=cell(QueueLength+1,5);
ProcessLog{1,1}='[PROCESS METHOD]';
ProcessLog{1,2}='[EPI AND OTHER INPUT]';
ProcessLog{1,3}='[EPI AND OTHER OUTPUT]';
ProcessLog{1,4}='[T1 INPUT]';
ProcessLog{1,5}='[T1 OUTPUT]';

InputParameter='';

for i=1:length(ProcessQueue)
    current_operation=ProcessQueue{i};
    [InputParameter IOListOut]=pipeline_get_IOParameters(current_operation,IOArray(i,:),InputParameter,AnalysisDir,handles);
    ProcessLog{i+1,1}=current_operation;
    ProcessLog{i+1,2}=IOListOut{1};
    ProcessLog{i+1,3}=IOListOut{2};
    ProcessLog{i+1,4}=IOListOut{3};
    ProcessLog{i+1,5}=IOListOut{4};    
end
end







function IOArray=Generate_IOArray(StartFunImg,StartT1Img,FunImgPostfixQueue,T1ImgPostfixQueue,QueueLength)
FunIn=1;
FunOut=2;
T1In=3;
T1Out=4;

    IOArray=cell(QueueLength,4);
    IOArray{1,FunIn}=StartFunImg;
    IOArray{1,T1In}=StartT1Img;
    
    for i=1:QueueLength
        if 1==i
            IOArray{i,FunOut}=[IOArray{i,FunIn} FunImgPostfixQueue{i}];
            IOArray{i,T1Out}=[IOArray{i,T1In} T1ImgPostfixQueue{i}];
        else
            IOArray{i,FunIn}=IOArray{i-1,FunOut};
            IOArray{i,T1In}=IOArray{i-1,T1Out};
            IOArray{i,FunOut}=[IOArray{i,FunIn} FunImgPostfixQueue{i}];
            IOArray{i,T1Out}=[IOArray{i,T1In} T1ImgPostfixQueue{i}];
        end
    end
end














