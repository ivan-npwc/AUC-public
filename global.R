if (!require("DT")) {install.packages("DT"); library("DT")}
if (!require("keras")) {install.packages("keras"); library("keras")}
if (!require("XML")) {install.packages("XML"); library("XML")}
if (!require("magick")) {install.packages("magick"); library("magick")}
if (!require("filesstrings")) {install.packages("filesstrings"); library("filesstrings")}
if (!require("abind")) {install.packages("abind"); library("abind")}
if (!require("reticulate")) {install.packages("reticulate"); library("reticulate")}
if (!require("parallel")) {install.packages("parallel"); library("parallel")}
if (!require("doParallel")) {install.packages("doParallel"); library("doParallel")}
if (!require("foreach")) {install.packages("foreach"); library("foreach")}
if (!require("tensorflow")) {install.packages("tensorflow"); library("tensorflow")}
if (!require("sp")) {install.packages("sp"); library("sp")}
if (!require("rgdal")) {install.packages("rgdal"); library("rgdal")}
if (!require("geosphere")) {install.packages("geosphere"); library("geosphere")}
if (!require("dismo")) {install.packages("dismo"); library("dismo")}
if (!require("rgeos")) {install.packages("rgeos"); library("rgeos")}
if (!require("kohonen")) {install.packages("kohonen"); library("kohonen")}
if (!require("dplyr")) {install.packages("dplyr"); library("dplyr")}
if (!require("beepr")) {install.packages("beepr"); library("beepr")}
if (!require("tcltk")) {install.packages("tcltk"); library("tcltk")}
if (!require("sf")) {install.packages("sf"); library("sf")}
if (!require("spatialEco")) {install.packages("spatialEco")}

#  if (!requireNamespace("BiocManager", quietly = TRUE))
#  install.packages("BiocManager")
#  BiocManager::install("EBImage")

##########################################################
listValue <<- read.csv("System data/listUniq.csv")
listTMP <<-readRDS("System data/listTMP")
######################
pathPredict <<- unique(as.character(listValue$pathPredict))
listOPP<<-unique(as.character(listValue$listOPP))
NFS_Adult_weight_pth<<-unique(as.character(listValue$NFS_Adult_weight_pth))
NFS_Pup_weight_pth<<-unique(as.character(listValue$NFS_Pup_weight_pth))
SSL_Adult_weight_pth<<-unique(as.character(listValue$SSL_Adult_weight_pth))
SSL_Pup_weight_pth<<-unique(as.character(listValue$SSL_Pup_weight_pth))
SSL_Age_pth <<-  unique(as.character(listValue$SSL_Age_pth))
SQLite_path<<-  unique(as.character(listValue$SQLite_path))
pthOPP<<- unique(as.character(listValue$pthOPP))
KK_Effort <<-unique(as.character(listValue$KK_Effort))

ListSpecies=c("NFS", "SSL")
listR_year=c("2018", "2019")
listR_site=c("38", "138")
listAnimal_type=c("")





#OPPListPred1=listTMP$OPPListPred1
#Species=listTMP$Species
#BatchProcessVector=listTMP$OPPListPred1)
#source("Modules/ListTMPUpdate.r")

if(is.null(NFS_Adult_weight_pth)==T) {NFS_Adult_weight_pth="_"}
if(is.null(NFS_Pup_weight_pth)==T) {NFS_Pup_weight_pth="_"}
if(is.null(SSL_Adult_weight_pth)==T) {SSL_Adult_weight_pth="_"}
if(is.null(SSL_Pup_weight_pth)==T) {SSL_Pup_weight_pth="_"}
if(is.null(SQLite_path)==T) {SQLite_path="_"}
if(is.null(KK_Effort)==T) {KK_Effort="_"}


if (file.exists(KK_Effort)==T){KK_Effort1=read.csv(KK_Effort)}


Image_dir<<-"_"
Mask_dir<<- "_"
Model_tmp_dir<<- "_"
Model_base<<-   "_"
train256_NFS_Dir="_"
Weight="_"

if (exists("PredictPoint")==F){PredictPoint="_"}
if (exists("ModelPoligon")==F){ModelPoligon="_"}
if (exists("ObserverPoint")==F){ObserverPoint="_"}
######################

labelInput<<-pathPredict
Pth_img_error <<- paste0(labelInput,"\\Error\\Points\\Error.shp")
if (file.exists(Pth_img_error)==F) {Pth_img_error="_"}
Rookery_polygon<<-paste0(labelInput,"\\Polygons\\Rookery\\Rookery.shp")
Haulout_polygon<<-paste0(labelInput,"\\Polygons\\Houlout\\Houlout.shp")
Exlude_polygon<<-paste0(labelInput,"\\Polygons\\Exlude\\Exlude.shp")
if (file.exists(Rookery_polygon)==F) {Rookery_polygon="_"}
if (file.exists(Haulout_polygon)==F) {Haulout_polygon="_"}
if (file.exists(Exlude_polygon)==F) {Exlude_polygon="_"}
Image_dir_Sin<<-"_"
Mask_dir_Sin<<-"_"
#################################################################
pth_log<<-paste0(labelInput,"\\",basename(labelInput), "_log.csv")
if (file.exists(pth_log)==F) {
  log1=NULL } else { log1<<-read.csv(pth_log) 
    }
#####################################################
KMLdir=paste0(labelInput,"\\",basename(labelInput))
if (dir.exists(KMLdir)==F) {
Unzip_progress = F } else {Unzip_progress=T}
pth_table<<-paste0(pathPredict,"\\", basename(pathPredict),"_table.csv")
if (file.exists(pth_table)==F) {
  KML_progress=F } else   {KML_progress=T}
 #############################################################
Tpth=paste0(labelInput,"\\", basename(labelInput), "_table.csv")
ImgSave=paste0(labelInput, "\\", "Predict", "\\","Input")
if (file.exists(Tpth)==T & dir.exists(ImgSave)==T) {
  table=read.csv(Tpth)
  Need=length(table$link)
  Presence=length(list.files(ImgSave))
  if (Need ==Presence) {Image_prepare_progress=T} else {Image_prepare_progress=F}
  } else {Image_prepare_progress=F}
########################################################################
#tableNewP=paste0(labelInput, "\\Predict\\",basename(labelInput),"_NFS_presence.csv")
#to=paste0(labelInput,"\\Predict\\Animals presence")
#if (file.exists(tableNewP)==T & dir.exists(to)==T) {
#tablePres=read.csv((tableNewP))
#  limit=0.2# tablePres$limitPresence
#  Need=tablePres[tablePres$presence >= limit,]
#  Need=length(Need$link)
#  Presence=length(list.files(to))
#  if (Presence ==Need) {VGG_presence_progress =T} else {VGG_presence_progress=F}
#}  else {VGG_presence_progress=F}
#####################################################
