function UserP=Init_GUIUserP()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com


UserP.CharSize=0.009;
UserP.TextLength=0.04;

UserP.UIpanel.X=0.03;
UserP.UIpanel.Y=0.58;

UserP.PreDefinedParameterPpmenu.X=0.52;
UserP.PreDefinedParameterPpmenu.Y=0.905;



UserP.VersionBtn.X=0.73;
UserP.VersionBtn.Y=0.95;

UserP.WorkDirectory.X=0.045;
UserP.WorkDirectory.Y=0.95;

UserP.TR.X=0.085;
UserP.TR.Y=0.91;

UserP.TR_A.X=0;
UserP.TR_A.Y=0.9;

UserP.DisplayParticipants.X=0.2;
UserP.DisplayParticipants.Y=UserP.TR.Y;

UserP.StartDirectory.X=0.02;
UserP.StartDirectory.Y=0.87;

TwoColumnGap=0.176;
Xmargin=0.037;

UserP.flexible.two_column_gap=0.29;
%% UserP flexible pipeline
line_number=57;
process_line_number=19;
parameter_line_number=9;
parameter_line_top_margin_index=21;

for i=1:parameter_line_top_margin_index
    UserP.flexible.(['line' num2str(i)]).x=Xmargin;
    UserP.flexible.(['line' num2str(i)]).y=0.95-0.03*(i-1);
end

y_process_end_line=UserP.flexible.(['line' num2str(parameter_line_top_margin_index)]).y;

parameter_line_index=1;
for i=(parameter_line_top_margin_index+1):line_number
    UserP.flexible.(['line' num2str(i)]).x=Xmargin;
    UserP.flexible.(['line' num2str(i)]).y=y_process_end_line-0.05*(parameter_line_index);
    parameter_line_index=parameter_line_index+1;
end

UserP.flexible.work_directory.x=UserP.flexible.line1.x;
UserP.flexible.work_directory.y=UserP.flexible.line1.y;

UserP.flexible.tr.x=UserP.flexible.line1.x+0.47;
UserP.flexible.tr.y=UserP.flexible.line1.y-0.001;

UserP.flexible.parameter_listbox.x=UserP.flexible.line26.x+0.6;
UserP.flexible.parameter_listbox.y=UserP.flexible.line26.y;

UserP.flexible.pushbtn.x=UserP.flexible.line26.x+0.6;
UserP.flexible.pushbtn.y=UserP.flexible.line26.y-0.07;

for i=1:process_line_number
    UserP.flexible.propcess.(['line' num2str(i)]).column1.x=UserP.flexible.(['line' num2str(i+2)]).x;
    UserP.flexible.propcess.(['line' num2str(i)]).column1.y=UserP.flexible.(['line' num2str(i+2)]).y;

    UserP.flexible.propcess.(['line' num2str(i)]).column2.x=UserP.flexible.(['line' num2str(i+2)]).x...
                                                            +UserP.flexible.two_column_gap;
    UserP.flexible.propcess.(['line' num2str(i)]).column2.y=UserP.flexible.(['line' num2str(i+2)]).y;
end


for i=1:parameter_line_number
    UserP.flexible.parameter.(['line' num2str(i)]).column1.x=...
                                UserP.flexible.(['line' num2str(i+parameter_line_top_margin_index)]).x;
    UserP.flexible.parameter.(['line' num2str(i)]).column1.y=...
                              UserP.flexible.(['line' num2str(i+parameter_line_top_margin_index)]).y;

    UserP.flexible.parameter.(['line' num2str(i)]).column2.x=...
                              UserP.flexible.(['line' num2str(i+parameter_line_top_margin_index)]).x...
                                                            +UserP.flexible.two_column_gap;
    UserP.flexible.parameter.(['line' num2str(i)]).column2.y=...
                              UserP.flexible.(['line' num2str(i+parameter_line_top_margin_index)]).y;    
end


%% Pipeline
Preprocess_line=6;
Preprocess_Y_begin=0.73;
for i=1:Preprocess_line
    UserP.Preprocess.(['Line' num2str(i)]).X=Xmargin;
    UserP.Preprocess.(['Line' num2str(i)]).Y=Preprocess_Y_begin-(i-1)*0.033;
    UserP.Preprocess.(['Line' num2str(i)]).Column1.X=UserP.Preprocess.(['Line' num2str(i)]).X;
    UserP.Preprocess.(['Line' num2str(i)]).Column2.X=UserP.Preprocess.(['Line' num2str(i)]).X+TwoColumnGap;
end





UserP.SetMask.X=Xmargin;
UserP.SetMask.Y=0.49;

UserP.Postprocess.Line1.X=Xmargin;
UserP.Postprocess.Line1.Y=0.46;

UserP.Postprocess.Line2.X=Xmargin;
UserP.Postprocess.Line2.Y=0.43;

UserP.Postprocess.Line3.X=Xmargin;
UserP.Postprocess.Line3.Y=0.4;

UserP.pushbutton.X=0.58;
UserP.pushbutton.Y=0.02;

UserP.parameter_listbox.X=0.54;
UserP.parameter_listbox.Y=0.15;


UserP.Parameter.Line1.X=Xmargin;
UserP.Parameter.Line1.Y=0.27;

UserP.Parameter.Line2.X=Xmargin;
UserP.Parameter.Line2.Y=0.23;

UserP.Parameter.Line3.X=Xmargin;
UserP.Parameter.Line3.Y=0.19;

UserP.Parameter.Line4.X=Xmargin;
UserP.Parameter.Line4.Y=0.15;

UserP.Parameter.Line5.X=Xmargin;
UserP.Parameter.Line5.Y=0.11;

UserP.Parameter.Line6.X=Xmargin;
UserP.Parameter.Line6.Y=0.07;

UserP.Parameter.Line7.X=Xmargin;
UserP.Parameter.Line7.Y=0.03;

UserP.Parameter.Line8.X=Xmargin;
UserP.Parameter.Line8.Y=-0.01;
end