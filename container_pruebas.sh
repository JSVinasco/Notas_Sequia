#Hola!
#Este es un correo preparatorio para la sección de hoy:

Para empezar se modifico la imagen de docker suministrada por la empresa mundialis/grass-py3-pdal.
Y se le agrego algunas librerias de machine learning.
Esta nueva imagen se subio a docker hub y se denomino :
jsvinasco/grass-py3-ml1

#esta imagen se puede ejecutar de manera local siguiendo la siguiente linea de comado:

docker pull jsvinasco/grass-py3-ml1

#PD: el container es pesado, pero aun no sabemos por que exactamente.
#Luego de varias pruebas logramos ejecutar de manera local GRASS GIS 7.7 con los datos de la tesis en los siguientes modos:

# correr de manera interactiva

sudo docker run -it --rm -v $(pwd):/grassdb/ jsvinasco/grass-py3-ml1 grass -text Tesis_Guajira/PERMANENT

# probemos con python

sudo docker run -it --rm -v $(pwd):/grassdb/ jsvinasco/grass-py3-ml1 grass -text Tesis_Guajira/PERMANENT

# bash

sudo docker run -it --rm -v $(pwd):/grassdb/ jsvinasco/grass-py3-ml1 grass -text Tesis_Guajira/PERMANENT  --exec bash prueba_grass_container.sh

#Nota: notesé que en el comando anterior no se ejecuta con la sintaxis usual '/bin/bash/', pues la ejecución de grass -text es de por si una #ejecución en bash ya configurada para funcionar con datos geográficos.

