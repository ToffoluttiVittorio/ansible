#!/bin/bash

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
    sed -i "${line_number}s|${old_text}|${new_text}|g" "$file"
}

# Fonction pour ajouter des lignes
add_lines() {
    local file=$1
    local line_number=$2
    local new_lines=$3
    sed -i "${line_number}i${new_lines}" "$file"
}

# Fonction pour supprimer des lignes
delete_lines() {
    local file=$1
    local line_number=$2
    sed -i "${line_number}d" "$file"
}

# Fonction pour ajouter un fichier
add_file() {
    local source_file=$1
    local destination=$2
    cp "$source_file" "$destination"
}

# Fonction pour remplacer un fichier
replace_file() {
    local source_file=$1
    local destination=$2
    cp "$source_file" "$destination"
}

# Lecture du fichier de configuration
while IFS=" " read -r action file line old_text new_text; do
    case "$action" in
        replace_line)
            replace_line "$file" "$line" "$old_text" "$new_text"
            ;;
        add_line)
            add_lines "$file" "$line" "$old_text"
            ;;
        delete_line)
            delete_lines "$file" "$line"
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
