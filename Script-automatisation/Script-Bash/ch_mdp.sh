#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Fonction pour changer le mot de passe
change_password() {
    read -p "Entrez le nom d'utilisateur pour changer le mot de passe : " username
    read -s -p "Entrez le nouveau mot de passe : " new_password
    echo
    read -s -p "Confirmez le nouveau mot de passe : " confirm_password
    echo

    # Vérifier si les mots de passe correspondent
    if [ "$new_password" != "$confirm_password" ]; then
        echo "Erreur : Les mots de passe ne correspondent pas. Veuillez réessayer."
        return 1
    fi

    # Exécution de la commande sur le client Ubuntu
    ssh $CLIENT_USER@$CLIENT_IP "echo '$username:$new_password' | sudo -S chpasswd" || {
        echo "Erreur : Impossible de changer le mot de passe pour l'utilisateur $username."
        return 1
    }

    echo "Le mot de passe de l'utilisateur $username a été changé avec succès sur $CLIENT_IP."
}

# Appel de la fonction
change_password
