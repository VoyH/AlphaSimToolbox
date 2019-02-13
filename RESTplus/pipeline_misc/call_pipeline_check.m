function checking_result=call_pipeline_check(ProcessQueue,InputParameter,handles)




all_output_folder='||';

try
   h = waitbar(0,'Checking, please wait...'); 
   for i=1:length(ProcessQueue) 
       waitbar(i / length(ProcessQueue));   
       all_output_folder=pipeline_parameters_check(ProcessQueue{i},InputParameter,all_output_folder);
   end
   close(h);
   checking_result='yes';
catch ME
    warning(ME.identifier,ME.message);
    checking_result='no';
    close(h);
%     rethrow(ME);
end




end