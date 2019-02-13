function rp_Inverse_GUI()
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150720
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles=Init_handles();

   
% Input|Output GUI module
InputGUI_celllist={'No1_ModuleName','ApplyTo',...
                   'No1_TextString','Apply to:',...
                   'No1_Yposition','390',...
                   'No1_IfDrawListbox','yes',...
                   'No2_ModuleName','BasedImage',...
                   'No2_TextString','Reference image:',...
                   'No2_Yposition','230',...
                   'No3_ModuleName','ImportedSnMat',...
                   'No3_TextString','Imported_sn.mat:',...
                   'No3_Yposition','190',...
                   'No4_ModuleName','OutputDir',...
                   'No4_TextString','Output directory:',...
                   'No4_Yposition','130',...
                   };
               
handles=Creat_RadiobtnGUI(handles);

InputGUI_Amount=4;
for i=1:InputGUI_Amount
    Mvalue=InitMvalue(i,InputGUI_celllist);
    handles=CreatInputGuiModule(Mvalue,handles);
end

handles=Creat_MatRegExpGUI(handles);
% Run module
handles=CreatRunGuiModule(handles);
restgui_misc('SetToolbarCorssBtn',...
              handles.theFig,handles.RunBtn,handles.DefaultColorBackground)

movegui(handles.theFig, 'center');                
set(handles.theFig,'visible','on');
    
    

end

function handles=Init_handles()
handles.offsetup=35;
handles.DefaultColorBackground=[240/250,240/250,240/250];
handles.DefaultFontName='fixedwidth';
handles.AFontSpace=8;
handles.Module_Width=510;

TheFontSize.Mac=14;
TheFontSize.PC=10;
TheFontSize.Other=10;
handles.DefaultFontSize=restgui_misc('FontsizeCompatibility',TheFontSize);




DefaultColorBackground=handles.DefaultColorBackground;
DefaultFontName=handles.DefaultFontName;

handles.theFig =figure('Units', 'pixel',...
                  'Toolbar', 'none',...
                  'MenuBar', 'none', ...
			      'NumberTitle', 'off',...
                  'Visible', 'off', ...					
			      'Name', 'Deformation-> Inverse-> Imported_sn.mat', ...
			      'Position', [0,0,600, 515],...
                  'Resize','off',...
                  'Color', DefaultColorBackground);
                       
handles.TitleText =  uicontrol(handles.theFig,'Style','text',...
                                'Position',[130 460 350 30],...
                                'String','Inverse into original space',...
                                'FontSize',20,...
                                'FontWeight','Bold',...
                                'BackgroundColor',DefaultColorBackground,...
                                'fontname',DefaultFontName); 

                            
                            

end


function handles= Creat_RadiobtnGUI(handles)
offsetup=handles.offsetup;
DefaultColorBackground=handles.DefaultColorBackground;
DefaultFontName=handles.DefaultFontName;
DefaultFontSize=handles.DefaultFontSize;
AFontSpace=handles.AFontSpace;

Radiobtn_Space=23.5;
Radiobtn_height=20;

batch_radiobtn_string='group';
batch_radiobtn_width=length(batch_radiobtn_string)*AFontSpace+Radiobtn_Space;
batch_radiobtn_Y=435;

handles.batch_radiobtn =  uicontrol(handles.theFig,...
                                  'Style','radiobutton',...
                                  'Position',[offsetup batch_radiobtn_Y batch_radiobtn_width Radiobtn_height],...
                                  'String',batch_radiobtn_string,...
                                  'FontSize',DefaultFontSize,...
                                  'FontWeight','bold',...
                                  'tag','batch_radiobtn',...
                                  'value',1,...
                                  'BackgroundColor',DefaultColorBackground,...
                                  'fontname',DefaultFontName);

 
batch_radiobtn_string='individual';
batch_radiobtn_width=length(batch_radiobtn_string)*AFontSpace+Radiobtn_Space;                              
handles.individual_radiobtn =  uicontrol(handles.theFig,...
                                  'Style','radiobutton',...
                                  'Position',[1.3*offsetup+batch_radiobtn_width batch_radiobtn_Y batch_radiobtn_width Radiobtn_height],...
                                  'String',batch_radiobtn_string,...
                                  'FontSize',DefaultFontSize,...
                                  'FontWeight','bold',...
                                  'tag','individual_radiobtn',...
                                  'BackgroundColor',DefaultColorBackground,...
                                  'fontname',DefaultFontName);
                              

set(handles.batch_radiobtn,'callback',{@selectradiobutton_Callback}); 
set(handles.individual_radiobtn,'callback',{@selectradiobutton_Callback}); 
guidata(gcf,handles);                           
end


function selectradiobutton_Callback(hObject, eventdata)
handles=guidata(hObject);
HandlesArray=[handles.batch_radiobtn,handles.individual_radiobtn];
RadioBtnSet(HandlesArray,hObject);

if strcmpi(get(hObject,'tag'),'batch_radiobtn')    
   set(handles.ApplyToListbox,'enable','on','BackgroundColor',[1 1 1]); 
   set(handles.MatRegExpEdit,'enable','on','BackgroundColor',[1 1 1],'string','*seg_sn.mat');
   clear_editbox();
elseif strcmpi(get(hObject,'tag'),'individual_radiobtn')
   set(handles.ApplyToListbox,'enable','off','BackgroundColor',handles.DefaultColorBackground,'string','');  
   set(handles.MatRegExpEdit,'enable','off','BackgroundColor',handles.DefaultColorBackground,'string',''); 
   clear_editbox();
else
    error('selectradiobutton_Callback');
end
end


function clear_editbox()
handles=guidata(gcf);
set(handles.ApplyToEdit,'string','');
set(handles.BasedImageEdit,'string','');
set(handles.ImportedSnMatEdit,'string','');

end

function Mvalue=InitMvalue(TheNo,InputGUI_celllist)
    Mvalue='';
    for i=1:2:length(InputGUI_celllist)
        CurrentCell=InputGUI_celllist{i};
        if strncmpi(CurrentCell,['No' num2str(TheNo)],3)
           Mvalue.(CurrentCell(5:end))=InputGUI_celllist{i+1}; 
        end
    end
end




function handles=CreatInputGuiModule(Mvalue,handles)

if ~isfield(Mvalue,'IfDrawListbox')
    IfDrawListbox='No';
elseif isfield(Mvalue,'IfDrawListbox')
    IfDrawListbox=Mvalue.IfDrawListbox;
end

ModuleName=Mvalue.ModuleName;
TextString=Mvalue.TextString;
Yposition=str2num(Mvalue.Yposition);


offsetup=handles.offsetup;
DefaultColorBackground=handles.DefaultColorBackground;
DefaultFontName=handles.DefaultFontName;
DefaultFontSize=handles.DefaultFontSize;
AFontSpace=handles.AFontSpace;

WholeModule_Width=handles.Module_Width;
ModuleBtn_Width=45;

ModuleText_Width=length(TextString)*AFontSpace;
handles.([ModuleName 'Text']) =  uicontrol(handles.theFig,...
                                          'Style','text',...
                                          'Position',[offsetup Yposition ModuleText_Width 20],...
                                          'String',TextString,...
                                          'FontSize',DefaultFontSize,...
                                          'FontWeight','bold',...
                                          'tag',[ModuleName 'Text'],...
                                          'BackgroundColor',DefaultColorBackground,...
                                          'fontname',DefaultFontName);   
        
        
ModuleEdit_X=1.3*offsetup+ModuleText_Width;  
ModuleEdit_Y=Yposition-3;
ModuleEdit_Width=WholeModule_Width-ModuleBtn_Width-ModuleText_Width;
handles.([ModuleName 'Edit']) =  uicontrol(handles.theFig,'Style','edit',...
                            'Position',[ModuleEdit_X ModuleEdit_Y ModuleEdit_Width  28],...
                            'FontSize',DefaultFontSize,...
                            'FontWeight','Bold',...
                            'tag',[ModuleName 'Edit'],...
                            'BackgroundColor',[1 1 1],...
                            'fontname',DefaultFontName);         
        
    
                        
ModuleBtn_X=1.5*offsetup+ModuleText_Width+ModuleEdit_Width;  
handles.([ModuleName 'Btn']) =  uicontrol(handles.theFig,'Style','pushbutton',...
                            'Position',[ModuleBtn_X Yposition-4 ModuleBtn_Width 29],...
                            'String','...',...
                            'FontSize',DefaultFontSize,...
                            'FontWeight','Bold',...
                            'tag',[ModuleName 'Btn'],...
                            'BackgroundColor',DefaultColorBackground,...
                            'fontname',DefaultFontName);   
                        
                        
if strcmpi(IfDrawListbox,'Yes')
    ModuleListbox_Height=100;    
    ModuleListbox_Y=ModuleEdit_Y-ModuleListbox_Height-offsetup*0.2;     
    handles.([ModuleName 'Listbox']) =  uicontrol(handles.theFig,'Style','listbox',...
                                'Position',[ModuleEdit_X ModuleListbox_Y ModuleEdit_Width ModuleListbox_Height],...
                                'FontSize',DefaultFontSize,...
                                'FontWeight','Bold',...
                                'tag',[ModuleName 'Listbox'],...
                                'BackgroundColor',[1 1 1],...
                                'fontname',DefaultFontName);     
end

 set(handles.([ModuleName 'Btn']),'callback',{@InputGuiModule_Callback,IfDrawListbox});
 guidata(gcf,handles);
end


function InputGuiModule_Callback(hObject, eventdata,IfDrawListbox)
handles=guidata(gcf);
TagString=get(hObject,'tag');
if 0==get(handles.batch_radiobtn,'value')&&(~strcmpi(get(hObject,'tag'),'OutputDirBtn'))
   [FileName,PathName,FilterIndex]=uigetfile({'*.img;*.nii;*.hdr;*.mat'},'please select your image file');    
   thepath=[PathName FileName];    
else
   thepath=uigetdir(pwd);
   if 0~=thepath
      cd(thepath);
   end
   
end
if 0~=thepath
   set(handles.([TagString(1:end-3) 'Edit']),'string',thepath);  
   if strcmpi(IfDrawListbox,'yes')&&(1==get(handles.batch_radiobtn,'value'))
       sublist=dir_NameList(thepath);
       ListboxString=brief_misc('CellArray2Listboxstr',sublist);
       set(handles.([TagString(1:end-3) 'Listbox']),'string',ListboxString);  
   end
end
guidata(hObject,handles);
end

function handles=Creat_MatRegExpGUI(handles)
RegExp_Module_Width=handles.Module_Width;                            
TextString='Regular expression for mat file:';                            
MatRegExpText_Width=length(TextString)*handles.AFontSpace;
handles.MatRegExpText=uicontrol(handles.theFig,...
                                          'Style','text',...
                                          'Position',[handles.offsetup 160 MatRegExpText_Width 20],...
                                          'String',TextString,...
                                          'FontSize',handles.DefaultFontSize,...
                                          'FontWeight','bold',...
                                          'tag','MatRegExpText',...
                                          'BackgroundColor',handles.DefaultColorBackground,...
                                          'fontname',handles.DefaultFontName);    

MatRegExpEdit_X=1.3*handles.offsetup+MatRegExpText_Width;     
MatRegExpEdit_Width=RegExp_Module_Width-MatRegExpEdit_X;

handles.MatRegExpEdit=uicontrol(handles.theFig,...
                                          'Style','edit',...
                                          'Position',[MatRegExpEdit_X 157 MatRegExpEdit_Width 28],...
                                          'String','*seg_sn.mat',...
                                          'FontSize',handles.DefaultFontSize,...
                                          'FontWeight','bold',...
                                          'tag','MatRegExpEdit',...
                                          'BackgroundColor',[1 1 1],...
                                          'fontname',handles.DefaultFontName);  
                                      
guidata(gcf,handles);

end




function handles=CreatRunGuiModule(handles)
DefaultColorBackground=handles.DefaultColorBackground;
DefaultFontName=handles.DefaultFontName;

handles.RunBtn =  uicontrol(handles.theFig,'Style','pushbutton',...
                                            'Position',[395 45 150 50],...
                                            'String','RUN',...
                                            'FontSize',35,...
                                            'FontWeight','Bold',...
                                            'BackgroundColor',DefaultColorBackground,...
                                            'fontname',DefaultFontName);
                                        
                                        
set(handles.RunBtn,'callback',{@RunGuiModule_Callback}); 

end


function RunGuiModule_Callback(hObject, eventdata)
handles=guidata(gcf);
input_AppliedImages=get(handles.ApplyToEdit,'string');
input_ImportedSnMat=get(handles.ImportedSnMatEdit,'string');
input_BasedImage=get(handles.BasedImageEdit,'string');
output_path=get(handles.OutputDirEdit,'string');
set(hObject,'enable','off','BackgroundColor','r');

if 1==get(handles.batch_radiobtn,'value')
     snmat_RegExp=get(handles.MatRegExpEdit,'string');
     indir_DeformationInverse(input_BasedImage,input_ImportedSnMat,input_AppliedImages,snmat_RegExp,output_path);
else
     infile_DeformationInverse(input_BasedImage,input_ImportedSnMat,input_AppliedImages,output_path);
end

set(hObject,'enable','on','BackgroundColor',handles.DefaultColorBackground);
end



