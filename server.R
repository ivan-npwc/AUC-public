function(input, output, session) {
############################################################### 
  re = observeEvent( input$ResetSetting, {
    pathPredict<<-choose.dir(default = pathPredict)
    nchaBName=nchar(basename(pathPredict))+1
    pthOPP<<-substr(pathPredict,0, nchar(pathPredict)-nchaBName)
    listOPP<<-list.files(pthOPP)
    source("Modules/ListUniqueUpdate.r")
    labelInput<<-pathPredict
    updateActionButton (session,'ResetSetting',   label=paste0("INPUT:___", labelInput))
    pth_log<<-paste0(labelInput,"\\",basename(labelInput), "_log.csv")
    if (file.exists(pth_log)==F) {log1=NULL } else {log1<<-read.csv(pth_log)}
    })
########################################################################################### 
 observeEvent(input$Up, {
  Species <<-input$Species
    BatchProcessVector<<-input$Bath_Process
  	OPPListPred1<<-input$OPPListPred
	
  source("Modules/ListTMPUpdate.r")
  
 })
############################################################################### 
  observeEvent(input$Start_Batch_process, {
    Species <<-input$Species
    BatchProcessVector<<-input$Bath_Process
  	OPPListPred1<<-input$OPPListPred
	#######
if (OPPListPred1=="All") {OPPListPred1=list.files(as.character(unique(listValue$pthOPP)))}
ForLoop_OPPListPred1 <<- OPPListPred1

     source("Modules/ListTMPUpdate.r")
    

	 
	for (d in 1:length(ForLoop_OPPListPred1)) {
	
	       dayInProgress<<-ForLoop_OPPListPred1[d]
	       labelInput <<-   paste0(unique(listValue$pthOPP),"\\",dayInProgress)
withProgress(message = paste0("Doing  ",labelInput), value = d , {
        pth_log<<-paste0(labelInput,"\\",basename(labelInput), "_log.csv")
	      if (file.exists(pth_log)==F) {log1=NULL } else {log1<<-read.csv(pth_log)}
        Haulout_polygon <<-paste0(labelInput,"\\Polygons\\Houlout\\Houlout.shp")	
         Rookery_polygon <<-paste0(labelInput,"\\Polygons\\Rookery\\Rookery.shp")	
 
   for (i in 1:length(BatchProcessVector)) {
      withProgress(message = paste0(BatchProcessVector[i]), value = i, { 
             action<<-paste0("Modules/", BatchProcessVector[i],".r") 
              startAction <<- data.frame(moment="Start", action=paste0(action), dtime=paste0(date() ))
              log1=rbind(log1,startAction)
              write.csv(log1,pth_log, row.names = F)
      Sys.sleep(1) 
      source(action)
	    Sys.sleep(1) 
     	print(paste0("Done  ",action,"   ",labelInput ))
           endAction <<-data.frame(moment="Finish", action=paste0(action), dtime=paste0(date() ))
           log1=rbind(log1,endAction)
           write.csv(log1,pth_log, row.names = F)
           
           
   }) 
		   
        }
      
      OPPListPred1<<-OPPListPred1[!(OPPListPred1 %in% dayInProgress)]
      source("Modules/ListTMPUpdate.r")
      print(paste0("Done  ",labelInput ))
      
    })
  
  
	
   	
}
	
  })
########################################################################################  
  observeEvent(input$Start_process_manager, {
 #   source("Modules/SQLiteWrite.r")
     ProsessManager<<-input$ProcessManager
     listOPP1<<-input$OPPList
	 if (listOPP1=="All") {listOPP1=list.files(listValue$pthOPP)}
	 SpeciesManager <<-input$SpeciesManager
	
      for (d in 1:length(listOPP1)) {
	  labelInput <<-   paste0(listValue$pthOPP,"\\",  listOPP1[d])
      pth_log<<-paste0(labelInput,"\\",basename(labelInput), "_log.csv")
      Haulout_polygon <<-paste0(labelInput,"\\Polygons\\Houlout\\Houlout.shp")	
      Rookery_polygon <<-paste0(labelInput,"\\Polygons\\Rookery\\Rookery.shp")	

        withProgress(message = 'Process......', value = 0, {
           action<-paste0("Modules/", ProsessManager,".r") 
           startAction <<- data.frame(moment="Start", action=paste0(action), dtime=paste0(date() ))
           log1=rbind(log1,startAction)
             write.csv(log1,pth_log, row.names = F)
			    Sys.sleep(5) 
                source(action)
				Sys.sleep(5) 
           endAction <<-data.frame(moment="Finish", action=paste0(action), dtime=paste0(date() ))
          log1=rbind(log1,endAction)
        write.csv(log1,pth_log, row.names = F)
        beep()
        incProgress(1/1, detail = paste("Done part", 1))
    })
    beepr::beep(sound = 3)		
}	 
  })
  ########################################################################################################
  output$text1 <- renderDataTable(log1)
  output$text <- renderDataTable(log1)
 ##############################################################################################################
  observeEvent(input$Get_data, { 
  source("Modules/Get_data.r")
    })
	
	
  ###################################################################################
  
  re4 = observeEvent( input$train256_NFS_Dir, {
    train256_NFS_Dir<<-choose.dir()
    updateActionButton (session,'train256_NFS_Dir',   label= paste0("train256_NFS_Dir:  ",train256_NFS_Dir))
  })
  ########################################################################################
  re4 = observeEvent( input$Model_base, {
    Model_base<<-file.choose()
    updateActionButton (session,'Model_base',   label= paste0("MODEL BASE:  ",Model_base))
  })
#########################################################################################################################
   re6 = observeEvent( input$Rookery_polygon, {
     Rookery_polygon<<-file.choose()
      updateActionButton (session,'Rookery_polygon',   label= paste0("Rookery_polygon:  ",Rookery_polygon))
    }) 
#############################################################################################################
   re7 = observeEvent( input$Haulout_polygon, {
     Haulout_polygon<<-file.choose()
     updateActionButton (session,'Haulout_polygon',   label= paste0("Haulout_polygon:  ",Haulout_polygon))
   }) 
 #######################################################################
  re8 = observeEvent( input$Image, {
    Image_dir_Sin<<-choose.dir()
   updateActionButton (session,'Image',   label= paste0("Image:                ",Image_dir_Sin))
  }) 
  ######################################################################
  re9 = observeEvent( input$Mask, {
    Mask_dir_Sin<<-choose.dir()
    updateActionButton (session,'Mask',   label= paste0("Mask:                ",Mask_dir_Sin))
  })  
  #########################################################################################
  re10 = observeEvent( input$Pth_img_error, {
    Pth_img_error<<-file.choose()
    updateActionButton (session,'Pth_img_error',   label= paste0("Pth_img_error:                ",Pth_img_error))
  })  
  #########################################################################################
  re11 = observeEvent( input$Exlude_polygon, {
    Exlude_polygon<<-file.choose()
    updateActionButton (session,'Exlude_polygon',   label= paste0("Exlude_polygon:  ",Exlude_polygon))
  }) 
  ##################################################################################
  re13 = observeEvent( input$Weight, {
    Weight<<-file.choose()
    updateActionButton (session,'Weight',   label= paste0("Weight:  ",Weight))
  }) 
  #####################################################################################
  re14 = observeEvent( input$ModelPoligon, {
    ModelPoligon<<-tk_choose.files(caption = "Select model polygon",multi = F, default = pth_log)
    updateActionButton (session,'ModelPoligon',   label= paste0("ModelPoligon:  ",ModelPoligon))
  }) 
  #####################################################################################
  re15 = observeEvent( input$ObserverPoint, {
    ObserverPoint<<-file.choose()
    updateActionButton (session,'ObserverPoint',   label= paste0("ObserverPoint:  ",ObserverPoint))
  }) 
  #####################################################################################
  re16 = observeEvent( input$PredictPoint, {
    PredictPoint<<-file.choose()
    updateActionButton (session,'PredictPoint',   label= paste0("PredictPoint:  ",PredictPoint))
  }) 
  #####################################################################################
  re17 = observeEvent( input$NFS_Pup_weight_pth, {
    NFS_Pup_weight_pth<<-basename(file.choose())
    source("Modules/ListUniqueUpdate.r")
    updateActionButton (session,'NFS_Pup_weight_pth',   label= paste0("NFS_Pup_weight_pth:  ",NFS_Pup_weight_pth))
  }) 
  ######################################################################
  re18 = observeEvent(input$SSL_Adult_weight_pth, {
    SSL_Adult_weight_pth<<-basename(file.choose())
    source("Modules/ListUniqueUpdate.r")
    updateActionButton (session,'SSL_Adult_weight_pth',   label= paste0("SSL_Adult_weight_pth:  ",SSL_Adult_weight_pth))
  })  
#########################################################################  
  re19 = observeEvent( input$SSL_Pup_weight_pth, {
    SSL_Pup_weight_pth<<-basename(file.choose())
    source("Modules/ListUniqueUpdate.r")
    updateActionButton (session,'SSL_Pup_weight_pth',   label= paste0("SSL_Pup_weight_pth:  ",SSL_Pup_weight_pth))
  }) 
 ###################################################################### 
  re20 = observeEvent( input$NFS_Adult_weight_pth, {
    NFS_Adult_weight_pth<<-basename(file.choose())
    source("Modules/ListUniqueUpdate.r")
    updateActionButton (session,'NFS_Adult_weight_pth',   label= paste0("NFS_Adult_weight_pth:  ",NFS_Adult_weight_pth))
  }) 
  ###################################################################### 
  re21 = observeEvent( input$SQLite_path, {
    SQLite_path<<-basename(file.choose())
    source("Modules/ListUniqueUpdate.r")
    updateActionButton (session,'SQLite_path',   label= paste0("SQLite_path:  ",SQLite_path))
  }) 
  #################################################################
  re22 = observeEvent( input$KK_Effort, {
    KK_Effort<<-file.choose()
    source("Modules/ListUniqueUpdate.r")
    updateActionButton (session,'KK_Effort',   label= paste0("KK_Effort:  ",KK_Effort))
  }) 
  #########################################################################################
    re23 = observeEvent( input$SSL_Age_pth, {
    SSL_Age_pth<<-basename(file.choose())
    source("Modules/ListUniqueUpdate.r")
    updateActionButton (session,'SSL_Age_pth',   label= paste0("SSL_Age_pth:  ",SSL_Age_pth))
  }) 
  ###################################################################### 
  observeEvent(input$Unet_train, {
    withProgress(message = 'Artificial intelligent prepare for the Word destruct..', value = 0, {
    NewTrain<<-input$NewTrain
   source("Modules/UNET_Train_256.r")
    incProgress(1/1, detail = paste("Train", 1))
    Sys.sleep(0.1)  
    })
  })
################################################################################################
  observeEvent(input$Unet_train_512, {
    withProgress(message = 'Artificial intelligent prepare for the Word destruct..', value = 0, {
      NewTrain<<-input$NewTrain
      source("Modules/UNET_Train_512.r")
      incProgress(1/1, detail = paste("Train", 1))
      Sys.sleep(0.1)  
    })
  })
  
#########################################################################################  
  observeEvent(input$Bath_Process_data_train_prepare_BTN, {
    VGG_presence_limit<<-input$VGG_presence_limit
    VGG_garem_limit<<-input$VGG_garem_limit
    BatchProcessVectorPrepare<<-input$Bath_Process_data_train_prepare
    withProgress(message = 'Bath process', value = 0, {
      for (i in 1:length(BatchProcessVectorPrepare)) {
        action<-BatchProcessVectorPrepare[i] 
        PthAction=paste0("Modules/",action,".r" )
        startAction<-data.frame(moment="Start", action=paste0(action), dtime=paste0(timestamp() ))
        log1=rbind(log1,startAction)
        write.csv(log1,pth_log, row.names = F)
        source(PthAction)
        endAction<-data.frame(moment="Finish", action=paste0(action), dtime=paste0(timestamp() ))
        log1=rbind(log1,endAction)
        write.csv(log1,pth_log, row.names = F)
        beepr::beep()
        incProgress(1/length(BatchProcessVectorPrepare), detail = paste("Doing part", i))
        Sys.sleep(0.1)  
      }
    })
    beep(sound = 3)
  })
############################################################################################  
  }
  
