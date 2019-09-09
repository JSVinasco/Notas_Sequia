
#grass76 C:\Users\Usuario\Documents\Sequia\Tesis_Guajira\Tesis_Guajira\PERMANENT

'''
8day_ts@PERMANENT
ET@PERMANENT
LAI@PERMANENT
P8d_agg@PERMANENT
Precipitacion@PERMANENT
et@PERMANENT
et_pre@PERMANENT
evi_esc@PERMANENT
evi_pre@PERMANENT
lai_pre@PERMANENT
lst_esc@PERMANENT
lst_pre@PERMANENT
mir_esc@PERMANENT
mir_pre@PERMANENT
ndvi_esc@PERMANENT
ndvi_pre@PERMANENT
nir_esc@PERMANENT
nir_pre@PERMANENT'''


#########################################
# definimos las funciones de grass format - numpy y viceversa

import numpy as np

from grass.pygrass.raster.buffer import Buffer
from grass.pygrass.gis.region import Region

def raster2numpy(rastname, mapset=''):
    """Return a numpy array from a raster map"""
    with RasterRow(rastname, mapset=mapset, mode='r') as rast:
        return np.array(rast)


def numpy2raster(array, mtype, rastname, overwrite=False):
    """Save a numpy array to a raster map"""
    reg = Region()
    if (reg.rows, reg.cols) != array.shape:
        msg = "Region and array are different: %r != %r"
        raise TypeError(msg % ((reg.rows, reg.cols), array.shape))
    with RasterRow(rastname, mode='w', mtype=mtype, overwrite=overwrite) as new:
        newrow = Buffer((array.shape[1],), mtype=mtype)
        for row in array:
            newrow[:] = row[:]
            new.put_row(newrow)


################################################################################
################################################################################

# importamos las librerias para el procesamiento


from grass.pygrass.raster import RasterRow
import matplotlib.pyplot as plt
import grass.temporal as tgis
import datetime

# realizamos la conexion con la base de datos temporal
tgis.init()
dbif = tgis.SQLDatabaseInterfaceConnection()
dbif.connect()
'''
# creamos el strds que debemos rellenar
ndwi = 'nddi'
dataset = tgis.open_new_stds(name=ndwi, type='strds', temporaltype='absolute',
                             title="NDWI MODIS 8 dias", descr="NDWI de Modis cada 8 dias",
                             semantic='mean', overwrite=True)
'''
dataset_name = 'nddi@PERMANENT'
dataset = tgis.open_old_stds(dataset_name, "strds",dbif=dbif)

# Confirmamos la creacion del STRDS
dataset.print_shell_info()



# abrimos los antiguos strds para el calculo

#nir
ndwi = 'ndwi@PERMANENT'
ndwi_strds = tgis.open_old_stds(ndwi, "strds",dbif=dbif)
ndwi_strds.get_registered_maps(columns='name,start_time')
num_ndwi = len(ndwi_strds.get_registered_maps(columns='name,start_time'))
#dtdelta = datetime.timedelta(days = int(7))

#mir
ndvi = 'ndvi_esc@PERMANENT'
ndvi_strds = tgis.open_old_stds(ndvi, "strds",dbif=dbif)
ndvi_strds.get_registered_maps(columns='name,start_time')
num_ndvi = len(ndvi_strds.get_registered_maps(columns='name,start_time'))


# calculamos el ndwi

for i in range(num_ndvi):
    fec1 = ndwi_strds.get_registered_maps(columns='name,start_time')[i][1]
    ndwi_raster= ndwi_strds.get_registered_maps(columns='name,start_time')[i][0]
    ndwi_map= raster2numpy(ndwi_raster, mapset='PERMANENT')
    fec2 = ndvi_strds.get_registered_maps(columns='name,start_time')[i][1]
    ndvi_raster= ndvi_strds.get_registered_maps(columns='name,start_time')[i][0]
    ndvi_map= raster2numpy(ndvi_raster, mapset='PERMANENT')
    nddi = (ndvi_map-ndwi_map)/(ndvi_map+ndwi_map)
    print(nddi)
    #nombre='NDDI_'+str(i)+'_'
    #numpy2raster(nddi, mtype='FCELL', rastname=nombre, overwrite=True)
    #fech=fec1
    #fecha = fech.strftime("%Y") +'-'+fech.strftime("%m")+'-'+fech.strftime("%d")
    #tgis.register_maps_in_space_time_dataset(type='raster',name=dataset_name,maps=nombre,start=fecha,interval=True,update_cmd_list=True)

    #dataset.update_from_registered_maps()
    #dataset.print_shell_info()




# mostramos la librerias instaladas

import torch
print('torch version:')
print(torch.__version__)
import sklearn
print('sklear version:')
print(sklearn.__version__)
import xgboost
print('xgboost version:')
print(xgboost.__version__)
import pickle
print('pickle version:')
#pickle.__version__














'''

for i in range(num-1):
    fec= strds.get_registered_maps(columns='name,start_time')[i][1]
    raster= strds.get_registered_maps(columns='name,start_time')[i][0]
    #map = garray.array(mapname=raster)
    #map = RasterRow(raster,mapset='PERMANENT')
    map= raster2numpy(raster, mapset='PERMANENT')
    fecha2= strds.get_registered_maps(columns='name,start_time')[i+1][1]
    raster2= strds.get_registered_maps(columns='name,start_time')[i+1][0]
    #map2 = garray.array(mapname=raster2)
    map2= raster2numpy(raster2, mapset='PERMANENT')
    prom = (map+map2)/2
    nombre='EVI_relleno_'+str(i)+'_'
    #prom.write(mapname=nombre, overwrite=True)
    numpy2raster(prom, mtype='FCELL', rastname=nombre, overwrite=True)
    #promedio.append(prom)
    fech=fec+dtdelta
    fecha = fech.strftime("%Y") +'-'+fech.strftime("%m")+'-'+fech.strftime("%d")
    tgis.register_maps_in_space_time_dataset(type='raster',name=nombre,maps=nombre,start=fecha,interval=True,update_cmd_list=True)
    dataset.update_from_registered_maps()
    dataset.print_shell_info()
'''
