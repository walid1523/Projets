#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Fonction pour rechercher les événements liés à un utilisateur spécifique
function search_user_logs {
    read -p "Entrez le nom de l'utilisateur à rechercher dans les logs : " username
    if [ -z "$username" ]; then
        echo "ERREUR : Vous devez fournir un nom d'utilisateur."
        return
    fi

    echo "Recherche des événements pour l'utilisateur '$username' dans les logs sur le système distant..."
    user_logs=$(ssh $CLIENT_USER@$CLIENT_IP "sudo grep '$username' /var/log/auth.log 2>/dev/null")
    if [ -z "$user_logs" ]; then
        echo "Aucun événement trouvé pour l'utilisateur '$username' dans les logs."
    else
        echo "Événements trouvés pour l'utilisateur '$username' :"
        echo "$user_logs"
    fi
}

# Fonction pour rechercher les événements liés à un ordinateur spécifique
function search_computer_logs {
    read -p "Entrez l'adresse IP ou le nom de l'hôte de la machine distante : " computer_name
    if [ -z "$computer_name" ]; then
        echo "ERREUR : Vous devez fournir une adresse IP ou un nom d'hôte."
        return
    fi

    echo "Recherche des événements pour la machine '$computer_name' dans les logs sur le système distant..."
    computer_logs=$(ssh $CLIENT_USER@$CLIENT_IP "sudo grep '$computer_name' /var/log/syslog 2>/dev/null")
    if [ -z "$computer_logs" ]; then
        echo "Aucun événement trouvé pour la machine '$computer_name' dans les logs."
    else
        echo "Événements trouvés pour la machine '$computer_name' :"
        echo "$computer_logs"
    fi
}

# Menu principal
while true; do
    echo ""
    echo "Options de journalisation et logs : 

    --------> Rechercher des événements pour un utilisateur       ( tapez U )

    --------> Rechercher des événements pour une machine          ( tapez C )

    --------> Retourner au menu précédent                         ( tapez R )

    --------> Quitter                                             ( tapez X )"

    echo ""
    read -p "Sélectionnez votre choix : " log_choice
    clear

    case $log_choice in
        u|U)
            search_user_logs
            ;;
        c|C)
            search_computer_logs
            ;;
        r|R)
            echo "Retour au menu principal."
            return
            ;;
        x|X)
            echo "Quitter le script."
            exit 0
            ;;
        *)
            echo "ERREUR : Vous devez taper une réponse valide !"
            ;;
    esac

    echo "Appuyez sur Entrée pour continuer..."
    read
    clear
done
