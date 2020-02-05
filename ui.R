options = list(display.mode='showcase')
navbarPage(actionLink('ResetSetting',   label=paste0("INPUT:___", labelInput), style = "font-size:12px;"),
  id="nav", 
 ############################################################################################          
           tabPanel("CIC",
                     fluidPage (
                       
                       column(width = 4,actionLink('Rookery_polygon',   label= paste0("Rookery_polygon:  ", Rookery_polygon), style = "font-size:12px;")),
                       column(width = 4,actionLink('Haulout_polygon',   label= paste0("Haulout_polygon:  ", Haulout_polygon), style = "font-size:12px;")),
                       column(width = 4,actionLink('Exlude_polygon',   label= paste0("Exlude_polygon:  ", Exlude_polygon), style = "font-size:12px;")),
                       
                 
                 fluidRow(column(width = 11, selectInput('Bath_Process', 'Bath_Process', width="1000px",multiple = T,
                                                        c("01_Unzip"="Unzip",
                                                          "02_KMLprepare"="KMLprepare",
                                                          "03_Image_prepare"="Image_prepare",
                                                          "04_Unet"="Unet",
                                                          "05_Blob_analisis"="BlobAnalys",
                                                          "06_Geo_ref"="Geo_ref",
                                                          "07_KML"="KML",
                                                          "08_Age_PREPROCESING"= "Age_PREPROCESING",
                                                          "09_Age_PREDICT"="Age_PREDICT",
                                                          "10_Age_POSTPROCESING"="Age_POSTPROCESING",
														  "11_Error_calculate" = "Error_calculate",
														  "12_prediction_evaluation"="prediction_evaluation"                                                        
                                                          ),
														  selected=listTMP$BatchProcessVector
                                                        )),
                          column(width = 6, selectInput('OPPListPred', 'OPPList', width="1000px",multiple = T,
                                                        c("All",listOPP),
														 selected=listTMP$OPPListPred1))																								
														),
                 fluidRow(column(width = 11, selectInput('Species', 'Species', width="200px",multiple = F,
                                                         c(
														  "NFS_Adult"="NFSAdult",
														  "SSL_Adult"="SSLAdult",
                                                           "NFS_Pup"="NFSPup",
                                                           "SSL_Pup"="SSLPup"
                                                         ),
														 selected=listTMP$Species
                 ))),
                 
                 
                 fluidRow(column(width = 4, actionButton('Start_Batch_process', 'Start_Batch_process', width="200px")),
				          column(width = 4, actionButton('Up', 'Up', width="200px"))
                           ),
               hr(),
               fluidRow(dataTableOutput("text"))   
                )),
#######################################################################################################
tabPanel("Manager",
         
         
         fluidRow(column(width = 11, selectInput('ProcessManager', 'ProcessManager', width="400px",multiple = F,
                                                 c("01_Points_table_for_mask" = "Points_table_for_mask",
												    "02_Animals_Count_On_Image"="Animals_Count_On_Image",
												    "03_Points create"="Points create",
													"04_Img_Copy_for_msk"="Img_Copy_for_msk",
												 
												 
												 
												 
												 "01_EmptyMaskErrorCorrector" = "EmptyMaskErrorCorrector",
                                                   "02_Sort_Image_error" = "Sort_Image_error",
                                                   "03_Error_calculate"= "Error_calculate",
                                                   "04_Get_Agisoft_Shape"="GetAgisoftShape",
                                                   "05_KML_write_from_Agisoft"="KML_write_from_Agisoft",
                                                   "06_SQLite_write_from_Afisoft"="FromAgisoftToSQLite"
												  
                                                 )
         ))),
		  fluidRow(column(width = 11, selectInput('SpeciesManager', 'Species', width="200px",multiple = F,
                                                         c("NFS_Adult"="NFSAdult",
                                                           "SSL_Adult"="SSLAdult",
                                                           "NFS_Pup"="NFSPup",
                                                           "SSL_Pup"="SSLPup"
                                                         )
                 ))),
         fluidRow(column(width = 4, actionButton('Start_process_manager', 'Start_process_manager', width="200px"))),
         hr(),
         fluidRow(column(width = 6, selectInput('OPPList', 'OPPList', width="400px",multiple = T,
                                                c("All",listOPP)
         ))
         ),
         hr(),
         
         fluidRow(column(width = 4,actionLink('ModelPoligon',   label= paste0("ModelPoligon:  ", ModelPoligon), style = "font-size:12px;"))),
         fluidRow(column(width = 4,actionLink('ObserverPoint',   label= paste0("ObserverPoint:  ", ObserverPoint), style = "font-size:12px;"))),
         fluidRow(column(width = 4,actionLink('PredictPoint',   label= paste0("PredictPoint:  ", PredictPoint), style = "font-size:12px;"))),
         hr(),
         fluidRow(column(width = 4,actionLink('NFS_Adult_weight_pth',   label= paste0("NFS_Adult_weight_pth:  ", NFS_Adult_weight_pth), style = "font-size:12px;"))),
         hr(),
         fluidRow(column(width = 4,actionLink('NFS_Pup_weight_pth',   label= paste0("NFS_Pup_weight_pth:  ", NFS_Pup_weight_pth), style = "font-size:12px;"))),
         hr(),
         fluidRow(column(width = 4,actionLink('SSL_Adult_weight_pth',   label= paste0("SSL_Adult_weight_pth:  ", SSL_Adult_weight_pth), style = "font-size:12px;"))),
         hr(),
         fluidRow(column(width = 4,actionLink('SSL_Pup_weight_pth',   label= paste0("SSL_Pup_weight_pth:  ", SSL_Pup_weight_pth), style = "font-size:12px;"))),
         hr(),
		 fluidRow(column(width = 4,actionLink('SSL_Age_pth',   label= paste0("SSL_Age_pth:  ", SSL_Age_pth), style = "font-size:12px;"))),
         hr(),
         fluidRow(column(width = 4,actionLink('SQLite_path',   label= paste0("SQLite_path:  ", SQLite_path), style = "font-size:12px;"))),
         fluidRow(column(width = 4,actionLink('KK_Effort',   label= paste0("KK_Effort:  ", KK_Effort), style = "font-size:12px;")))
),
#####################################################################################################
tabPanel("Train",
        
                fluidRow(column(width = 4, actionButton('Unet_train', 'Unet_train_256', width="400px"))),
                fluidRow(column(width = 4, actionButton('Unet_train_512', 'Unet_train_512', width="400px"))),
      
                 fluidRow(column(width = 10, actionLink('Model_base',   label= paste0("MODEL BASE:  ", Model_base), style = "font-size:12px;"))
                          
         ),
                fluidRow(column(width = 10, actionLink('Weight',   label= paste0("Weight:  ", Weight), style = "font-size:12px;"))
         ),
                fluidRow(column(width = 10, actionLink('train256_NFS_Dir',   label= paste0("Train Dir:  ", train256_NFS_Dir), style = "font-size:12px;"))
         ),
         fluidRow( column(width = 4, checkboxInput("NewTrain", "NewTrain", T))),
        
         fluidRow(column(width = 6, selectInput('Bath_Process_data_train_prepare', 'Bath_Process_data_train_prepare', width="400px",multiple = T,
                                                c(
                                                  "01_Unzip"="Unzip",
                                                  "02_KMLprepare"="KMLprepare",
                                                  "03_Image_prepare"="Image_prepare",
                                                  "04_Points_table_for_mask"="Points_table_for_mask",
                                                  "05_Animals_Count_On_Image"="Animals_Count_On_Image",
                                                  "06_Mask_create"="Mask_create",
                                                  "07_Img_Copy_for_msk"="Img_Copy_for_msk",
												   "08_SSL_Age_SplitTrainValData"="Age_SplitTrainValData",
												   "09_SSL_Age_NormAgeFun"= "Age_NormAgeFun",
												   "10_ SSL_Age_TrainFun"="Age_TrainFun"
                                                )
         ))
         ),
        fluidRow(column(width = 4, actionButton('Bath_Process_data_train_prepare_BTN', 'Bath_Process_data_train_prepare_BTN', width="400px"))),
         
      #   fluidRow(column(width = 10, actionLink('Dir_batch',   label= paste0("Dir_batch:  ", Dir_batch), style = "font-size:12px;"))
      #   ),
         
         hr(),
         fluidRow(dataTableOutput("text1")) 
         
),
####################################################################################################                     
tabPanel("Explorer",
                    column(3, selectInput("Animal_type", "Animal_type", c("All"="", listAnimal_type), multiple=TRUE)),
					column(3,selectInput("Year", "Year", c("All"="", listR_year), multiple=TRUE)),
					column(3,selectInput("Site", "Site", c("All"="", listR_site), multiple=TRUE)),
                    column(width = 3, actionButton('Get_data', 'Get_data', width="400px"))					

         
),
####################################################################################################  


conditionalPanel("false", icon("crosshair"))
 ) 
