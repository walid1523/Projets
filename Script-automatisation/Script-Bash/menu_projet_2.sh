#!/bin/bash

###---------------------------------- FONCTIONS APPELEES DANS LE MENU PRINCIPAL -----------------------------####

function debut_menu 
{
    echo ""
    read -p "Bonjour, que souhaitez-vous faire ? 

    --------> réaliser une Action       ( tapez A ) 

    --------> obtenir une Information   ( tapez I ) 

    --------> gestion de journalisation ( tapez L )

    --------> quitter (fin)             ( tapez X )
    
    Sélectionnez votre choix : " operation_type 
    clear
}

function choix_action_user_ou_ordi 
{ 
        while true; do
        echo ""
        read -p "Votre action concerne :

        --------> un Utilisateur            ( tapez U )  
              
        --------> un Ordinateur client      ( tapez O ) 

        --------> retour au menu précédent  ( tapez P )

        --------> quitter (fin)             ( tapez X )
        
        Sélectionnez votre choix : " action_choice
        clear

        case $action_choice in
            u|U) action_utilisateur ;;
            o|O) action_ordinateur ;;
            p|P) echo "Retour au menu précédent !" ; return ;; # retourne au menu précédent
            x|X) quitter ;;
            *) clear; echo "ERREUR : vous devez taper une réponse valide !" ;;
        esac
    done
}

function choix_info_user_ou_ordi 
{
    while true; do
        echo ""
        read -p "Votre information concerne :

        --------> un Utilisateur            ( tapez U )

        --------> un Ordinateur client      ( tapez O )

        --------> retour au menu précédent  ( tapez P )

        --------> quitter (fin)             ( tapez X )

        Sélectionnez votre choix : " info_choice
        clear

        case $info_choice in
            u|U) info_utilisateur ;;
            o|O) info_ordinateur ;;
            p|P) echo "Retour au menu précédent !" ; return ;; # retourne au menu précédent
            x|X) quitter ;;
            *) clear; echo "ERREUR : vous devez taper une réponse valide !" ;;
        esac
    done
}

function action_utilisateur 
{
    while true; do
        echo ""
        echo "Votre action sur Utilisateur concerne : 
                
        --------> la gestion du Compte utilisateur      ( tapez C )
                
        --------> la gestion de Groupe                  ( tapez G )
                
        --------> le changement du Mot de passe         ( tapez M ) 

        --------> retour au menu précédent              ( tapez P )
                
        --------> quitter (fin)                         ( tapez X )"
                
        echo ""
        read -p "Sélectionnez votre choix : " action_user_choice
        clear

        case $action_user_choice in
            c|C) source ./add_del_users.sh ;;          # Script pour gérer les utilisateurs
            g|G) source ./add_del_groups.sh ;;         # Script pour gérer les groupes
            m|M) source ./ch_mdp.sh ;;                 # Script pour changer le mot de passe
            p|P) echo "Retour au menu précédent !" ; return ;; # retourne au menu précédent
            x|X) quitter ;;
            *) clear; echo "ERREUR : vous devez taper une réponse valide !" ;;
        esac
    done
}

function action_ordinateur 
{
    while true; do
        echo ""
        echo "Votre action sur Ordinateur client concerne : 

        --------> la gestion de la machine      ( tapez M )

        --------> la gestion du système         ( tapez S )

        --------> la gestion du répertoire      ( tapez R )

        --------> retour au menu précédent      ( tapez P )

        --------> quitter                       ( tapez X )"

        echo ""
        read -p "Sélectionnez votre choix : " action_ordi_choice
        clear

        case $action_ordi_choice in
            m|M) source ./gestion_machine.sh ;;         # Script pour gérer les machines
            s|S) source ./gestion_systeme.sh ;;         # Script pour gérer le système
            r|R) source ./gestion_repertoire.sh ;;      # Script pour gérer les répertoires
            p|P) echo "Retour au menu précédent !" ; return ;; # retourne au menu précédent
            x|X) quitter ;;
            *) clear; echo "ERREUR : vous devez taper une réponse valide !" ;;
        esac
    done
}

function info_utilisateur 
{
    source ./info_users.sh                           # Script pour les informations utilisateurs
}

function info_ordinateur 
{
    while true; do
        echo ""
        echo "Votre information sur Ordinateur client concerne : 

        --------> la gestion du stockage        ( tapez S )

        --------> la configuration du réseau    ( tapez R )

        --------> retour au menu précédent      ( tapez P )

        --------> quitter                       ( tapez X )"

        echo ""
        read -p "Sélectionnez votre choix : " info_ordi_choice
        clear

        case $info_ordi_choice in
            s|S) source ./storage_mngt.sh ;;          # Script pour gérer le stockage
            r|R) source ./network_config.sh ;;        # Script pour gérer la configuration réseau
            p|P) echo "Retour au menu précédent !" ; return ;; # retourne au menu précédent
            x|X) quitter ;;
            *) echo "ERREUR : vous devez taper une réponse valide !" ;;
        esac
    done
}

function quitter 
{
    echo ""
    echo "Vous avez choisi de quitter : opération terminée !" 
    exit 0
}

###------------------------- BOUCLE DU MENU PRINCIPAL -------------------------###
clear
while true; do 
    debut_menu

    case $operation_type in 
        a|A)
            choix_action_user_ou_ordi
            ;;
        i|I)
            choix_info_user_ou_ordi
            ;;
        l|L)
           source ./logs_mgmt.sh  # Appel du script pour la journalisation et les logs
            ;;
        x|X)
            quitter
            ;;
        *) 
            echo "ERREUR : vous devez taper une réponse valide !"
            ;;
    esac
done

