#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"
CLIENT_USER="wilder"

# Fonction pour créer un utilisateur
create_user() {
    read -p "Entrez le nom d'utilisateur : " username
    read -s -p "Entrez le mot de passe : " password
    echo
    ssh $CLIENT_USER@$CLIENT_IP "echo '$password' | sudo -S useradd -m -s /bin/bash $username && echo '$username:$password' | sudo -S chpasswd"
    echo "Utilisateur $username créé sur $CLIENT_IP."
}

# Fonction pour supprimer un utilisateur
delete_user() {
    read -p "Entrez le nom d'utilisateur à supprimer : " username
    ssh $CLIENT_USER@$CLIENT_IP "sudo userdel -r $username"
    echo "Utilisateur $username supprimé sur $CLIENT_IP."
}

# Fonction pour désactiver un utilisateur
disable_user() {
    read -p "Entrez le nom d'utilisateur à désactiver : " username
    ssh $CLIENT_USER@$CLIENT_IP "sudo usermod -L $username"
    echo "Utilisateur $username désactivé sur $CLIENT_IP."
}

# Menu de gestion des utilisateurs
echo "Gestion des utilisateurs :"
echo "1 - Créer un utilisateur"
echo "2 - Supprimer un utilisateur"
echo "3 - Désactiver un utilisateur"
read -p "Votre choix : " choice

case $choice in
    1) create_user ;;
    2) delete_user ;;
    3) disable_user ;;
    *) echo "Choix invalide !" ;;
esac
