function rest_metabatch()
%-----------------------------------------------------------
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 20150601
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com
%	Version=1.0;

handles.MainFigure=figure('Visible','on',...
                'menubar','none',...              
                'units','pixel',... 
                'position',[300 300 600 400],...
                'color',[0.83,0.82,0.78],...
                'name','resting state data process batch');
            
handles.EPIDirectoryText=uicontrol(handles.MainFigure,....
                             'style','text',...
                             'unit','normalized',...
                             'visible','on',...
                             'string','EPI Directory',...
                             'BackgroundColor',[0.83,0.82,0.78],...
                             'position',[0.02,0.91,0.2,0.03]);

handles.EPIDirectoryEdit=uicontrol(handles.MainFigure,....
                             'style','edit',...
                             'unit','normalized',...
                             'visible','on',...
                             'string',pwd,...
                             'backgroundcolor',[1 1 1],...                             
                             'position',[0.2,0.9,0.6,0.05]);  
                         
handles.EPIDirectoryBtn=uicontrol(handles.MainFigure,....
                             'style','pushbutton',...
                             'unit','normalized',...
                             'visible','on',...
                             'string','...',...
                             'position',[0.82,0.9,0.1,0.05]); 
                         
set(handles.EPIDirectoryBtn,'callback',{@EPIDirectoryBtn_Callback});
                         
handles.TRText=uicontrol(handles.MainFigure,....
                             'style','text',...
                             'unit','normalized',...
                             'string','TR(sec)',...
                              'BackgroundColor',[0.83,0.82,0.78],...
                             'position',[0.06 0.79 0.15 0.05]);
     
handles.TREdit=uicontrol(handles.MainFigure,....
                             'style','edit',...
                             'unit','normalized',...
                             'backgroundcolor',[1 1 1],...
                             'string','2',...
                             'position',[0.2 0.8 0.15 0.05]);  
                                                              
                         
handles.SliceNumberText=uicontrol(handles.MainFigure,'style','text',...
                             'unit','normalized',...
                             'string','Slice Number',...
                             'BackgroundColor',[0.83,0.82,0.78],...                             
                             'position',[0.05 0.7 0.15 0.05]); 
                         
handles.SliceNumberEdit=uicontrol(handles.MainFigure,'style','edit',...
                             'unit','normalized',...
                             'BackgroundColor',[1 1 1],...
                             'string','33',...
                             'position',[0.2 0.71 0.15 0.05]); 

handles.SliceOrderText=uicontrol(handles.MainFigure,'style','text',...
                             'unit','normalized',...
                             'string','Slice Order',...
                             'BackgroundColor',[0.83,0.82,0.78],...                                                          
                             'position',[0.05 0.6 0.15 0.05]); 
                         
handles.SliceOrderEdit=uicontrol(handles.MainFigure,'style','edit',...
                             'unit','normalized',...
                             'BackgroundColor',[1 1 1],...
                             'string',num2str(eval('[1:2:33 2:2:32]')),...
                             'position',[0.2 0.61 0.7 0.05]);
                         
set(handles.SliceOrderEdit,'callback',{@SliceOrderEdit_Callback});

handles.DicomToNiftiChekbox=uicontrol(handles.MainFigure,...
                             'style','checkbox',...
                             'unit','normalized',...
                             'string','choose me, if your data type is DICOM',...
                             'position',[0.1,0.5,0.4,0.05]);
 
                         
                         
handles.CutNumText=uicontrol(handles.MainFigure,'style','text',...
                             'unit','normalized',...
                             'string','Cut number',...
                             'BackgroundColor',[0.83,0.82,0.78],...                                                          
                             'position',[0.05 0.4 0.15 0.05]); 
                         
handles.CutNumEdit=uicontrol(handles.MainFigure,'style','edit',...
                             'unit','normalized',...
                             'BackgroundColor',[1 1 1],...
                             'string','10',...
                             'position',[0.2 0.41 0.1 0.05]); 
 
handles.CutNumTip=uicontrol(handles.MainFigure,'style','text',...
                             'unit','normalized',...
                             'string','If out of memory, try to use bigger cut number',...
                             'BackgroundColor',[0.83,0.82,0.78],...                                                          
                             'position',[0.3 0.4 0.4 0.05]);                          
                         
handles.OutDirectoryText=uicontrol(handles.MainFigure,....
                             'style','text',...
                             'unit','normalized',...
                             'visible','off',...
                             'string','Output Directory',...
                             'BackgroundColor',[0.83,0.82,0.78],...
                             'position',[0.02,0.41,0.2,0.03]);

handles.OutDirectoryEdit=uicontrol(handles.MainFigure,....
                             'style','edit',...
                             'unit','normalized',...
                             'visible','off',...
                             'string',[pwd filesep 'output'],...
                             'backgroundcolor',[1 1 1],...                             
                             'position',[0.2,0.4,0.6,0.05]);  
                         
handles.OutDirectoryBtn=uicontrol(handles.MainFigure,....
                             'style','pushbutton',...
                             'unit','normalized',...
                             'visible','off',...
                             'string','...',...
                             'position',[0.82,0.4,0.1,0.05]);   
                         
set(handles.OutDirectoryBtn,'callback',{@OutDirectoryBtn_Callback});
                         



handles.UIhandles.parallel_checkbox.handle=uicontrol(handles.MainFigure,....
                             'style','checkbox',...
                             'unit','normalized',...
                             'visible','on',...
                             'string','Parallel processing',...
                             'BackgroundColor',[0.83,0.82,0.78],... 
                             'position',[0.1,0.3,0.2,0.05]); 
                         
 handles.UIhandles.parallel_text.handle=uicontrol(handles.MainFigure,....
                             'style','text',...
                             'unit','normalized',...
                             'visible','on',...
                             'string','Workers',...
                             'BackgroundColor',[0.83,0.82,0.78],... 
                             'position',[0.32,0.29,0.08,0.05]); 
                         
handles.UIhandles.parallel_edit.handle=uicontrol(handles.MainFigure,....
                             'style','edit',...
                             'unit','normalized',...
                             'visible','on',...
                             'enable','off',...
                             'BackgroundColor',[1 1 1],... 
                             'string','',...
                             'position',[0.41,0.3,0.15,0.05]); 



 set(handles.UIhandles.parallel_checkbox.handle,'callback',{'parallel_checkbox_callback'});
 set(handles.UIhandles.parallel_edit.handle,'callback',{'parallel_edit_callback'});
 






handles.RunPushBtn=uicontrol(handles.MainFigure,....
                             'style','pushbutton',...
                             'unit','normalized',...
                             'visible','on',...
                             'string','Run',...
                             'position',[0.73,0.2,0.2,0.1]);  

set(handles.RunPushBtn,'callback',{@RunPushBtn_Callback});
                         
guidata(handles.MainFigure,handles);                         
end


 function SliceOrderEdit_Callback(hObject, eventdata)
     SliceOrder=get(hObject,'string');
     SliceOrderText =eval(['[',SliceOrder,']']);
     set(hObject,'string',num2str(SliceOrderText))
 end
 
 
 
 function EPIDirectoryBtn_Callback(hObject, eventdata)
    handles=guidata(gcf);
    EPIDirectoryPath=uigetdir(pwd);
    if 0~=EPIDirectoryPath
        cd(EPIDirectoryPath);
        set(handles.EPIDirectoryEdit,...
            'string',EPIDirectoryPath);
    end
 end

 
 
 function OutDirectoryBtn_Callback(hObject, eventdata)
     handles=guidata(gcf);
     OutDirectoryPath=uigetdir(pwd);
    if 0~=OutDirectoryPath
        cd(OutDirectoryPath);
        set(handles.OutDirectoryEdit,...
            'string',OutDirectoryPath);
    end
 end
 
 
 function RunPushBtn_Callback(hObject, eventdata)
 t1=clock;
 handles=guidata(gcf);
 EPIDirectoryPath=get(handles.EPIDirectoryEdit,'string');
 Workdirpath=inpath_Misc(EPIDirectoryPath,'GetParentPath');
 TRstr=get(handles.TREdit,'string');
 TR=eval(['[',TRstr,']']);
 CutNumStr=get(handles.CutNumEdit,'string');
 CutNumber=eval(['[',CutNumStr,']']);
 
 SliceNumberstr=get(handles.SliceNumberEdit,'string');
 SliceNumber=eval(['[',SliceNumberstr,']']);
 SliceOrderstr=get(handles.SliceOrderEdit,'string');
 SliceOrder=eval(['[',SliceOrderstr,']']);
 IsDicomToNifti=get(handles.DicomToNiftiChekbox,'value');
 OutDirectory=get(handles.OutDirectoryEdit,'string');

 IsDelete=1;
 SubfodrList=dir_NameList(EPIDirectoryPath);

 if 1==IsDicomToNifti
    OperationList={'EPIDICOMTONIFTI','RemoveFirstTimePoints','SliceTiming','Realign','NormalizeEpi'};
    Pf=get_Postfix('DicomToNifti');                     
 else                     
    OperationList={'RemoveFirstTimePoints','SliceTiming','Realign','NormalizeEpi'};
    Pf='';                 
 end
 
 
 
 % EpiDicomtoNifti
    InputParameter.EpiDicomToNifti.InDirFunRaw=EPIDirectoryPath;
    InputParameter.EpiDicomToNifti.OutDirFunImg=[EPIDirectoryPath Pf];
% Remove First Time Points
    InputParameter.RemoveFirstTimePoints.InDirFunImg=InputParameter.EpiDicomToNifti.OutDirFunImg;
    InputParameter.RemoveFirstTimePoints.OutDirFunImg=[InputParameter.RemoveFirstTimePoints.InDirFunImg,...
                                                       get_Postfix('RemoveFirstTimePoints')];
    InputParameter.RemoveFirstTimePoints.TimePointsAmount=10;
% Slice Timing
    InputParameter.SliceTiming.InDirFunImg=InputParameter.RemoveFirstTimePoints.OutDirFunImg;
    InputParameter.SliceTiming.OutDirFunImg=[InputParameter.SliceTiming.InDirFunImg,...
                                             get_Postfix('SliceTiming')];
    InputParameter.SliceTiming.SliceNumber=SliceNumber;
    InputParameter.SliceTiming.SliceOrder=SliceOrder;
    InputParameter.SliceTiming.ReferenceSlice=SliceOrder(ceil(SliceNumber/2));
    InputParameter.SliceTiming.TR=TR;
    
% Realign
    InputParameter.Realign.InDirFunImg=InputParameter.SliceTiming.OutDirFunImg;
    InputParameter.Realign.OutDirFunImg=[InputParameter.Realign.InDirFunImg,...
                                         get_Postfix('Realign')];
    InputParameter.Realign.RealignParameterDir=[Workdirpath filesep get_Postfix('RealignParameter')];

%% NormalizeEpi
    InputParameter.Normalize.EPI.InDirFunImg=InputParameter.Realign.OutDirFunImg;
    InputParameter.Normalize.EPI.OutDirFunImg=[InputParameter.Normalize.EPI.InDirFunImg get_Postfix('Normalize')];
    InputParameter.Normalize.EPI.InDirRealignParameter=InputParameter.Realign.RealignParameterDir;
    InputParameter.Normalize.EPI.InFodrChekNormPic=[Workdirpath filesep get_Postfix('PicsForChekNorm')];
    InputParameter.Normalize.EPI.BoundingBox=[-90,-126,-72;90,90,108];
    InputParameter.Normalize.EPI.VoxSize=[3 3 3];

    
pipeline_batch(OperationList,InputParameter);

if 1==IsDelete
    inpath_Misc(InputParameter.RemoveFirstTimePoints.OutDirFunImg,'Path4Delete'); 
    inpath_Misc(InputParameter.SliceTiming.OutDirFunImg,'Path4Delete'); 
    inpath_Misc(InputParameter.Realign.OutDirFunImg,'Path4Delete'); 
end

%% Smooth
    InputParameter.Smooth.Gaussian.InDirFunImg=InputParameter.Normalize.EPI.OutDirFunImg;
    InputParameter.Smooth.Gaussian.OutDirFunImg=[InputParameter.Normalize.EPI.OutDirFunImg get_Postfix('Smooth')];
    InputParameter.Smooth.Gaussian.FWHM=[6 6 6];    

pipeline_batch({'Smooth'},InputParameter);


%% Detrend
%for peraf
    InputParameter.Detrend.InDirFunImg=InputParameter.Smooth.Gaussian.OutDirFunImg;
    InputParameter.Detrend.OutDirFunImg=[InputParameter.Detrend.InDirFunImg get_Postfix('Detrend')];
    InputParameter.Detrend.CutNumber=CutNumber;    
pipeline_batch({'Detrend'},InputParameter);
%for kccreho and Degree centrality
    InputParameter.Detrend.InDirFunImg=InputParameter.Normalize.EPI.OutDirFunImg;
    InputParameter.Detrend.OutDirFunImg=[InputParameter.Detrend.InDirFunImg get_Postfix('Detrend')];
    InputParameter.Detrend.CutNumber=CutNumber; 
pipeline_batch({'Detrend'},InputParameter);


if 1==IsDelete
    inpath_Misc([InputParameter.Normalize.EPI.OutDirFunImg get_Postfix('Smooth')],'Path4Delete'); 
    inpath_Misc(InputParameter.Normalize.EPI.OutDirFunImg,'Path4Delete'); 
end





%% Filter (0.01-0.08hz)
    InputParameter.Filter.InDirFunImg=[InputParameter.Smooth.Gaussian.OutDirFunImg get_Postfix('Detrend')];
    InputParameter.Filter.OutDirFunImg=[InputParameter.Filter.InDirFunImg get_Postfix('Filter')];
    InputParameter.Filter.InFileMask=[get_Parameters('MASKPATH') filesep 'BrainMask_05_61x73x61.img'];
    InputParameter.Filter.SamplePeriod=TR;
    InputParameter.Filter.LowPass_HighCutoff=0.08;
    InputParameter.Filter.HighPass_LowCutoff=0.01;
    InputParameter.Filter.IsAddMeanBack='Yes';
    InputParameter.Filter.CutNumber=CutNumber;  
pipeline_batch({'Filter'},InputParameter);
    InputParameter.Filter.InDirFunImg=[InputParameter.Normalize.EPI.OutDirFunImg get_Postfix('Detrend')];
    InputParameter.Filter.OutDirFunImg=[InputParameter.Filter.InDirFunImg get_Postfix('Filter')];
pipeline_batch({'Filter'},InputParameter);

%%
KccReHoInpath=[InputParameter.Normalize.EPI.OutDirFunImg get_Postfix('Detrend') get_Postfix('Filter')];
DegreeCentralityInpath=KccReHoInpath;
PerAFInPath=[InputParameter.Smooth.Gaussian.OutDirFunImg get_Postfix('Detrend') get_Postfix('Filter')];
ALFFInPath=[InputParameter.Smooth.Gaussian.OutDirFunImg get_Postfix('Detrend')];


%% ALFF
InputParameter.alff.InDirFunImg=ALFFInPath;
InputParameter.alff.OutFodrALFF=[Workdirpath filesep 'Results' filesep 'ALFF_001_008'];
InputParameter.alff.InFileMask=[get_Parameters('MASKPATH') filesep 'BrainMask_05_61x73x61.img'];
InputParameter.alff.SamplePeriod=TR;
InputParameter.alff.LowPass_HighCutoff=0.08;
InputParameter.alff.HighPass_LowCutoff=0.01;
InputParameter.alff.CutNumber=CutNumber;

%% KccReHo
    InputParameter.KccReHo.InDirFunImg=KccReHoInpath;
    InputParameter.KccReHo.OutFodrKccReHo=[Workdirpath filesep 'Results' filesep 'KccReHo_001_008'];
    
    InputParameter.KccReHo.InFileMask=InputParameter.Filter.InFileMask;
    InputParameter.KccReHo.NVoxel=27;
    InputParameter.KccReHo.CutNumber=CutNumber;
    InputParameter.KccReHo.IsSmooth=1;
    InputParameter.KccReHo.SmoothFWHM=[6 6 6];
    
% PerAF
    InputParameter.PerAF.InDirFunImg=PerAFInPath;
    InputParameter.PerAF.OutFodrPerAF=[Workdirpath filesep 'Results' filesep 'PerAF_001_008'];
    InputParameter.PerAF.InFilePathMask=InputParameter.Filter.InFileMask;

% Degree centrality
    InputParameter.DegreeCentrality.InDirFunImg=DegreeCentralityInpath;
    InputParameter.DegreeCentrality.OutFodrDegreeCentrality=...
                                   [Workdirpath filesep 'Results' filesep 'DegreeCentrality_001_008'];
    InputParameter.DegreeCentrality.InFilePathMask=InputParameter.Filter.InFileMask;
    InputParameter.DegreeCentrality.rThreshold=0.2;
    InputParameter.DegreeCentrality.CutNumber=CutNumber;
    InputParameter.DegreeCentrality.IsSmooth=1;
    InputParameter.DegreeCentrality.SmoothFWHM=[6 6 6];



pipeline_batch({'ALFF','KCCREHO','PERAF','DEGREECENTRALITY'},InputParameter);

if 1==IsDelete
    inpath_Misc(KccReHoInpath,'Path4Delete'); 
    inpath_Misc(PerAFInPath,'Path4Delete'); 
end 


%% Filter bands
KccReHoDetrendpath=[InputParameter.Normalize.EPI.OutDirFunImg get_Postfix('Detrend')];
PerAFDetrendPath=[InputParameter.Smooth.Gaussian.OutDirFunImg get_Postfix('Detrend')];

ValidFrequency=(1/TR)/2;
BandNum=ceil(ValidFrequency/0.05);
lowindex=1;
highindex=2;

FrequencyStart=0;
for i=1:BandNum
    if i==1
        TheBand(i,lowindex)=FrequencyStart;
        TheBand(i,highindex)=TheBand(i,lowindex)+0.05; 
%     elseif i==BandNum
%         TheBand(i,lowindex)=TheBand(i-1,highindex);
%         TheBand(i,highindex)=ValidFrequency; 
    elseif (TheBand(i-1,highindex)+0.05)<=ValidFrequency
        TheBand(i,lowindex)=TheBand(i-1,highindex);
        TheBand(i,highindex)=TheBand(i,lowindex)+0.05; 
    elseif ((TheBand(i-1,highindex)+0.05)>ValidFrequency)...
           &&((TheBand(i-1,highindex))<=ValidFrequency)
       BandNum=BandNum-1;
    end
end

%% bands: KccReHo; DegreeCentrality
InputParameter.Filter.InDirFunImg=KccReHoDetrendpath;
for i=1:BandNum
    InputParameter.Filter.OutDirFunImg=[KccReHoDetrendpath 'band' num2str(i)];
    InputParameter.Filter.LowPass_HighCutoff=TheBand(i,highindex);
    InputParameter.Filter.HighPass_LowCutoff=TheBand(i,lowindex);
    pipeline_batch({'Filter'},InputParameter);
    
    InputParameter.DegreeCentrality.InDirFunImg=InputParameter.Filter.OutDirFunImg;
    InputParameter.DegreeCentrality.OutFodrDegreeCentrality=...
                                      [Workdirpath filesep 'Results' filesep 'DegreeCentrality_band' num2str(i)...
                                      creat_band_postfix(TheBand(i,lowindex),TheBand(i,highindex))];
                               
    
    InputParameter.KccReHo.InDirFunImg=InputParameter.Filter.OutDirFunImg;
    InputParameter.KccReHo.OutFodrKccReHo=[Workdirpath filesep 'Results' filesep 'KccReHo_band' num2str(i)...
                                          creat_band_postfix(TheBand(i,lowindex),TheBand(i,highindex))];    
    pipeline_batch({'KccReho','DEGREECENTRALITY'},InputParameter);
    if 1==IsDelete
       inpath_Misc(InputParameter.KccReHo.InDirFunImg,'Path4Delete');
    end
end

%% bands: PerAF
InputParameter.Filter.InDirFunImg=PerAFDetrendPath;
for i=1:BandNum
    InputParameter.Filter.OutDirFunImg=[PerAFDetrendPath 'band' num2str(i)];
    InputParameter.Filter.LowPass_HighCutoff=TheBand(i,highindex);
    InputParameter.Filter.HighPass_LowCutoff=TheBand(i,lowindex);
    pipeline_batch({'Filter'},InputParameter);
    InputParameter.PerAF.InDirFunImg=InputParameter.Filter.OutDirFunImg;
    InputParameter.PerAF.OutFodrPerAF=[Workdirpath filesep 'Results' filesep 'PerAF_band' num2str(i)...
                                      creat_band_postfix(TheBand(i,lowindex),TheBand(i,highindex))];    
    pipeline_batch({'PerAF'},InputParameter);
    if 1==IsDelete
       inpath_Misc(InputParameter.Filter.OutDirFunImg,'Path4Delete');
    end
end


%% bands ALFF
for i=1:BandNum
    InputParameter.alff.InDirFunImg=ALFFInPath;
    InputParameter.alff.OutFodrALFF=[Workdirpath filesep 'Results' filesep 'ALFF_band' num2str(i)...
                                    creat_band_postfix(TheBand(i,lowindex),TheBand(i,highindex))];
    InputParameter.alff.LowPass_HighCutoff=TheBand(i,highindex);
    InputParameter.alff.HighPass_LowCutoff=TheBand(i,lowindex);
    pipeline_batch({'ALFF'},InputParameter);
end



%% ProcessLog
Result4Meta=[Workdirpath filesep 'Result4Meta'];
inpath_Misc(Result4Meta,'MakeCurrentDir');
fid=fopen([Result4Meta filesep 'processLog.txt'],'a+');


fprintf(fid,'TR(sec)=%ss\n',TRstr);
fprintf(fid,'Slice number:\t%s\n',SliceNumberstr);
fprintf(fid,'Slice order:\t%s\n',SliceOrderstr);
fprintf(fid,'Reference slice:\t%d\n',InputParameter.SliceTiming.ReferenceSlice);



for i=1:BandNum
fprintf(fid,'band%s=%s~%s\n',num2str(i),TheBand(i,lowindex),TheBand(i,highindex));
end

fprintf(fid,'\nKCC-ReHo and Degree centrality:\t%s\n',['Remove First 10 Time Points,SliceTiming,Realign,Normalize(Epi)' ,...
                                 ',Detrend,Filter']);
fprintf(fid,'\nPerAF:\t%s\n',['Remove First 10 TimePoints,SliceTiming,Realign,Normalize(Epi)' ,...
                               ',Smooth[6 6 6],Detrend,Filter']);
 
fprintf(fid,'\nALFF:\t%s\n',['Remove First 10 TimePoints,SliceTiming,Realign,Normalize(Epi)' ,...
                               ',Smooth[6 6 6],Detrend']);                           
fclose(fid);


if 1==IsDelete
      inpath_Misc(KccReHoDetrendpath,'Path4Delete');
      inpath_Misc(PerAFDetrendPath,'Path4Delete');      
end

move_InDir2OutDir(InputParameter.Normalize.EPI.InDirRealignParameter,...
                  [Result4Meta filesep 'RealignParameter']);

move_InDir2OutDir(InputParameter.Normalize.EPI.InFodrChekNormPic,...
                  [Result4Meta filesep 'PicsForChekNorm']);              

RegularExpression={'KccReHo_*','SmKccReHo_*','mALFF_*'...
                   'DegreeCentrality_*','SmDegreeCentrality_*','PerAF_*','mPerAF_*'};        
for i=1:length(RegularExpression)
move_Infodr2Outfodr([Workdirpath filesep 'Results' ],...
                    [Result4Meta filesep 'Results'],'RegExp',RegularExpression{i});

end

if 1==IsDelete
    inpath_Misc(InputParameter.Normalize.EPI.InDirRealignParameter,'Path4Delete');
    inpath_Misc(InputParameter.Normalize.EPI.InFodrChekNormPic,'Path4Delete');
    inpath_Misc([Workdirpath filesep 'Results' ],'Path4Delete');
end



ExcludingCriteria=3;
chek_HeadMotion([Result4Meta filesep 'RealignParameter'],Result4Meta,SubfodrList,ExcludingCriteria);
zip([Result4Meta '.zip'],Result4Meta);
 t2=clock;
 
 fprintf('\n time:%s min\n',num2str(etime(t2,t1)/60));
end
 
 
 function chek_HeadMotion(RealignParameter,Result4Meta,SubfodrList,ExcludingCriteria)

deletesubjecttxt=[Result4Meta filesep 'HeadMotionMoreThan' num2str(ExcludingCriteria) '.txt'];
SubHeadMotionMtrx=[];

for i=1:length(SubfodrList)
    SubjPath_RealignParameter=[RealignParameter filesep SubfodrList{i}];
    rpfilepathlist=dir_4RegExp(SubjPath_RealignParameter,'rp*');
    if length(rpfilepathlist)>1
        warning('more than 1 rp* file');
    end
    rpfilepath=[SubjPath_RealignParameter filesep rpfilepathlist{1}]; 
    HeadMotionMtrxIn=load(rpfilepath); 
    Max_HeadMotion=max(abs(HeadMotionMtrxIn));
    Max_HeadMotion(4:6)=Max_HeadMotion(4:6)*180/pi;
    SubHeadMotionMtrx=[SubHeadMotionMtrx;Max_HeadMotion];
end
get_HeadMotionSubject(SubHeadMotionMtrx,SubfodrList,ExcludingCriteria,deletesubjecttxt); 

subresultlist=dir_NameList([Result4Meta filesep 'Results']);

for i=1:length(subresultlist)
   del_RefTex([Result4Meta filesep 'Results' filesep subresultlist{i}],deletesubjecttxt);
end

% inpath_Misc(RealignParameter,'Path4Delete'); % by jiaxize 150924

 end      


function get_HeadMotionSubject(SubHeadMotionMtrx,SubfodrList,ExcludingCriteria,deletesubjecttxt)
         ExcludeMtrxIndex=find(SubHeadMotionMtrx>ExcludingCriteria);
         fid=fopen(deletesubjecttxt,'a+');
        if ~isempty(ExcludeMtrxIndex)
            [II JJ]=ind2sub([length(SubfodrList),6],ExcludeMtrxIndex);
            ExcludeSubIndex=unique(II);
            ExcludeSubInCell=SubfodrList(ExcludeSubIndex);
            ExcludeSubList='';
            for iExcludeSub=1:length(ExcludeSubInCell)
                %ExcludeSubList=sprintf('%s%s\n',ExcludeSubList,ExcludeSubInCell{iExcludeSub});
                fprintf(fid,'%s\n',ExcludeSubInCell{iExcludeSub});
            end
        else
            ExcludeSubList='None';
        end
        fclose(fid);
end
 
 
function band_postfix=creat_band_postfix(low_f,high_f)
band_postfix=['__' strrep(num2str(low_f),'.','_') 'to' strrep(num2str(high_f),'.','_')];
end
 
 