function varargout = repipl(varargin)
% repipl MATLAB code for repipl.fig
%      repipl, by itself, creates a new repipl or raises the existing
%      singleton*.
%
%      H = repipl returns the handle to a new repipl or the handle to
%      the existing singleton*.
%
%      repipl('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in repipl.M with the given input arguments.
%
%      repipl('Property','Value',...) creates a new repipl or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before repipl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to repipl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help repipl

% Last Modified by GUIDE v2.5 04-Feb-2015 16:57:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @repipl_OpeningFcn, ...
                   'gui_OutputFcn',  @repipl_OutputFcn, ...
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


% --- Executes just before repipl is made visible.
function repipl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to repipl (see VARARGIN)

% Choose default command line output for repipl
handles.output = hObject;
[handles UserP]=InitGUI_AllVersions(handles);
handles=InitGUI_BasicVersion(handles,UserP);
handles=InitHandles_BasicVersion(handles);

  
 for i=1:length(handles.AllUIhandles)
    set(handles.AllUIhandles(i),'callback',{@UIcontrolDisplaySet_callback});
 end

guidata(hObject, handles);

% UIWAIT makes repipl wait for user response (see UIRESUME)
% uiwait(handles.MainFigure);


% --- Outputs from this function are returned to the command line.
function varargout = repipl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


  

function UIcontrolDisplaySet_callback(hObject, eventdata)
 handles=guidata(gcf);
 CallbackString=get(hObject,'tag');
 VersionStr='_Basic';
[RunString,VisibleHandleArray,ProcessType]=...
                         run_BVersionCallback('GUIparaVisible',...
                                              'hObject',hObject,...
                                              'handles',handles,...
                                              'VersionStr',VersionStr,...
                                              'CallbackString',CallbackString);    


                                               
if (1==exist('ProcessType','var')&&strcmp(ProcessType,'Postprocess'))
    if ~strcmp('listbox',get(hObject,'style'))
    RadioBtnSet(handles.hParaArray.PostprocessMethod,hObject,'default_zero_selected');
    end
end

if (1==exist('VisibleHandleArray','var'))
    if (1==exist('ProcessType','var')&&~isempty(ProcessType))
        updata_GuiVisible(hObject,VisibleHandleArray,handles.hParaAll);
    end
end

if (1==exist('RunString','var'))&&(~isempty(RunString))    
   handles=UpdateParaListbox_BVersion(handles);
end

if ishghandle(hObject)
    guidata(hObject,handles);
end   

   
  


