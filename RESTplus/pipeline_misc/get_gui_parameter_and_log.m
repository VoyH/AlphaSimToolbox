function [ParameterLog InputParameter]= get_gui_parameter_and_log(ProcessQueue,InputParameter,handles)

InputParameter.TR=str2num(get(handles.UIhandles.TREdit.handle,'string'));

    Pindex=1;
    for i=1:length(ProcessQueue)
    [InputParameter PListOut]=get_GUIParameters(ProcessQueue{i},InputParameter,handles);
       ParameterLog{Pindex,1}='**********************';
       Pindex=Pindex+1;
       ParameterLog{Pindex,1}=['[' num2str(i)  ']' '[' ProcessQueue{i} ']'];
       Pindex=Pindex+1;
        for j=1:size(PListOut,1)
            ParameterLog{Pindex,1}=PListOut{j,1};
            ParameterLog{Pindex,2}=PListOut{j,2};
            Pindex=Pindex+1;
        end
    end
end