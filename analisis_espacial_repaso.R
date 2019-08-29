

require(readxl)
require(rgdal)
require(raster)

comunas=shapefile("C:/Users/Usuario/Documents/Analisis_SPTemp/datos_olx/datos olx/Comunas/bcs_lim_comunas_WGS84.shp")
plot(comunas)
olx_viviendas_cali = read_excel("C:/Users/Usuario/Documents/Analisis_SPTemp/datos_olx/datos olx/olx_viviendas_cali.xlsx")
olx_viviendas_cali=data.frame(olx_viviendas_cali)
olx_viviendas_cali[,16]=as.numeric(olx_viviendas_cali[,16])
olx_viviendas_cali[,17]=as.numeric(olx_viviendas_cali[,17])

points(olx_viviendas_cali[,17:16],col="red")

require(rgdal)
olx_spatial=SpatialPointsDataFrame(coords = olx_viviendas_cali[,17:16],
                                   data = olx_viviendas_cali,
                                   proj4string= crs(comunas))
library(rgeos)
olx_spatial=intersect(olx_spatial,comunas)

plot(comunas)
plot(olx_spatial,add=T,col="red")
olx_spatial$Precio=olx_spatial$Precio/1000000
attach(olx_spatial@data)

boxplot(Precio~Estrato,col="gray")
tapply(Precio,Estrato,median)
tapply(Precio,Estrato,median)
tapply(Precio,paste(Estrato,Tipo),median)

Area_contruida=as.numeric(Area_contruida)
olx_spatial=olx_spatial[which(Area_contruida<1000),]

plot(olx_spatial$Precio,olx_spatial$Area_contruida)
olx_spatial$Area_contruida=as.numeric(olx_spatial$Area_contruida)

cor(olx_spatial$Precio,olx_spatial$Area_contruida)


#################################################################################################
###   Modelacion juan sebastian

mod1=lm(Precio~Area_contruida+as.factor(Estrato)+Tipo+Zona,data=olx_spatial@data)
summary(mod1)
par(mfrow=c(2,2))
plot(mod1)

mod2=lm(Precio~Area_contruida+Area_privada+as.factor(Estrato)+Tipo+Zona+piso+Baños+Habitaciones+COMUNA,data=olx_spatial@data)
summary(mod2)
par(mfrow=c(2,2))
plot(mod2)

mod3=lm(log(Precio)~Area_contruida+Area_privada+as.factor(Estrato)+Tipo+Zona+piso+Baños+Habitaciones+COMUNA,data=olx_spatial@data)
exp(mod3$coefficients)
summary(mod3)
par(mfrow=c(2,2))
plot(mod3)

#shapefile(olx_spatial,"C:/Users/Usuario/Documents/Analisis_SPTemp/datos_olx/olx_map.shp")


#################################################################################################
### modelacion profe David

mod1=lm(Precio~Area_contruida+as.factor(Estrato)+Tipo+Zona,data=olx_spatial@data)
summary(mod1)

par(mfrow=c(2,2))
plot(mod1)

mod2=lm(log(Precio)~Area_contruida+as.factor(Estrato)+Tipo+Zona,data=olx_spatial@data)
summary(mod2)

exp(mod2$coefficients)
par(mfrow=c(2,2))
plot(mod2)

mod3=lm(log(Precio)~Area_contruida+as.factor(Estrato)+Tipo+Zona+Habitaciones+parqueaderos+Baños,data=olx_spatial@data)
summary(mod3)
par(mfrow=c(2,2))
plot(mod3)

mod4=lm(log(Precio)~Area_contruida+as.factor(Estrato)+Tipo+Zona+Habitaciones+parqueaderos+Baños+as.factor(COMUNA),data=olx_spatial@data)
summary(mod4)
par(mfrow=c(2,2))
plot(mod4)

AIC(mod1,mod2,mod3,mod4)  ##Akaike - mas pequeño mejor
BIC(mod1,mod2,mod3,mod4)  ##Bayesiano -mas pequeño mejor

shapefile(olx_spatial,"Documents/Univalle 2019-1.1/Datos Espaciales/olx_map.shp")



#################################################################################################
###       Repaso patrones puntuales

# construir covariables para cada predio como: total de homicidios por predio en un buffer de 500m

homicidios=shapefile("C:/Users/Usuario/Documents/Analisis_SPTemp/datos_olx/datos olx/Hurtos2017/2017_0_WGS84.shp")
plot(comunas)
points(olx_spatial,cex=0.2,col="blue")
points(homicidios,cex=0.2,col="red")

require(spatstat)
extent(comunas)

patron_olx=ppp(x = olx_spatial$cordenada_longitud,y = olx_spatial$Cordenada_latitud,
               window = owin(c(-76.59076,-76.46125),c(3.331819,3.505871)),marks = olx_spatial$Precio)

##Este mismo analisis pero aparte para casas y apartamento
patron_olx=ppp(x = olx_spatial$cordenada_longitud,y = olx_spatial$Cordenada_latitud,
               window = owin(c(-76.59076,-76.46125),c(3.331819,3.505871)))

window()
plot(patron_olx)

olx_densidad=density(patron_olx,0.005)
plot(olx_densidad)

olx_density_map=rasterFromXYZ(data.frame(olx_densidad)[,1:3])
olx_density_map=mask(olx_density_map,comunas)
plot(olx_density_map)
plot(comunas,add=T)


