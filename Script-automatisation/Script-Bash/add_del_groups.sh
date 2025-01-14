#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"
CLIENT_USER="wilder"

# Fonction pour ajouter un utilisateur à un groupe
add_to_group() {
    read -p "Entrez le nom de l'utilisateur : " username
    read -p "Entrez le nom du groupe : " groupname
    ssh $CLIENT_USER@$CLIENT_IP "sudo usermod -a -G $groupname $username"
    echo "Utilisateur $username ajouté au groupe $groupname sur $CLIENT_IP."
}

# Fonction pour supprimer un utilisateur d'un groupe
remove_from_group() {
    read -p "Entrez le nom de l'utilisateur : " username
    read -p "Entrez le nom du groupe : " groupname
    ssh $CLIENT_USER@$CLIENT_IP "sudo gpasswd -d $username $groupname"
    echo "Utilisateur $username retiré du groupe $groupname sur $CLIENT_IP."
}

# Menu de gestion des groupes
echo "Gestion des groupes :"
echo "1 - Ajouter un utilisateur à un groupe"
echo "2 - Retirer un utilisateur d'un groupe"
read -p "Votre choix : " choice

case $choice in
    1) add_to_group ;;
    2) remove_from_group ;;
    *) echo "Choix invalide !" ;;
esac
