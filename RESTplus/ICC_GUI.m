function varargout = ICC_GUI(varargin)
% ICC_GUI MATLAB code for ICC_GUI.fig
%      ICC_GUI, by itself, creates a new ICC_GUI or raises the existing
%      singleton*.
%
%      H = ICC_GUI returns the handle to a new ICC_GUI or the handle to
%      the existing singleton*.
%
%      ICC_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ICC_GUI.M with the given input arguments.
%
%      ICC_GUI('Property','Value',...) creates a new ICC_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ICC_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ICC_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ICC_GUI

% Last Modified by GUIDE v2.5 08-Mar-2015 15:28:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ICC_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ICC_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before ICC_GUI is made visible.
function ICC_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ICC_GUI (see VARARGIN)

% Choose default command line output for ICC_GUI
handles.output = hObject;
movegui(handles.figure1,'center');
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ICC_GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ICC_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function InPutDirTextbox_Callback(hObject, eventdata, handles)
% hObject    handle to InPutDirTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InPutDirTextbox as text
%        str2double(get(hObject,'String')) returns contents of InPutDirTextbox as a double


% --- Executes during object creation, after setting all properties.
function InPutDirTextbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InPutDirTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SelectInputdir.
function SelectInputdir_Callback(hObject, eventdata, handles)
% hObject    handle to SelectInputdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
foldername=uigetdir(pwd,'Please select input directory');
set(handles.InPutDirTextbox,'String',foldername);
subfolderlist=dir_NameList(foldername);
listboxstr='';
for i=1:length(subfolderlist)
    if isempty(listboxstr)
        listboxstr=subfolderlist{i};
    else
        listboxstr=[listboxstr '|' subfolderlist{i}];
    end
end
set(handles.SubFoldrListbox,'String',listboxstr);


% --- Executes on selection change in SubFoldrListbox.
function SubFoldrListbox_Callback(hObject, eventdata, handles)
% hObject    handle to SubFoldrListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SubFoldrListbox contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SubFoldrListbox


% --- Executes during object creation, after setting all properties.
function SubFoldrListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SubFoldrListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in DefaultMask.
function DefaultMask_Callback(hObject, eventdata, handles)
% hObject    handle to DefaultMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DefaultMask
set(handles.DefaultMask,'value',1);
set(handles.UserdefinedMask,'value',0);
set(handles.NoMask,'value',0);
set(handles.UserdefinedMaskTextbox,'Enable','off');
set(handles.SelctUserdefinedMask,'Enable','off');

% --- Executes on button press in NoMask.
function NoMask_Callback(hObject, eventdata, handles)
% hObject    handle to NoMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of NoMask
set(handles.DefaultMask,'value',0);
set(handles.UserdefinedMask,'value',0);
set(handles.NoMask,'value',1);
set(handles.UserdefinedMaskTextbox,'Enable','off');
set(handles.SelctUserdefinedMask,'Enable','off');

% --- Executes on button press in UserdefinedMask.
function UserdefinedMask_Callback(hObject, eventdata, handles)
% hObject    handle to UserdefinedMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of UserdefinedMask
set(handles.DefaultMask,'value',0);
set(handles.UserdefinedMask,'value',1);
set(handles.NoMask,'value',0);
set(handles.UserdefinedMaskTextbox,'Enable','on');
set(handles.SelctUserdefinedMask,'Enable','on');

function UserdefinedMaskTextbox_Callback(hObject, eventdata, handles)
% hObject    handle to UserdefinedMaskTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of UserdefinedMaskTextbox as text
%        str2double(get(hObject,'String')) returns contents of UserdefinedMaskTextbox as a double


% --- Executes during object creation, after setting all properties.
function UserdefinedMaskTextbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to UserdefinedMaskTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ChooseUserMask.
function ChooseUserMask_Callback(hObject, eventdata, handles)
% hObject    handle to ChooseUserMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function OutputDirTextbox_Callback(hObject, eventdata, handles)
% hObject    handle to OutputDirTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of OutputDirTextbox as text
%        str2double(get(hObject,'String')) returns contents of OutputDirTextbox as a double


% --- Executes during object creation, after setting all properties.
function OutputDirTextbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to OutputDirTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SelectOutputdir.
function SelectOutputdir_Callback(hObject, eventdata, handles)
% hObject    handle to SelectOutputdir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
foldername=uigetdir(pwd,'Please select output directory');
set(handles.OutputDirTextbox,'String',foldername);



% --- Executes during object deletion, before destroying properties.
function UserdefinedMaskTextbox_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to UserdefinedMaskTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in SelctUserdefinedMask.
function SelctUserdefinedMask_Callback(hObject, eventdata, handles)
% hObject    handle to SelctUserdefinedMask (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,PathName,FilterIndex] =uigetfile('*.nii;*.img;*.hdr','MATLAB Files (*.nii;*.img;*.hdr)','Please select mask file');
set(handles.UserdefinedMaskTextbox,'String',[PathName filesep FileName]);


% --- Executes on button press in RUN.
function RUN_Callback(hObject, eventdata, handles)
% hObject    handle to RUN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.RUN,'BackgroundColor','r');
set(handles.RUN,'Enable','off')
IsDefaultMask=get(handles.DefaultMask,'value');
IsNoMask=get(handles.NoMask,'value');
IsUserdefinedMask=get(handles.UserdefinedMask,'value');
UserdefinedMask=get(handles.UserdefinedMaskTextbox,'String');

InPutDir=get(handles.InPutDirTextbox,'String');
OutputDir=get(handles.OutputDirTextbox,'String');
[pathstr, name, ext]=fileparts(InPutDir);


SubfolderList=dir_NameList(InPutDir);
ICC_input='';
for i=1:length(SubfolderList)
    ICC_input{i}=[InPutDir filesep SubfolderList{i}];
    SubfileList=dir_NameList([InPutDir filesep SubfolderList{i}]);    
    MaskPath=loadthemask(IsDefaultMask,IsNoMask,IsUserdefinedMask,UserdefinedMask,[InPutDir filesep SubfolderList{i} filesep SubfileList{1}]);
end
 InFodr_ICC(ICC_input,[OutputDir filesep 'ICC_' name '.nii'],MaskPath);
 set(handles.RUN,'Enable','on','BackgroundColor',[0.9 0.9 0.9]);

function MaskPath=loadthemask(IsDefaultMask,IsNoMask,IsUserdefinedMask,UserdefinedMask,Infile)
[Outdata,VoxDim,Header]=rp_readfile(Infile);
if IsDefaultMask==1
%     PerAFPath=which('ICC_GUI.m');
%     MaskPath=[PerAFPath filesep 'mask' filesep 'BrainMask_05_' num2str(size(Outdata,1)) 'x' num2str(size(Outdata,2)) 'x' num2str(size(Outdata,3)) 'x'  ...
%               '.hdr'];
    MaskPath=1;
elseif IsNoMask==1
    MaskPath='';
elseif IsUserdefinedMask==1;
    MaskPath=UserdefinedMask;
end
