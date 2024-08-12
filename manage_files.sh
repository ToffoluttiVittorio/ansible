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
    echo "Remplacement dans le fichier : $file"
    echo "Ligne : $line_number"
    echo "Ancien texte : $old_text"
    echo "Nouveau texte : $new_text"
    sed -i "${line_number}s|${old_text}|${new_text}|g" "$file"
    echo "Remplacement terminé."
}

# Fonction pour ajouter des lignes
add_lines() {
    local file=$1
    local line_number=$2
    local new_lines=$3
    echo "Ajout dans le fichier : $file"
    echo "Ligne à partir de laquelle ajouter : $line_number"
    echo "Nouvelles lignes :"
    echo "$new_lines"
    
    # Utilisation d'un délimiteur temporaire pour éviter les problèmes de formatage
    temp_file=$(mktemp)
    awk -v line="$line_number" -v new_lines="$new_lines" '
    NR == line {print new_lines}
    {print}
    ' "$file" > "$temp_file"
    mv "$temp_file" "$file"
    echo "Ajout terminé."
}

# Fonction pour supprimer des lignes
delete_lines() {
    local file=$1
    local line_number=$2
    echo "Suppression dans le fichier : $file"
    echo "Ligne à supprimer : $line_number"
    sed -i "${line_number}d" "$file"
    echo "Suppression terminée."
}

# Fonction pour ajouter un fichier
add_file() {
    local source_file=$1
    local destination=$2
    echo "Copie du fichier : $source_file"
    echo "Destination : $destination"
    cp "$source_file" "$destination"
    echo "Copie terminée."
}

# Fonction pour remplacer un fichier
replace_file() {
    local source_file=$1
    local destination=$2
    echo "Remplacement du fichier : $destination"
    echo "Fichier source : $source_file"
    cp "$source_file" "$destination"
    echo "Remplacement terminé."
}

# Lecture du fichier de configuration
while IFS=" " read -r action file line old_text new_text; do
    echo "Traitement de l'action : $action"
    echo "Fichier cible : $file"
    echo "Ligne : $line"
    echo "Ancien texte : $old_text"
    echo "Nouveau texte : $new_text"

    case "$action" in
        replace_line)
            replace_line "$file" "$line" "$old_text" "$new_text"
            ;;
        add_line)
            # On attend que les lignes à ajouter soient fournies en multi-lignes dans le fichier de config
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
            echo "Action inconnue : $action"
            ;;
    esac
done < "$CONFIG_FILE"

echo "Traitement terminé."
