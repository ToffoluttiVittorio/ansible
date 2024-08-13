#!/bin/bash

# Mise à jour du fichier JSON
echo "Ajout de la nouvelle entrée à la liste 'projections' dans le fichier JSON..."
sed -i '/"projections": \[/a \    {\n      "label": "New Projection",\n      "value": "EPSG:2975"\n    },' /etc/georchestra/datafeeder/frontend-config.json
echo "Mise à jour du fichier JSON terminée."

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

# Remplacement des valeurs dans le fichier XML
echo "Remplacement de 'codeListValue=\"eng\"' par 'codeListValue=\"fre\"' dans le fichier XML..."
sed -i 's/codeListValue="eng"/codeListValue="fre"/g' /etc/georchestra/datafeeder/metadata.xml
echo "Remplacement dans le fichier XML terminé."

# Suppression du fichier header_bg.web et copie du fichier header_bg.webp
echo "Suppression du fichier header_bg.web et copie du fichier header_bg.webp..."
rm -f /etc/georchestra/datahub/assets/img/header_bg.web
cp header_bg.webp /etc/georchestra/datahub/assets/img/
echo "Fichier header_bg.web remplacé par header_bg.webp."

# Remplacement dans le fichier TOML pour les langues
echo "Remplacement de '# languages = ['en', 'fr', 'de']' par 'languages = ['en', 'fr', 'de']' dans le fichier TOML..."
sed -i 's/# languages = \[\'en\', \'fr\', \'de\'\]/languages = \[\'en\', \'fr\', \'de\'\]/g' /etc/georchestra/datahub/conf/default.toml
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
echo "Remplacement de '# enabled = true' par 'enabled = true' dans le fichier TOML..."
sed -i 's/# enabled = true/enabled = true/' /etc/georchestra/datahub/conf/default.toml
echo "Activation de la ligne dans le fichier TOML terminée."
