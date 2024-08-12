#!/bin/bash

# Vérifie si le fichier de configuration est fourni en argument
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 config.txt"
    exit 1
fi

CONFIG_FILE="$1"
SCRIPT_DIR=$(dirname "$0")  # Répertoire du script

# Fonction pour remplacer une expression spécifique à une ligne
replace_expression() {
    local file=$1
    local line_number=$2
    local old_expression=$3
    local new_expression=$4
    
    echo "Remplacement de l'expression '$old_expression' par '$new_expression' dans la ligne $line_number du fichier $file"
    sed -i "${line_number}s/${old_expression}/${new_expression}/" "$file"
}

# Fonction pour remplacer toute une ligne
replace_line() {
    local file=$1
    local line_number=$2
    local new_line=$3
    
    echo "Remplacement de la ligne $line_number dans le fichier $file par : $new_line"
    sed -i "${line_number}s/.*/${new_line}/" "$file"
}

# Fonction pour remplacer une expression partout dans un fichier
replace_in_file() {
    local file=$1
    local old_expression=$2
    local new_expression=$3
    
    echo "Remplacement de l'expression '$old_expression' par '$new_expression' dans tout le fichier $file"
    sed -i "s/${old_expression}/${new_expression}/g" "$file"
}

# Fonction pour supprimer plusieurs lignes spécifiques
delete_lines() {
    local file=$1
    local line_numbers=$2
    
    echo "Suppression des lignes suivantes ($line_numbers) dans le fichier $file"
    # Utilisation de sed pour supprimer les lignes spécifiques
    sed -i "$(echo $line_numbers | sed 's/,/d;/g')d" "$file"
}

# Fonction pour remplacer un fichier par un fichier dans le répertoire du script
replace_file_from_script_dir() {
    local source_file=$1
    local destination_file=$2
    local source_path="$SCRIPT_DIR/$source_file"
    
    if [ -f "$source_path" ]; then
        echo "Remplacement du fichier $destination_file avec $source_path"
        cp "$source_path" "$destination_file"
    else
        echo "Le fichier source $source_path n'existe pas."
    fi
}

# Fonction pour ajouter plusieurs lignes avec texte complexe
add_multiple_lines() {
    local file=$1
    local line_number=$2
    local new_lines=$3
    
    echo "Ajout des lignes suivantes à partir de la ligne $line_number dans le fichier $file :"
    echo "$new_lines"
    
    # Utilisation de sed pour ajouter les lignes
    # Les lignes multi-lignes sont encadrées par des guillemets simples pour préserver le format
    # On remplace les retours à la ligne par des séquences \n pour le traitement avec sed
    sed -i "${line_number}i\\
$(echo "$new_lines" | sed ':a;N;$!ba;s/\n/\\n/g')\\
" "$file"
}

# Lecture du fichier de configuration
while IFS=" " read -r action file line old_text new_text; do
    case "$action" in
        replace_expression)
            replace_expression "$file" "$line" "$old_text" "$new_text"
            ;;
        replace_line)
            replace_line "$file" "$line" "$old_text"
            ;;
        replace_in_file)
            replace_in_file "$file" "$old_text" "$new_text"
            ;;
        delete_lines)
            delete_lines "$file" "$line"
            ;;
        replace_file)
            replace_file_from_script_dir "$old_text" "$file"
            ;;
        add_lines)
            add_multiple_lines "$file" "$line" "$old_text"
            ;;
        *)
            echo "Unknown action: $action"
            ;;
    esac
done < "$CONFIG_FILE"
