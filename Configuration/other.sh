#!/bin/bash

# Vérifier si la nouvelle projection existe déjà dans le fichier JSON et ajouter si elle n'existe pas
echo "Vérification et ajout de la nouvelle entrée à la liste 'projections' dans le fichier JSON..."
if ! grep -q '"value": "EPSG:2975"' /etc/georchestra/datafeeder/frontend-config.json; then
    sed -i '/"projections": \[/a \
    {\
      "label": "RGR92 / UTM zone 40S",\
      "value": "EPSG:2975"\
    },' /etc/georchestra/datafeeder/frontend-config.json
    echo "Nouvelle entrée ajoutée à la liste 'projections'."
else
    echo "La projection 'EPSG:2975' existe déjà dans la liste 'projections'."
fi

echo "Mise à jour du fichier JSON terminée."

# Remplacement des valeurs dans le fichier XML
echo "Remplacement de 'codeListValue=\"eng\"' par 'codeListValue=\"fre\"' dans le fichier XML de datafeeder"
sed -i 's/codeListValue="eng"/codeListValue="fre"/g' /etc/georchestra/datafeeder/metadata_template.xml
echo "Remplacement dans le fichier XML terminé."

# Suppression du fichier header_bg.web et copie du fichier header_bg.webp
echo "Suppression du fichier header_bg.web et copie du fichier header_bg.webp..."
rm -f /etc/georchestra/datahub/assets/img/header_bg.web
cp header_bg.webp /etc/georchestra/datahub/assets/img/
echo "Fichier header_bg.web remplacé par header_bg.webp."

# Remplacement dans le fichier TOML pour les langues
echo "Remplacement de '# languages = ['en', 'fr', 'de']' par 'languages = ['en', 'fr', 'de']' dans le fichier TOML..."
sed -i "s/# languages = \['en', 'fr', 'de'\]/languages = \['en', 'fr', 'de'\]/" /etc/georchestra/datahub/conf/default.toml
echo "Remplacement dans le fichier TOML terminé."

# Remplacement de la couleur primaire dans le fichier TOML
echo "Remplacement de 'primary_color = \"#85127e\"' par 'primary_color = \"#0a397f\"' dans le fichier TOML..."
sed -i 's/primary_color = "#85127e"/primary_color = "#0a397f"/' /etc/georchestra/datahub/conf/default.toml
echo "Remplacement de la couleur primaire dans le fichier TOML terminé."

# Remplacement de la couleur secondaire dans le fichier TOML
echo "Remplacement de 'secondary_color = \"#1b1f3b\"' par 'secondary_color = \"#225ea8\"' dans le fichier TOML..."
sed -i 's/secondary_color = "#1b1f3b"/secondary_color = "#225ea8"/' /etc/georchestra/datahub/conf/default.toml
echo "Remplacement de la couleur secondaire dans le fichier TOML terminé."

# Suppression du commentaire et activation de la ligne dans le fichier TOML
echo "Remplacement de '# enabled = true' par 'enabled = true' pour activer le % de qualité de métadonnée"
sed -i 's/# enabled = true/enabled = true/' /etc/georchestra/datahub/conf/default.toml
echo "Activation de la ligne dans le fichier TOML terminée."

# Suppression des sections 'en' et 'it' dans le fichier JSON
#echo "Suppression des sections 'en' et 'it' dans le fichier JSON..."
#sed -i '/"en": {/,/},/d' /etc/georchestra/mapstore/configs/localConfig.json
#sed -i '/"it": {/,/},/d' /etc/georchestra/mapstore/configs/localConfig.json
#echo "Suppression des sections terminée."

# Vérifier si la nouvelle projection existe déjà dans la section 'projectionDefs' et ajouter si elle n'existe pas
echo "Vérification et ajout de la nouvelle projection à la section 'projectionDefs'..."
if ! grep -q '"code": "EPSG:2975"' /etc/georchestra/mapstore/configs/localConfig.json; then
    sed -i '/"projectionDefs": \[/a \
      "code": "EPSG:2975",\
      "def": "+proj=lcc +lat_1=48.5 +lat_2=49.5 +lat_0=48.0 +lon_0=-123.0 +x_0=1000000 +y_0=0 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs",\
      "extent": [-600000, 1500000, 1200000, 5000000],\
      "worldExtent": [-130, 24, -66, 49]\
    },{' /etc/georchestra/mapstore/configs/localConfig.json
    echo "Nouvelle projection ajoutée à la section 'projectionDefs'."
else
    echo "La projection 'EPSG:2975' existe déjà dans la section 'projectionDefs'."
fi

echo "Mise à jour du fichier terminé."
