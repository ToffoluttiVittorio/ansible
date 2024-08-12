#!/bin/bash

# Fonction pour échapper les caractères spéciaux dans une expression pour sed
escape_for_sed() {
    local input="$1"
    # Remplace les caractères spéciaux pour sed
    printf '%s\n' "$input" | sed 's/[.[\*^$]/\\&/g; s/[/]/\\\//g; s/|/\\|/g; s/[&]/\\&/g'
}

# Fonction pour remplacer une expression par une autre dans tout un fichier
replace_expression() {
    local file="$1"
    local old_expression="$2"
    local new_expression="$3"
    
    # Échapper les expressions pour sed
    local escaped_old=$(escape_for_sed "$old_expression")
    local escaped_new=$(escape_for_sed "$new_expression")
    
    # Remplacement de l'expression dans le fichier
    sed -i "s|${escaped_old}|${escaped_new}|g" "$file"
}

# Vérifie si le fichier de configuration est fourni en argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 config.txt"
    exit 1
fi

CONFIG_FILE="$1"

# Lecture du fichier de configuration et exécution des remplacements
while IFS=" " read -r action file old_expression new_expression; do
    # Ignore les lignes de commentaire
    if [[ "$action" == "#"* ]]; then
        continue
    fi

    case "$action" in
        replace_expression)
            replace_expression "$file" "$old_expression" "$new_expression"
            ;;
        *)
            echo "Unknown action: $action"
            ;;
    esac
done < "$CONFIG_FILE"
