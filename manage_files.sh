#!/bin/bash

# Activer le mode de débogage pour afficher chaque commande avant son exécution
set -x

# Vérifie si le fichier de configuration est fourni en argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 config.txt"
    exit 1
fi

CONFIG_FILE="$1"

# Fonction pour remplacer du texte à une ligne spécifique
replace_line() {
    local file=$1
    local line_number=$2
    local old_text=$3
    local new_text=$4
    echo "Remplacement de la ligne $line_number dans $file : $old_text par $new_text"
    sed -i "${line_number}s|${old_text}|${new_text}|g" "$file"
}

# Fonction pour ajouter des lignes
add_lines() {
    local file=$1
    local line_number=$2
    local new_lines=$3
    echo "Ajout de lignes à partir de la ligne $line_number dans $file : $new_lines"
    # Utiliser des guillemets doubles pour permettre l'expansion correcte
    sed -i "${line_number}i$new_lines" "$file"
}

# Fonction pour supprimer des lignes
delete_lines() {
    local file=$1
    local line_number=$2
    echo "Suppression de la ligne $line_number dans $file"
    sed -i "${line_number}d" "$file"
}

# Fonction pour ajouter un fichier
add_file() {
    local source_file=$1
    local destination=$2
    echo "Copie du fichier $source_file vers $destination"
    cp "$source_file" "$destination"
}

# Fonction pour remplacer un fichier
replace_file() {
    local source_file=$1
    local destination=$2
    echo "Remplacement du fichier $destination par $source_file"
    cp "$source_file" "$destination"
}

# Lecture du fichier de configuration
while IFS= read -r line; do
    # Éviter de lire des lignes vides
    [ -z "$line" ] && continue

    # Lire les paramètres à partir de chaque ligne
    IFS=" " read -r action file line_number old_text new_text <<< "$line"

    case "$action" in
        replace_line)
            replace_line "$file" "$line_number" "$old_text" "$new_text"
            ;;
        add_line)
            add_lines "$file" "$line_number" "$old_text"
            ;;
        delete_line)
            delete_lines "$file" "$line_number"
            ;;
        add_file)
            add_file "$old_text" "$file"
            ;;
        replace_file)
            replace_file "$old_text" "$file"
            ;;
        *)
            echo "Unknown action: $action"
            ;;
    esac
done < "$CONFIG_FILE"
