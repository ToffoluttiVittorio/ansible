#!/bin/bash

# Copier le fichier stylesheet.css dans les répertoires de destination
echo "Copie du fichier stylesheet.css dans les répertoires de destination..."

# Répertoires de destination
DESTINATIONS=(
  "/var/www/georchestra/htdocs/datahub/"
  "/srv/tomcat/georchestra/webapps/analytics/WEB-INF/jsp/"
  "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/themes/georchestra/"
  "/srv/tomcat/georchestra/webapps/console/account/"
)

# Boucle pour copier le fichier dans chaque répertoire
for DEST in "${DESTINATIONS[@]}"; do
  cp ./stylesheet.css "$DEST"
  echo "Fichier stylesheet.css copié avec succès dans $DEST."
done

# Remplacement des couleurs dans le fichier CSS
echo "Remplacement des couleurs dans le fichier CSS..."

# Remplacer #540069 par #0a397f
sed -i 's/#540069/#0a397f/g' "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/themes/georchestra/css/cas.css"

# Remplacer #720e9e par #0a397f
sed -i 's/#720e9e/#0a397f/g' "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/themes/georchestra/css/cas.css"

# Remplacer #845490 par #225ea8
sed -i 's/#845490/#225ea8/g' "/srv/tomcat/proxycas/webapps/cas/WEB-INF/classes/static/themes/georchestra/css/cas.css"

echo "Remplacement des couleurs terminé."

# Remplacement des valeurs de langue dans le fichier JSP
echo "Remplacement des valeurs de langue dans le fichier JSP..."

# Remplacer lang = forcedLang par lang = "fr"
sed -i 's/lang = forcedLang/lang = "fr"/g' "/srv/tomcat/georchestra/webapps/analytics/WEB-INF/jsp/index.jsp"

# Remplacer lang = detectedLanguage par lang = "fr"
sed -i 's/lang = detectedLanguage/lang = "fr"/g' "/srv/tomcat/georchestra/webapps/analytics/WEB-INF/jsp/index.jsp"

echo "Remplacement des valeurs de langue terminé."

# Changement de couleurs dans le css de mapstore
echo "Changement de couleurs dans le css de mapstore"
sed -i 's/#85127e/#0a397f/g' /srv/tomcat/georchestra/webapps/mapstore/dist/themes/default.css

echo "Changement de couleurs dans le css de mapstore terminé."
