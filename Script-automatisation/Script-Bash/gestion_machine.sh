#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Fonction pour arrêter l'ordinateur
function arreter {
    echo "Arrêt de la machine distante..."
    ssh $CLIENT_USER@$CLIENT_IP "sudo shutdown -h now" || {
        echo "Erreur : Impossible d'arrêter la machine distante."
        return 1
    }
    echo "La machine distante $CLIENT_IP a été arrêtée."
}

# Fonction pour redémarrer l'ordinateur
function redemarrer {
    echo "Redémarrage de la machine distante..."
    ssh $CLIENT_USER@$CLIENT_IP "sudo reboot" || {
        echo "Erreur : Impossible de redémarrer la machine distante."
        return 1
    }
    echo "La machine distante $CLIENT_IP a été redémarrée."
}

# Fonction pour verrouiller l'ordinateur
function verrouiller {
    echo "Verrouillage de la machine distante..."
    ssh $CLIENT_USER@$CLIENT_IP "gnome-screensaver-command -l" || {
        echo "Erreur : Impossible de verrouiller la machine distante.Vérifiez si la commande est disponible ou si la machine dispose d'une interface graphique."
        
        return 1
    }
    echo "La machine distante $CLIENT_IP a été verrouillée."
}

# Menu des actions
while true; do
    echo ""
    echo "Votre action sur Ordinateur client concerne : 

    --------> l'arrêt de la machine             ( tapez A )

    --------> le redémarrage de la machine      ( tapez R )

    --------> le verrouillage de la  machine    ( tapez V )

    --------> retour au menu précédent          ( tapez P )

    --------> quitter                           ( tapez X )"

    echo ""
    read -p "Sélectionnez votre choix : " action_machine
    clear

    case $action_machine in
        a|A)
            arreter
            ;;
        r|R)
            redemarrer
            ;;
        v|V)
            verrouiller
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
