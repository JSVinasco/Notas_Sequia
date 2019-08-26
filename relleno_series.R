#############################################
###     Imptacion de datos Faltantes      ###
#############################################

## por Juan Sebastian Vinasco
## js.vinasco.s@gmail.com

##############################################

# establecemos directorio de trabajo

setwd("C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas")


# cargamos las librerias necesarias

library(sp)
#install.packages("devtools")
#if (!require("rspatial")) devtools::install_github('rspatial/rspatial')
library(rspatial)




# Leemos el compilado de datos de las estaciones.

est <- read.csv(file="C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est_prec_qc_no_na2.csv", sep=";",header=TRUE)
#est <- read.csv(file="/home/juan/Documentos/0_tesis/est_prec_qc_no_na_T.csv", sep=";",header=TRUE)

# Leemos las coordenadas

# coord <- read.csv(file="C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/estaciones_guajira_2019_4.csv", sep=",",header=TRUE)
# 
# tupla <- c("id", "latitud", "longitud","elev")
# 
# coord <- coord[tupla]
# 
# spk =SpatialPointsDataFrame(coord, est)#, coords.nrs = numeric(0), 
#                        #proj4string = CRS(as.character(NA)), match.ID, bbox = NULL)
# 

#     extraemos las locaciones

#locaciones <- sp@coords
#tu <- c("latitud", "longitud")
#locaciones <- coord[tu]


# plot spplot


#library(gstat)

#lat <-  c(-23.49174, -23.49179, -23.49182, -23.49183, -23.49185, -23.49187)
#long <- c(152.0718, 152.0718, 152.0717, 152.0717, 152.0717, 152.0717)
#pH <- c(8.222411, 8.19931, 8.140428, 8.100752, 8.068141, 8.048852)

#sample <- data.frame(lat, long, pH)
#coordinates(sample) = ~long+lat
#proj4string(sample) <- CRS("+proj=longlat +datum=WGS84")

#loc <- data.frame(long = 152.07185, lat = -23.49184)
#coordinates(loc)  <- ~ long + lat
#proj4string(loc) <- CRS("+proj=longlat +datum=WGS84")

#oo <- idw(formula=pH ~ 1, locations = sample, newdata = loc, idp = 2.0)
#oo@data$var1.pred

######################################################################################
######################################################################################
#####################################################################################
# 
# datos <-spk@data[, 6]
# tu <- c("latitud", "longitud")
# locaciones = data.frame(coord[tu],datos)
# coordinates(locaciones) = ~longitud +latitud
# proj4string(locaciones) <- CRS("+proj=longlat +datum=WGS84")
# 
# new_DF <- subset(locaciones, is.na(locaciones@data$datos))
# DF <- subset(locaciones, !is.na(locaciones@data$datos))
# #oo2 <- idw(formula=DF@data$datos ~ 1, locations = locaciones, newdata = new_DF, idp = 2.0)
# oo2 <- idw(formula=DF@data$datos ~ 1, locations = locaciones, newdata = new_DF, idp = 2.0)
# 

##################################################################
#data = data.frame(spk@data)
data = data.frame(est)

# yt=as.numeric(data[1,-1])
# plot(yt,type="l")
# 
# yt_serie=ts(data =yt, start = 1980, end = 2014, frequency = 365)
# plot(yt_serie)
# 
# 
# require(plotly)
# time= 1:12411
# plot_ly(x= ~ time)%>%add_lines( y = ~ yt_serie)
#  
# 
# for(i in 1:75){
#   yt=as.numeric(data[i,-1])
#   plot(yt,type="l")
#   yt_serie=ts(data=yt, start = 1980, end = 2014, frequency = 365)
#   yt_serie2 = tsclean(yt_serie)
#   plot(yt_serie2)
#   
#   yt_salida=as.integer(yt_serie2)
#   nombre_salida= paste0("E:/0_Tesis/CIAT/Estaciones_Tesis/todas/relleno/","rellenada",i,".csv")
#   write.csv(yt_salida,file=nombre_salida)
#   
# }
# 
# 
# library(imputeTS)
# plotNA.distributionBar(yt_serie)
# plotNA.gapsize(yt_serie)
# plotNA.distribution(yt_serie)
# statsNA(yt_serie)
# 
# 
# 
# 
# imputado2 = na_seadec(yt_serie)
# plotNA.imputations(yt_serie,imputado2)
# plot(decompose(imputado2)) 
# 
# 
# imputado = na_seasplit(yt_serie)
# plotNA.imputations(yt_serie,imputado)
# plot(decompose(imputado)) 
# 
# 
# 
# 
# ytt = as.numeric(data[67,-1])
# plotNA.distribution(ytt)
# 
# ytt=ts(data =ytt, start = 1980, end = 2014, frequency = 365)
# 
# 
# imputado3 = na_seadec(ytt)
# plotNA.imputations(ytt,imputado2)
# plot(decompose(imputado3)) 
# 
# imputado4 = na_seadec(ytt)
# plotNA.imputations(ytt,imputado2)
# plot(decompose(imputado4)) 
# 
# 
# 
# 
# 
# library(imputeTestbench)
# system.time({
# prueba13<-impute_errors(yt_serie, smps = "mcar", methods = c("na_seasplit", "na_seadec"),
#               methodPath = NULL, errorParameter = "rmse", errorPath = NULL,
#               blck = 50, blckper = TRUE, missPercentFrom = 10,
#               missPercentTo = 90, interval = 10, repetition = 10,
#               addl_arg = NULL)
# })
# #"na.locf"
# plot_errors(prueba13)
# 
# plot_impute(prueba13)
###############################################################################################



library(imputeTS)
library(imputeTestbench)
library(tsbox)

j=data$X
for(i in seq(length(data$X)))
  {
    yt=as.numeric(data[i,-1])
    yt=ts(data =yt, start = 1980, end = 2013, frequency = 365)
    prueba <-statsNA(yt,printOnly= FALSE)
    print(prueba$percentageNAs)
    statsNA(yt,printOnly= FALSE)
    print(as.integer(substr(prueba$percentageNAs, 1, 2)))
    imputado3 = na_seadec(yt)
    plotNA.imputations(yt,imputado3)
    plot(decompose(imputado3))
    print(prueba$percentageNAs)
    p = ts_df(imputado3)
    nombre_salida= paste0("C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/relleno/",j[i],".csv")
    write.csv(p,file=nombre_salida,row.names=FALSE)
}

#p = ts_df(yt)
# 
# impute_errors(yt, 
#               methods = c( "na_seadec", "na_seasplit"),
#               methodPath = NULL, errorParameter = "rmse", errorPath = NULL,blck = 50,
#               blckper = TRUE, missPercentFrom = 10,missPercentTo = 90, interval = 10, 
#               repetition = 10,addl_arg = NULL)

#"na.locf",


# 
# 
# yt=as.numeric(data[2,-1])
# yt=ts(data =yt, start = 1980, end = 2014, frequency = 365)
# prueba <-statsNA(yt,printOnly= FALSE)
# print(prueba$percentageNAs)
# statsNA(yt,printOnly= FALSE)
# print(as.integer(substr(prueba$percentageNAs, 1, 2)))
# imputado3 = na_seadec(yt)
# plotNA.imputations(yt,imputado3)
# plot(decompose(imputado3))
# print(prueba$percentageNAs)
# nombre_salida= paste0("E:/0_Tesis/CIAT/Estaciones_Tesis/todas/relleno/",i,".csv")
# write.csv(imputado3,file=nombre_salida)
# 
# 
