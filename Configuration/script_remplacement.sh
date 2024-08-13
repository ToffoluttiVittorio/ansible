#!/bin/bash

# Mise à jour du fichier de propriétés pour le changement de langue
echo "Remplacement de 'language=en' par 'language=fr' dans le fichier de propriétés..."
sed -i 's/language=en/language=fr/' /etc/georchestra/default.properties
echo "Mise à jour du fichier de propriétés terminée."

# Mise à jour du fichier de propriétés pour le changement d'URL du logo
echo "Remplacement de l'URL du logo dans le fichier de propriétés..."
sed -i 's|logoUrl=https://www.georchestra.org/public/georchestra-logo.svg|logoUrl=https://raw.githubusercontent.com/ToffoluttiVittorio/datadir/24.0/georchestra-logo.svg|' /etc/georchestra/default.properties
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
