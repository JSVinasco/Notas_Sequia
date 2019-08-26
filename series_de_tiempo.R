##############################
###   Series de Tiempo    ###
##############################

################################
##Analisis de Series de Tiempo##
################################
require(TSA)
require(forecast)
require(ggplot2)
require(plotly)

##Control de Calidad a la Serie
plot(AirPassengers)
AirPassengers2=AirPassengers
AirPassengers2[100:112]=NA
plot(AirPassengers2)
AirPassengers2=tsclean(AirPassengers2)
plot(AirPassengers)
lines(AirPassengers2,col="red")
RMSE=sqrt(sum((AirPassengers2[100:112]-AirPassengers[100:112])^2))/length(100:112)

##Graficas Exploratorias para Identificacion
plot(decompose(AirPassengers))  ##Descomposicion de la serie
ggtsdisplay(AirPassengers, plot.type="scatter", theme=theme_bw()) ##Autocorrelacion AR1
tsdisplay(AirPassengers) ##FAC y FACP serie original
tsdisplay(diff(AirPassengers)) ##FAC y FACP serie diferenciada lag1
tsdisplay(diff(AirPassengers,lag=6)) ##FAC y FACP serie diferenciada lag6
tsdisplay(diff(AirPassengers,lag=12)) ##FAC y FACP serie diferenciada lag12

##Estimacion de Modelos y Pronosticos
air.model.auto=auto.arima(AirPassengers)
plot(forecast(air.model.auto,h=48))
air.model=Arima(AirPassengers,order=c(0,1,1),seasonal=list(order=c(0,1,1),period=12))
plot(forecast(air.model,h=48))
air.model.mal=Arima(AirPassengers,order=c(1,0,0))
plot(forecast(air.model.mal,h=48))

##Validacion Modelos
tsdisplay(air.model.auto$residuals)
tsdisplay(air.model$residuals)
tsdisplay(air.model.mal$residuals)





################################################################################################
yt  = AirPassengers[-144]
yt1 = AirPassengers[-1]

plot(yt,yt1)
cor(yt,yt1)

t=1:143
mod=lm(yt~t)
summary(mod)


#Pasajeros=87+(2.6*mes)





################################################################################################



data()
w=wineind
##Graficas Exploratorias para Identificacion
plot(decompose(w))  ##Descomposicion de la serie
ggtsdisplay(w, plot.type="scatter", theme=theme_bw()) ##Autocorrelacion AR1
tsdisplay(w) ##FAC y FACP serie original
tsdisplay(diff(w)) ##FAC y FACP serie diferenciada lag1
tsdisplay(diff(w,lag=6)) ##FAC y FACP serie diferenciada lag6
tsdisplay(diff(w,lag=12)) ##FAC y FACP serie diferenciada lag12

descom_wine=decompose(wineind)

#   grafico interactivo


require(plotly)

#wine=as.vector(wineind)
descom_wine2=as.vector(descom_wine$trend)
time = 1:176
#plot_ly(x = ~time)%>%add_lines(y=~wine)
plot_ly(x = ~time)%>%add_lines(y=~descom_wine2)

#######################################################################################

#  Dengue

multiTimeline <- read.csv("C:/Users/Usuario/Downloads/multiTimeline.csv", comment.char="#")
View(multiTimeline)

dengue = as.numeric(multiTimeline$CategorÃ.a..Todas.las.categorÃ.as)

dengue_serie=ts(data=dengue, start = 2004, end=2019, frequency = 12)
plot(decompose(dengue_serie))


#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################



################################
##Analisis de Series de Tiempo##
################################
https://codeshare.io/5M3OO3

require(TSA)
require(forecast)
require(ggplot2)
require(plotly)

##Control de Calidad a la Serie
class(AirPassengers)
plot(AirPassengers)
AirPassengers2=AirPassengers
AirPassengers2[100:112]=NA
plot(AirPassengers2)
AirPassengers2=tsclean(AirPassengers2)
plot(AirPassengers)
lines(AirPassengers2,col="red")
RMSE=sqrt(sum((AirPassengers2[100:112]-AirPassengers[100:112])^2))/length(100:112)
RMSE
##Graficas Exploratorias para Identificacion
plot(decompose(AirPassengers))  ##Descomposicion de la serie
ggtsdisplay(AirPassengers, plot.type="scatter", theme=theme_bw()) ##Autocorrelacion AR1
tsdisplay(AirPassengers) ##FAC y FACP serie original
tsdisplay(diff(AirPassengers)) ##FAC y FACP serie diferenciada lag1
tsdisplay(diff(AirPassengers,lag=6)) ##FAC y FACP serie diferenciada lag6
tsdisplay(diff(AirPassengers,lag=12)) ##FAC y FACP serie diferenciada lag12

##Estimacion de Modelos y Pronosticos
air.model.auto=auto.arima(AirPassengers)
plot(forecast(air.model.auto,h=48))
air.model=Arima(AirPassengers,order=c(0,1,1),seasonal=list(order=c(0,1,1),period=12))
plot(forecast(air.model,h=48))
air.model.mal=Arima(AirPassengers,order=c(1,0,0))
plot(forecast(air.model.mal,h=48))

##Validacion Modelos
tsdisplay(air.model.auto$residuals)
tsdisplay(air.model$residuals)
tsdisplay(air.model.mal$residuals)

##Poder de Pronostico
AirPassengers_mod=AirPassengers[-c(134:144)]
AirPassengers_mod=ts(data=AirPassengers_mod,start=1949,end=1960,frequency = 12)
AirPassengers_real=AirPassengers[c(134:144)]
air.model.auto2=auto.arima(AirPassengers_mod)
plot(forecast(air.model.auto2,h=11))
pronostico=forecast(air.model.auto2,h=11)

mean(AirPassengers_real)
mean(abs(pronostico$mean-AirPassengers_real))
16/481

tsdisplay(air.model.auto2$residuals)


## Taller 
# realizar analisis con el conjunto de datos wineind

# 1. Explorar la serie (Tendencia, estacionalidad)

# 2. Identificar el modelo apropiado (ARIMA, compoarar con auto arima)

# 3. Pronosticar 7 periodos adelante

# 4. Calcular el error medio absoluto


#ARIMA pripuesto
#AR(3)
#I(1)
#MA(2)
#- SEASONAL (,I=1)[12]
