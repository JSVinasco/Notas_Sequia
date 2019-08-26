# -*- coding: utf-8 -*-
"""
Created on Tue Jul  2 11:40:15 2019

@author: JUANSE
"""

# importamos las librerias necesarias

import os
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

#establecemos un directorio de trabajo

os.chdir("C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/")
ruta = "C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/"
text_files = [f for f in os.listdir(ruta) if f.endswith('_qc_prec.txt')]
#text_files = [f for f in os.listdir(ruta) if f.endswith('_qc_tmax.txt')]
#text_files = [f for f in os.listdir(ruta) if f.endswith('_raw_tmin.txt')]




'''
estacion = pd.read_csv(text_files[0], sep="	", parse_dates=["Date"],
                       index_col="Date")
#############
# graficamos#
#############
estacion.plot()
estacion[estacion>0].plot()
estacion.hist( bins=30, edgecolor='#4aaaaa', color='#80BCD8')
estacion[estacion>0].hist( bins=30, edgecolor='#4aaaaa', color='#80BCD8')
       
########################
# analisis de tendencia#
########################
        
# diagrama de caja
estacion[estacion['Value']>0].boxplot('Value')

# diagrama de densidad
estacion[estacion['Value']>0].plot.density()

# diagrama de dispersión
plt.scatter(estacion[estacion['Value']>0].index,estacion[estacion['Value']>0]['Value'])

# diagrama de violin
plt.violinplot(estacion[estacion['Value']>0].index,estacion[estacion['Value']>0]['Value'])

#################################
#frecuencias y tiempo de retorno#        
#################################

        
#hallamos el promedio y la desviación
promedio = estacion[estacion>0].mean()
desviacion = estacion[estacion>0].std()
print(promedio, desviacion)

#determinamos las regresiones estadisticas
tabulaciones = np.arange(-40,51,0.1)
distnormal = stats.norm.pdf(tabulaciones, 
                            loc=promedio, scale=desviacion)
distlognormal = stats.pearson3.pdf(tabulaciones,skew=1,
                                   loc=promedio, scale=desviacion)
distweibull = stats.dweibull.pdf(tabulaciones,c=1,
                                   loc=promedio, scale=desviacion)
distchi2 = stats.chi2.pdf(tabulaciones,df=2,
                                   loc=promedio, scale=desviacion)


#ploteamos los datos
estacion[estacion>0].hist(bins=100, normed=True, edgecolor='#4aaaaa', color='#80BCD8')
plt.plot(tabulaciones,distnormal, color='#4B4C4E', linewidth=5, linestyle='--',label='Dist Normal')
plt.plot(tabulaciones,distlognormal, color='#3F83B7', linewidth=5, linestyle='--', label='Dist Lognormal')
plt.plot(tabulaciones,distweibull, color='#7B7C7E', linewidth=5, linestyle='-.', label='Dist Weibull')
plt.plot(tabulaciones,distchi2, color='#3F83B7', linewidth=5, linestyle=':', label='Dis Chi2')
plt.xlim(0,200)
plt.legend(loc='upper right')
#plt.figsize(21,14)


'''
######################
# analisis en bloque #
######################


#concatenar todas las estaciones

'''
df = pd.concat([pd.read_csv(f, sep="	", 
                            parse_dates=["Date"]) for f in text_files], 
                            ignore_index = True)
'''

dfs = (pd.read_csv(fname,sep="	",parse_dates=["Date"]) for fname in text_files)


master_df = pd.concat(
    (df[[c for c in df.columns if c.lower().startswith('folder')]]
        for df in dfs), axis=1)




####################3

#text_files = [f for f in os.listdir(ruta) if f.endswith('_raw_prec.txt')]

# saber que estaciones leer

posicion = pd.read_csv("C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/estaciones_guajira_2019_2.csv")

meej = str(posicion.id).split("_")

m= []

for i in range(len(posicion.id)):
    jk = str(posicion.id[i])#.split("_")
    m.append(jk)

m= np.asarray(m)


m = [int(i) for i in m]
n=[]
for i in range(len(text_files)):
    l= text_files[i].split("_")[0]
    n.append(l)
n=np.asarray(n)
n = [int(i) for i in n]

# concatenar
este=1
h = []
for i in (range(len(text_files))):
    if n[i] in m:
        estacion = pd.read_csv(text_files[i], sep="	", parse_dates=["Date"],
                       index_col="Date")
        columna =  str(n[i])
        estacion = estacion.rename(columns={'Value' : columna })
        k=i
        h.append(k)
        if i<=57:
            est=estacion
        else:
            est = pd.concat([est,estacion],axis=1)
    else:
        este=este+1
        print("este no")


est.to_csv('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est_prec_qc.csv',sep=';', na_rep='NA')

#est.to_csv('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est_tmax.csv',sep=';', na_rep='NA')

#est.to_csv('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est_tmin.csv',sep=';', na_rep='NA')




est.to_excel('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est.xlsx', na_rep='NA')


est.ix['1968-02-01':'2015-02-28'].plot(subplots=True, figsize=(100, 50)); plt.legend(loc='best')

est.iloc[:,30].plot()


est[est>=0].plot(legend=False)


###############################################################################

# Filtramos para que tengan al menos el 80% de los datos validos


# primero filtramos las columnas que tienen mas del 20% de nodata

est2 = est.loc[:, est.isnull().mean() < .8]

print (est.head())

est['year'] = pd.DatetimeIndex(est['Date']).year


estt = pd.read_csv('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est_prec_qc.csv',sep=';',parse_dates=["Date"])

#estt = pd.read_csv('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est_tmax.csv',sep=';',parse_dates=["Date"])


#estt = pd.read_csv('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/est_tmin.csv',sep=';',parse_dates=["Date"])

for col in estt.columns: 
    print(col) 

estt['year'] = estt['Date'].dt.year
estt['month'] = estt['Date'].dt.month
estt['day'] = estt['Date'].dt.day 


estt.to_excel('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/estt_prec_qc.xlsx', na_rep='NA')

#estt.to_excel('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/estt_tmax.xlsx', na_rep='NA')

#estt.to_excel('C:/Users/Usuario/Documents/Sequia/acomodar_estaciones/todas/estt_tmin.xlsx', na_rep='NA')










