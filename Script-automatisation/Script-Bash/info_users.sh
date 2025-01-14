#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Afficher le titre du script
function show_title() {
    echo "==========================================================="
    echo "       MENU D'INFORMATIONS SUR L'UTILISATEUR LINUX         "
    echo "==========================================================="
}

# Fonction pour demander le nom d'utilisateur
function get_username() {
    while true; do
        read -p "Entrez le nom de l'utilisateur : " USERNAME
        # Vérification si l'utilisateur existe sur le client
        if ssh $CLIENT_USER@$CLIENT_IP "id $USERNAME" &>/dev/null; then
            break
        else
            echo "L'utilisateur $USERNAME n'existe pas sur le client. Veuillez entrer un utilisateur valide."
        fi
    done
}

# 1. Date de dernière connexion
function last_login() {
    get_username
    last_login=$(ssh $CLIENT_USER@$CLIENT_IP "last -n 1 $USERNAME | head -n 1 | awk '{print \$4, \$5, \$6, \$7}'")
    if [ -z "$last_login" ]; then
        echo "Aucune information de connexion trouvée pour $USERNAME ou l'utilisateur n'a jamais ouvert de session."
    else
        echo "Date de dernière connexion de $USERNAME : $last_login"
    fi
}

# 2. Date de dernière modification du mot de passe
function password_last_change() {
    get_username
    password_last_change=$(ssh $CLIENT_USER@$CLIENT_IP "sudo chage -l $USERNAME | grep 'Last password change' | cut -d: -f2")
    if [ -z "$password_last_change" ]; then
        echo "Aucune information sur la dernière modification du mot de passe de $USERNAME."
    else
        echo "Date de dernière modification du mot de passe de $USERNAME : $password_last_change"
    fi
}

# 3. Liste des sessions ouvertes par l'utilisateur
function user_sessions() {
    get_username
    user_sessions=$(ssh $CLIENT_USER@$CLIENT_IP "who | grep $USERNAME")
    if [ -z "$user_sessions" ]; then
        echo "Aucune session ouverte trouvée pour $USERNAME."
    else
        echo "Liste des sessions ouvertes par $USERNAME :"
        echo "$user_sessions"
    fi
}

# 4. Groupes d’appartenance d’un utilisateur
function user_groups() {
    get_username
    user_groups=$(ssh $CLIENT_USER@$CLIENT_IP "groups $USERNAME")
    if [ -z "$user_groups" ]; then
        echo "Aucun groupe d'appartenance trouvé pour $USERNAME."
    else
        echo "Groupes d'appartenance de $USERNAME : $user_groups"
    fi
}

# 5. Historique des commandes exécutées par l'utilisateur
function user_history() {
    get_username
    history_output=$(ssh $CLIENT_USER@$CLIENT_IP "sudo -u $USERNAME tail -n 10 /home/$USERNAME/.bash_history" 2>/dev/null)
    if [ -z "$history_output" ]; then
        echo "Aucun historique trouvé pour $USERNAME."
    else
        echo "Historique des commandes exécutées par $USERNAME (dernières 10 commandes) :"
        echo "$history_output"
    fi
}

# 6. Droits/permissions de l’utilisateur sur un dossier
function folder_permissions() {
    get_username
    read -p "Entrez le chemin du dossier : " DIRECTORY
    folder_info=$(ssh $CLIENT_USER@$CLIENT_IP "ls -ld $DIRECTORY" 2>/dev/null)
    if [ -z "$folder_info" ]; then
        echo "Le dossier $DIRECTORY n'existe pas sur le client."
    else
        echo "Permissions de $USERNAME sur le dossier $DIRECTORY :"
        echo "$folder_info"
    fi
}

# 7. Droits/permissions de l’utilisateur sur un fichier
function file_permissions() {
    get_username
    read -p "Entrez le chemin du fichier : " FILE
    file_info=$(ssh $CLIENT_USER@$CLIENT_IP "ls -l $FILE" 2>/dev/null)
    if [ -z "$file_info" ]; then
        echo "Le fichier $FILE n'existe pas sur le client."
    else
        echo "Permissions de $USERNAME sur le fichier $FILE :"
        echo "$file_info"
    fi
}

# Fonction pour afficher le menu et gérer les choix
function show_menu() {
    PS3="Choisissez une option (1-8) : "
    options=("Date de dernière connexion"
             "Date de dernière modification du mot de passe"
             "Liste des sessions ouvertes"
             "Groupes d’appartenance"
             "Historique des commandes"
             "Droits sur un dossier"
             "Droits sur un fichier"
             "Quitter")

    select opt in "${options[@]}"; do
        case $REPLY in
            1) last_login ;;
            2) password_last_change ;;
            3) user_sessions ;;
            4) user_groups ;;
            5) user_history ;;
            6) folder_permissions ;;
            7) file_permissions ;;
            8) echo "Au revoir !" ; exit 0 ;;
            *) echo "Option invalide, veuillez réessayer." ;;
        esac

        echo "Appuyez sur Entrée pour continuer..."
        read
        show_title
        show_menu
    done
}

# Lancer le titre et le menu
show_title
show_menu
