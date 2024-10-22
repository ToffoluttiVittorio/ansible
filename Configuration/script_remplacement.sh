#!/bin/bash

# Mise à jour du fichier de propriétés pour le changement de langue
echo "Remplacement de 'language=en' par 'language=fr' dans le fichier de propriétés..."
sed -i 's/language=en/language=fr/' /etc/georchestra/default.properties
echo "Mise à jour du fichier de propriétés terminée."

# Mise à jour du fichier de propriétés pour le changement d'URL du logo
echo "Remplacement de l'URL du logo dans le fichier de propriétés..."
sed -i 's|logoUrl=https://www.georchestra.org/public/georchestra-logo.svg|logoUrl=https://raw.githubusercontent.com/ToffoluttiVittorio/ansible/master/Configuration/georchestra-logo.svg|' /etc/georchestra/default.properties
echo "Mise à jour de l'URL du logo terminée."

# Remplacement de l'URL de la feuille de style commentée dans le fichier de propriétés
echo "Remplacement de l'URL de la feuille de style commentée dans le fichier de propriétés..."
sed -i 's|# georchestraStylesheet=http://my-domain-name/stylesheet.css|georchestraStylesheet=./stylesheet.css|' /etc/georchestra/default.properties
echo "Mise à jour de l'URL de la feuille de style terminée."

# Activation des analytics dans le fichier de propriétés
echo "Activation des analytics dans le fichier de propriétés..."
sed -i 's/analyticsEnabled=false/analyticsEnabled=true/' /etc/georchestra/default.properties
echo "Activation des analytics terminée."

# Mise à jour de la timezone dans le fichier de propriétés
echo "Remplacement de la timezone dans le fichier de propriétés..."
sed -i 's|#localTimezone=Europe/Paris|localTimezone=Indian/Reunion|' /etc/georchestra/analytics/analytics.properties
echo "Mise à jour de la timezone terminée."

# Traduction des valeurs de orgTypeValues dans le fichier de propriétés
echo "Remplacement des valeurs de orgTypeValues par leur traduction en français..."
sed -i 's/orgTypeValues=Association,Company,NGO,Individual,Other/orgTypeValues=Association,Entreprise,ONG,Individu,Autre/' /etc/georchestra/console/console.properties
echo "Traduction des valeurs de orgTypeValues terminée."

# Ajout de l'option print dans Mapstore
CONFIG_FILE="/srv/tomcat/proxycas/bin/setenv.sh"
# Vérifier si la ligne JAVA_OPTS="$JAVA_OPTS -DPRINT_BASE_URL=pdf" existe déjà
if grep -q 'JAVA_OPTS="$JAVA_OPTS -DPRINT_BASE_URL=pdf"' "$CONFIG_FILE"; then
    echo "La ligne JAVA_OPTS est déjà présente dans le fichier."
else
    echo "Ajout de la ligne JAVA_OPTS dans le fichier."
    echo 'JAVA_OPTS="$JAVA_OPTS -DPRINT_BASE_URL=pdf"' >> "$CONFIG_FILE"
    echo "Ligne ajoutée avec succès."
fi

# Modification du zoom et du centre dans le fichier de configuration
echo "Modification du zoom et du centre dans le fichier /etc/georchestra/mapstore/configs/config.json..."
# Remplacer le zoom par 9
sed -i 's/"zoom": [0-9]\+\,/"zoom": 10\,/g' "/etc/georchestra/mapstore/configs/config.json"
# Remplacer les coordonnées X du centre par 651719.38
sed -i 's/"x": [0-9\.]\+\,/"x": 651719.38\,/g' "/etc/georchestra/mapstore/configs/config.json"
# Remplacer les coordonnées Y du centre par -2223657.28
sed -i 's/"y": [-0-9\.]\+\,/"y": -2223657.28\,/g' "/etc/georchestra/mapstore/configs/config.json"
echo "Le zoom et le centre de la carte ont été mis à jour."

# Suppression du fichier print_header.png et copie du fichier print_header.png du fichier de config
echo "Suppression du fichier print_header.png et copie du fichier print_header.jpg..."
rm -f /etc/georchestra/mapstore/printing/print_header.png
cp print_header.png /etc/georchestra/mapstore/printing/
echo "Fichier print_header.png supprimé et print_header.jpg copié."

# Suppression du fichier stylesheet.css et copie du fichier stylesheet.css
echo "Suppression du fichier stylesheet.css et copie du fichier stylesheet.css..."
rm -f /etc/georchestra/stylesheet.css
cp stylesheet.css /etc/georchestra/
echo "Fichier stylesheet.css supprimé et copié dans /etc/georchestra."
