function handles=InitHandles_BasicVersion(handles)
%-----------------------------------------------------------
%   Copyright(c) 2015
%	Center for Cognition and Brain Disorders, Hangzhou Normal University, Hangzhou 310015, China
%	Written by JIA Xi-Ze 201412
%	http://www.restfmri.net/
% 	Mail to Authors: jxz.rest@gmail.com, jiaxize@foxmail.com



handles.ParameterDisplayListboxPreStr='';    
handles.ParameterDisplayListboxPostStr='';



handles.AllUIhandles=[handles.UIhandles.PreDefinedParameterPpmenu.handle;
                      handles.UIhandles.ParameterDisplayListbox.handle;
                      
                      handles.UIhandles.BasicVersionRadioBtn.handle;
                      handles.UIhandles.AdvancedVersionRadioBtn.handle;
                      
                      handles.UIhandles.WorkDirectoryText.handle;
                      handles.UIhandles.WorkDirectoryEdit.handle;
                      handles.UIhandles.WorkDirectoryBtn.handle;
                      
                      handles.UIhandles.TRText.handle;
                      handles.UIhandles.TREdit.handle;
                      
                      handles.UIhandles.DisplayParticipantsBtn.handle;
                      
                      handles.UIhandles.StartDirectoryEpiText.handle;
                      handles.UIhandles.StartDirectoryEpiEdit.handle;
                      handles.UIhandles.StartDirectoryT1Text.handle;
                      handles.UIhandles.StartDirectoryT1Edit.handle;
                      
                      
                      handles.UIhandles.DicomToNiftiChekbox.handle;
                      handles.UIhandles.RemoveFirstTimePointsChekbox.handle;
                      handles.UIhandles.SliceTimingChekbox.handle;
                      handles.UIhandles.RealignChekbox.handle;
                      handles.UIhandles.ReorientChekbox.handle;
                      handles.UIhandles.NormalizeChekbox.handle;
                      handles.UIhandles.SmoothChekbox.handle;
                      handles.UIhandles.DetrendChekbox.handle;
                      handles.UIhandles.FilterChekbox.handle;
                      handles.UIhandles.RegressOutCovariatesChekbox.handle;
                      
                      handles.UIhandles.DefaultmaskRadioBtn.handle;
                      handles.UIhandles.NoMaskRadioBtn.handle;
                      handles.UIhandles.UserDefinedMaskRadioBtn.handle;
                      
                      handles.UIhandles.AlffRadioBtn.handle;
                      handles.UIhandles.fALFFRadioBtn.handle;
                      handles.UIhandles.KccReHoRadioBtn.handle;
                      handles.UIhandles.CoheReHoRadioBtn.handle;
                      handles.UIhandles.PerAFRadioBtn.handle;
                      handles.UIhandles.DegreeCentralityRadioBtn.handle;
                      handles.UIhandles.VMHCRadioBtn.handle;
                      handles.UIhandles.FunConnectivityRadioBtn.handle;
                      handles.UIhandles.GCARadioBtn.handle;
                      
                      handles.UIhandles.SaveBtn.handle;
                      handles.UIhandles.RunBtn.handle;
                      handles.UIhandles.LoadBtn.handle;
                      
                        ];
                    
    
                    
                    
handles.hParaArray.PostprocessMethod = [handles.UIhandles.AlffRadioBtn.handle; 
                                        handles.UIhandles.fALFFRadioBtn.handle;
                                        handles.UIhandles.KccReHoRadioBtn.handle;     
                                        handles.UIhandles.CoheReHoRadioBtn.handle;
                                        handles.UIhandles.PerAFRadioBtn.handle;  
                                        handles.UIhandles.DegreeCentralityRadioBtn.handle;
                                        handles.UIhandles.VMHCRadioBtn.handle;
                                        handles.UIhandles.FunConnectivityRadioBtn.handle;
                                        handles.UIhandles.GCARadioBtn.handle];
                                    
                                    
                    
                    
%% Version radio button                    
handles.VersionRadioBtn.Array=[handles.UIhandles.BasicVersionRadioBtn.handle;
                               handles.UIhandles.AdvancedVersionRadioBtn.handle];

%%  handles.hParaArray                       
handles.hParaArray.DicomToNifti=[handles.hPara.DicomToNifti.EpiChekbox;
                                  handles.hPara.DicomToNifti.T1Chekbox];
                              
handles.hParaArray.RemoveTimePoints=[handles.hPara.RemoveTimePoints.AmountText;
                                      handles.hPara.RemoveTimePoints.AmountEdit]; 
                                  
handles.hParaArray.SliceTiming=[handles.hPara.SliceTiming.SliceNumberText;
                                 handles.hPara.SliceTiming.SliceNumberEdit;
                                 handles.hPara.SliceTiming.SliceOrderText;
                                 handles.hPara.SliceTiming.SliceOrderEdit;
                                 handles.hPara.SliceTiming.ReferenceSliceText;
                                 handles.hPara.SliceTiming.ReferenceSliceEdit];
                             
handles.hParaArray.Reorient=[handles.hPara.Reorient.BeforeCoregiser;
                             handles.hPara.Reorient.AfterCoregiser];

                         
                         
handles.hParaArray.NormalizePara=[handles.hPara.Normalize.BoundingBoxText;
                                  handles.hPara.Normalize.BoundingBoxEdit;
                                  handles.hPara.Normalize.VoxSizeText;
                                  handles.hPara.Normalize.VoxSizeEdit;
                                  handles.hPara.Normalize.EpiRadiobutton;
                                  handles.hPara.Normalize.T1segRadiobutton;
                                  handles.hPara.Normalize.T1NewSeg_dartel_Radiobutton;
%                                   handles.hPara.Normalize.SymT1segRadiobutton
                                  ];
                          
                           
handles.hParaArray.SegmentPara=[handles.hPara.Normalize.SegmentEastAsianRadio;
                            handles.hPara.Normalize.SegmentEuropeanRadio];  
                        
handles.hParaArray.NormalizeAllHandles=[handles.hParaArray.NormalizePara;
                                        handles.hParaArray.SegmentPara];   
                                    
                         
                         
                         
handles.hParaArray.Smooth=[handles.hPara.Smooth.FWHMText;
                           handles.hPara.Smooth.FWHMEdit];

handles.hParaArray.RegressOutNuisance=[handles.hPara.RegressOutNuisance.PolynomialTrendText;
                                       handles.hPara.RegressOutNuisance.PolynomialTrendEdit;
                                       handles.hPara.RegressOutNuisance.HeadMotion6Para;
                                       handles.hPara.RegressOutNuisance.GlobalMean;
                                       handles.hPara.RegressOutNuisance.WhiteMatter;
                                       handles.hPara.RegressOutNuisance.CSF;
                                       handles.hPara.RegressOutNuisance.OtherCovariatesChekbox;
                                       handles.hPara.RegressOutNuisance.OtherCovariatesText;
                                       handles.hPara.RegressOutNuisance.OtherCovariatesListbox;
                                       handles.hPara.RegressOutNuisance.add_mean_back_RadioBtn;
                                       handles.hPara.RegressOutNuisance.not_add_mean_back_RadioBtn;];
                                   
handles.hParaArray.Filter=[handles.hPara.Filter.BandText;
                           handles.hPara.Filter.BandLowEdit;
                           handles.hPara.Filter.BandSepText;
                           handles.hPara.Filter.BandHighEdit];


handles.hParaArray.ChooseMask=[handles.UIhandles.DefaultmaskRadioBtn.handle;
                                handles.UIhandles.NoMaskRadioBtn.handle;
                                handles.UIhandles.UserDefinedMaskRadioBtn.handle];       

handles.hParaArray.Usermask=[handles.hPara.UserMask.Text;
                             handles.hPara.UserMask.Edit;
                             handles.hPara.UserMask.Btn];

                                    
handles.hParaArray.ALFF=[handles.hPara.ALFF.BandText;
                           handles.hPara.ALFF.BandLowEdit;
                           handles.hPara.ALFF.BandSepText;
                           handles.hPara.ALFF.BandHighEdit];
                       
handles.hParaArray.fALFF=[handles.hPara.fALFF.BandText;
                           handles.hPara.fALFF.BandLowEdit;
                           handles.hPara.fALFF.BandSepText;
                           handles.hPara.fALFF.BandHighEdit];

                       
handles.hParaArray.KccReHo=[handles.hPara.KccReHo.ClusterText;
                            handles.hPara.KccReHo.Cluster7RadioBtn;
                            handles.hPara.KccReHo.Cluster19RadioBtn;
                            handles.hPara.KccReHo.Cluster27RadioBtn;
                            handles.hPara.KccReHo.SmKccReHoChekbox;
                            handles.hPara.KccReHo.SmKccReHoFWHMtext;
                            handles.hPara.KccReHo.SmKccReHoFWHMedit;];


handles.hParaArray.CoheReHo=[handles.hPara.CoHeReHo.BandText;
                            handles.hPara.CoHeReHo.BandLowEdit;
                            handles.hPara.CoHeReHo.BandSepText;
                            handles.hPara.CoHeReHo.BandHighEdit;
                            handles.hPara.CoHeReHo.SmCoHeReHoChekbox;
                            handles.hPara.CoHeReHo.SmCoHeReHoFWHMedit;
                            handles.hPara.CoHeReHo.SmCoHeReHoFWHMtext;
                            ];

                        
handles.hParaArray.DegreeCentrality=[handles.hPara.DegreeCentrality.RCorrThreText;
                                     handles.hPara.DegreeCentrality.RCorrThreEdit;
                                     handles.hPara.DegreeCentrality.SmDegreeCentralityFWHMtext;
                                     handles.hPara.DegreeCentrality.SmDegreeCentralityFWHMedit;
                                     handles.hPara.DegreeCentrality.SmDegreeCentralityChekbox;];
                                 

handles.hParaArray.FunConnectivity=[handles.hPara.FunConnectivity.VoxelWiseRadioBtn;
                                   handles.hPara.FunConnectivity.ROIWiseRadioBtn;
                                   handles.hPara.FunConnectivity.DefineROIBtn;
                                   handles.hPara.FunConnectivity.ROIlistText;
                                   handles.hPara.FunConnectivity.ROIlistListbox];                                 


handles.hParaArray.GCA_AwaysVisible=[handles.hPara.GCA.VoxelWiseRadioBtn;
                                     handles.hPara.GCA.ROIWiseRadioBtn;
                                     handles.hPara.GCA.OrderText;
                                     handles.hPara.GCA.OrderEdit;
                                     handles.hPara.GCA.DefineROIBtn;
                                     handles.hPara.GCA.Coefficient_basedRadioBtn;
                                     handles.hPara.GCA.Residual_basedRadioBtn;
                                     handles.hPara.GCA.ROIlistText;
                                     handles.hPara.GCA.ROIlistListbox
                                     ];   
                                 
handles.hParaArray.GCAAllHandles=[handles.hParaArray.GCA_AwaysVisible;
                                  handles.hPara.GCA.BivariateCoefficientsRadioBtn;
                                  handles.hPara.GCA.MultivariateCofficientsRadioBtn]; 
                    
handles.hParaArray.ParticipantsList=[handles.hPara.ParticipantsListInput.ListboxText;
                                     handles.hPara.ParticipantsListInput.DisplayListbox];

handles.hParaAll=[handles.hParaArray.ParticipantsList;
                  handles.hParaArray.DicomToNifti;
                  handles.hParaArray.RemoveTimePoints;
                  handles.hParaArray.SliceTiming;
                  handles.hParaArray.Reorient;
                  handles.hParaArray.NormalizeAllHandles;
                  handles.hParaArray.Smooth;
                  handles.hParaArray.RegressOutNuisance;
                  handles.hParaArray.Filter;
                  handles.hParaArray.Usermask;
                  handles.hParaArray.ALFF;
                  handles.hParaArray.fALFF;
                  handles.hParaArray.KccReHo;
                  handles.hParaArray.CoheReHo;
                  handles.hParaArray.DegreeCentrality;
                  handles.hParaArray.FunConnectivity;
                  handles.hParaArray.GCAAllHandles];   
              
handles.function_use_handle.check_if_smooth_after.if_do_smooth_checkbox.handle...
                                      =handles.UIhandles.SmoothChekbox.handle;    
handles.function_use_handle.check_if_smooth_after.must_do_smooth_after.handle_array...
                                      =[handles.UIhandles.KccReHoRadioBtn.handle;
                                        handles.UIhandles.CoheReHoRadioBtn.handle;
                                        handles.UIhandles.DegreeCentralityRadioBtn.handle];                                 
                    

end