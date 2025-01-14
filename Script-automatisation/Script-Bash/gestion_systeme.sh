#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Fonction pour mettre à jour le système
function update_system {
    echo "Mise à jour du système distant..."
    ssh $CLIENT_USER@$CLIENT_IP "sudo apt update && sudo apt upgrade -y" || {
        echo "Erreur : Impossible de mettre à jour le système distant."
        return 1
    }
    echo "Le système distant $CLIENT_IP a été mis à jour avec succès."
}

# Fonction pour afficher la version du système
function show_system_version {
    echo "Version du système distant..."
    version=$(ssh $CLIENT_USER@$CLIENT_IP "lsb_release -a 2>/dev/null || cat /etc/os-release")
    if [ -z "$version" ]; then
        echo "Erreur : Impossible de récupérer la version du système distant."
    else
        echo "Version du système distant :"
        echo "$version"
    fi
}

# Fonction pour afficher l'utilisation de la mémoire
function show_memory_usage {
    echo "Utilisation de la mémoire sur le système distant..."
    memory=$(ssh $CLIENT_USER@$CLIENT_IP "free -h")
    if [ -z "$memory" ]; then
        echo "Erreur : Impossible de récupérer l'utilisation de la mémoire sur le système distant."
    else
        echo "Utilisation de la mémoire sur le système distant :"
        echo "$memory"
    fi
}

# Fonction pour afficher l'utilisation du processeur
function show_cpu_usage {
    echo "Utilisation du processeur sur le système distant..."
    cpu=$(ssh $CLIENT_USER@$CLIENT_IP "top -b -n 1 | grep '%Cpu(s)'")
    if [ -z "$cpu" ]; then
        echo "Erreur : Impossible de récupérer l'utilisation du processeur sur le système distant."
    else
        echo "Utilisation du processeur sur le système distant :"
        echo "$cpu"
    fi
}

# Menu des actions
while true; do
    echo ""
    echo "Votre action sur le système client concerne : 

    --------> Mettre à jour le système                ( tapez U )

    --------> Afficher la version du système          ( tapez V )

    --------> Afficher l'utilisation de la mémoire    ( tapez M )

    --------> Afficher l'utilisation du processeur    ( tapez C )

    --------> Retour au menu précédent                ( tapez P )

    --------> Quitter                                 ( tapez X )"

    echo ""
    read -p "Sélectionnez votre choix : " action_systeme
    clear

    case $action_systeme in
        u|U)
            update_system
            ;;
        v|V)
            show_system_version
            ;;
        m|M)
            show_memory_usage
            ;;
        c|C)
            show_cpu_usage
            ;;
        p|P)
            echo "Retour au menu principal."
            return 0
            ;;
        x|X)
            echo "Quitter le script."
            exit 0
            ;;
        *)
            echo "ERREUR : vous devez taper une réponse valide !"
            ;;
    esac
done
