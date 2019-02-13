function varargout = NIStatES(varargin)
%   varargout = es(varargin)
%   Two sample t-test or Paired t-test selection GUI.
%   By Li Xun.
%   Center for Cognition and Brain Disorders, Hangzhou Normal University, 310015
%	http://www.restfmri.net
% 	Mail to Authors: lixun2011@126.com
%	Version=1.0;
%	Release=20140814;
%--------------------------------------------------------------------------
% ES MATLAB code for es.fig
%      ES, by itself, creates a new ES or raises the existing
%      singleton*.
%
%      H = ES returns the handle to a new ES or the handle to
%      the existing singleton*.
%
%      ES('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ES.M with the given input arguments.
%
%      ES('Property','Value',...) creates a new ES or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before es_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to es_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help es

% Last Modified by GUIDE v2.5 14-May-2015 14:40:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @es_OpeningFcn, ...
                   'gui_OutputFcn',  @es_OutputFcn, ...
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


% --- Executes just before es is made visible.
function es_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to es (see VARARGIN)

% Choose default command line output for es
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes es wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = es_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Viewer.
function Viewer_Callback(hObject, eventdata, handles)
% hObject    handle to Viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
es_sliceviewer();

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Viewer.
function Viewer_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function Viewer_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object deletion, before destroying properties.
function Viewer_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to Viewer (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in Calculator.
function Calculator_Callback(hObject, eventdata, handles)
% hObject    handle to Calculator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Calculator_gui;

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over Calculator.
function Calculator_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to Calculator (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when figure1 is resized.
function figure1_ResizeFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
