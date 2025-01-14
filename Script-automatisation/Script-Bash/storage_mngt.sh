#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Fonction pour afficher les partitions et leurs tailles
function show_partitions {
    echo "Affichage des partitions et leurs tailles sur le système distant..."
    partitions=$(ssh $CLIENT_USER@$CLIENT_IP "lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINT" 2>/dev/null)
    if [ -z "$partitions" ]; then
        echo "Erreur : Impossible de récupérer les informations des partitions sur la machine distante."
    else
        echo "Partitions sur la machine distante :"
        echo "$partitions"
    fi
}

# Fonction pour afficher l'espace disque disponible
function show_disk_usage {
    echo "Affichage de l'espace disque disponible sur le système distant..."
    disk_usage=$(ssh $CLIENT_USER@$CLIENT_IP "df -h" 2>/dev/null)
    if [ -z "$disk_usage" ]; then
        echo "Erreur : Impossible de récupérer les informations d'espace disque sur la machine distante."
    else
        echo "Espace disque disponible sur la machine distante :"
        echo "$disk_usage"
    fi
}

# Fonction pour afficher l'espace utilisé par un dossier spécifique
function show_folder_size {
    read -p "Entrez le chemin du dossier à analyser : " folder_path
    if [ -z "$folder_path" ]; then
        echo "ERREUR : Aucun chemin de dossier spécifié."
        return
    fi

    folder_size=$(ssh $CLIENT_USER@$CLIENT_IP "du -sh '$folder_path' 2>/dev/null")
    if [ -z "$folder_size" ]; then
        echo "Erreur : Impossible de récupérer la taille du dossier '$folder_path' sur la machine distante."
    else
        echo "Taille du dossier '$folder_path' sur la machine distante :"
        echo "$folder_size"
    fi
}

# Menu principal
while true; do
    echo ""
    echo "Options de gestion du stockage : 

    --------> Afficher les partitions et leurs tailles          ( tapez P )

    --------> Afficher l'espace disque disponible               ( tapez D )

    --------> Afficher la taille d'un dossier spécifique        ( tapez F )

    --------> Retourner au menu précédent                       ( tapez M )

    --------> Quitter                                           ( tapez X )"

    echo ""
    read -p "Sélectionnez votre choix : " storage_choice
    clear

    case $storage_choice in
        p|P)
            show_partitions
            ;;
        d|D)
            show_disk_usage
            ;;
        f|F)
            show_folder_size
            ;;
        m|M)
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
