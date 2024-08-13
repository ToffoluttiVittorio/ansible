#!/bin/bash

# Suppression des blocs 'en' et 'it'
echo "Suppression des blocs 'en' et 'it' dans le fichier JSON..."
sed -i '/"en": {/,/description": "English"/{N;N;N;d;}}' /etc/georchestra/mapstore/configs/localConfig.json
sed -i '/"it": {/,/description": "Italiano"/{N;N;N;d;}}' /etc/georchestra/mapstore/configs/localConfig.json

# Nettoyage des virgules résiduelles
echo "Nettoyage des virgules résiduelles..."
sed -i '/},/d' /etc/georchestra/mapstore/configs/localConfig.json

# Ajouter la nouvelle projection à la section 'projectionDefs'
echo "Ajout de la nouvelle projection à la section 'projectionDefs'..."
sed -i '/"projectionDefs": \[/a \
    {\
      "code": "EPSG:2975",\
      "def": "+proj=lcc +lat_1=48.5 +lat_2=49.5 +lat_0=48.0 +lon_0=-123.0 +x_0=1000000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs",\
      "extent": [-600000, 1500000, 1200000, 5000000],\
      "worldExtent": [-130, 24, -66, 49]\
    },\
' /etc/georchestra/mapstore/configs/localConfig.json

echo "Modifications terminées."
