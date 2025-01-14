#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Fonction pour afficher les interfaces réseau et leurs adresses IP
function show_network_interfaces {
    echo "Affichage des interfaces réseau sur le système distant..."
    interfaces=$(ssh $CLIENT_USER@$CLIENT_IP "ip -br addr")
    if [ -z "$interfaces" ]; then
        echo "Erreur : Impossible de récupérer les informations des interfaces réseau sur la machine distante."
    else
        echo "Interfaces réseau sur la machine distante :"
        echo "$interfaces"
    fi
}

# Fonction pour afficher l'adresse MAC de chaque interface
function show_mac_addresses {
    echo "Affichage des adresses MAC des interfaces réseau sur le système distant..."
    mac_addresses=$(ssh $CLIENT_USER@$CLIENT_IP "ip link show | grep 'link/ether' | awk '{print \$2}'")
    if [ -z "$mac_addresses" ]; then
        echo "Erreur : Impossible de récupérer les adresses MAC sur la machine distante."
    else
        echo "Adresses MAC des interfaces réseau sur la machine distante :"
        echo "$mac_addresses"
    fi
}

# Fonction pour afficher les ports ouverts
function show_open_ports {
    echo "Affichage des ports ouverts sur le système distant..."
    open_ports=$(ssh $CLIENT_USER@$CLIENT_IP "sudo netstat -tuln | grep LISTEN")
    if [ -z "$open_ports" ]; then
        echo "Aucun port ouvert trouvé sur la machine distante."
    else
        echo "Ports ouverts sur la machine distante :"
        echo "$open_ports"
    fi
}

# Fonction pour afficher le statut du pare-feu
function show_firewall_status {
    echo "Affichage du statut du pare-feu sur le système distant..."
    firewall_status=$(ssh $CLIENT_USER@$CLIENT_IP "sudo ufw status")
    if [ -z "$firewall_status" ]; then
        echo "Erreur : Impossible de récupérer le statut du pare-feu sur la machine distante."
    else
        echo "Statut du pare-feu sur la machine distante :"
        echo "$firewall_status"
    fi
}

# Menu principal
while true; do
    echo ""
    echo "Options de configuration réseau : 

    --------> Afficher les interfaces réseau et leurs adresses IP  ( tapez I )

    --------> Afficher les adresses MAC                          ( tapez M )

    --------> Afficher les ports ouverts                         ( tapez P )

    --------> Afficher le statut du pare-feu                     ( tapez F )

    --------> Retourner au menu précédent                        ( tapez R )

    --------> Quitter                                            ( tapez X )"

    echo ""
    read -p "Sélectionnez votre choix : " network_choice
    clear

    case $network_choice in
        i|I)
            show_network_interfaces
            ;;
        m|M)
            show_mac_addresses
            ;;
        p|P)
            show_open_ports
            ;;
        f|F)
            show_firewall_status
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
