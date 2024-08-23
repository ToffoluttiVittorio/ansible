#!/bin/bash

# Copier le fichier stylesheet.css dans les répertoires de destination
echo "Copie du fichier stylesheet.css dans les répertoires de destination..."

# Répertoires de destination
DESTINATIONS=(
  "/var/www/georchestra/htdocs/datahub/"
  "/srv/tomcat/georchestra/webapps/analytics/"
  "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/"
  "/srv/tomcat/georchestra/webapps/console/account/"
)

# Boucle pour copier le fichier dans chaque répertoire
for DEST in "${DESTINATIONS[@]}"; do
  cp ./stylesheet.css "$DEST"
  echo "Fichier stylesheet.css copié avec succès dans $DEST."
done

# Remplacement des couleurs dans le fichier CSS
echo "Remplacement des couleurs dans le fichier cas.css"
# Remplacer #540069 par #0a397f
sed -i 's/#540069/#0a397f/g' "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/themes/georchestra/css/cas.css"
# Remplacer #720e9e par #0a397f
sed -i 's/#720e9e/#0a397f/g' "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/themes/georchestra/css/cas.css"
# Remplacer #845490 par #225ea8
sed -i 's/#845490/#225ea8/g' "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/themes/georchestra/css/cas.css"
echo "Remplacement des couleurs terminé."

# Remplacement des valeurs de langue dans le fichier JSP
#echo "Remplacement des valeurs de langue dans le fichier JSP..."

# Remplacer lang = forcedLang par lang = "fr"
#sed -i 's/lang = forcedLang/lang = "fr"/g' "/srv/tomcat/georchestra/webapps/analytics/WEB-INF/jsp/index.jsp"

# Remplacer lang = detectedLanguage par lang = "fr"
#sed -i 's/lang = detectedLanguage/lang = "fr"/g' "/srv/tomcat/georchestra/webapps/analytics/WEB-INF/jsp/index.jsp"

#echo "Remplacement des valeurs de langue terminé."

# Changement de couleurs dans le css de mapstore
echo "Changement de couleurs dans le css de mapstore"
sed -i 's/#85127e/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css

echo "Changement de couleurs dans le css de mapstore terminé."


# Changement du header de datahub
echo "Changement du header de datahub"
# Chemin vers votre fichier HTML
file="/var/www/georchestra/htdocs/datahub/index.html"

# Attributs à vérifier
attr_check="lang='fr' stylesheet='./stylesheet.css' logo-url='./georchestra-logo.svg'"

# Vérifier si la balise <geor-header> avec les attributs existe déjà
if grep -q "<geor-header.*$attr_check.*>" "$file"; then
  echo "Les attributs existent déjà dans la balise <geor-header>."
else
  echo "Les attributs n'existent pas. Ajout en cours..."
  # Commande sed pour ajouter les attributs
  sed -i "s/<geor-header active-app='datahub' legacy-header='false' legacy-url='\/header\/' style='height:90px'>/<geor-header active-app='datahub' legacy-header='false' legacy-url='\/header\/' lang='fr' stylesheet='.\/stylesheet.css' logo-url='.\/georchestra-logo.svg' style='height:90px'>/g" "$file"
  echo "Les attributs ont été ajoutés."
fi

#Ajout du logo pour le header de datahub
echo "Ajout du logo pour le header de datahub"
cp ./georchestra-logo.svg /var/www/georchestra/htdocs/datahub/
echo "Ajout du logo pour le header de mapstore terminé"

#Changement du favicon 
echo "Remplacement du favicon" 
rm /var/www/georchestra/htdocs/favicon.ico
cp ./favicon.ico /var/www/georchestra/htdocs/favicon.ico
echo "Ramplacement du favicon" 

#Changement des couleurs de mapstore 
echo "Changement des couleurs pour mapstore"
sed -i 's/#6f0f69/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#ed76e5/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#df1ed3/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#708/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#d97fff/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#6e296a/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#800080/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#b218a9/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#610/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#d5c/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#8e1387/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#7c1175/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#42093e/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#150314/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#390836/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#4f0b46/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#680c63/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#73106d/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
sed -i 's/#73106d/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css
echo "Changement des couleur terminés" 

