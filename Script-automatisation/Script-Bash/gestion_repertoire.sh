#!/bin/bash

# Configuration
CLIENT_IP="172.16.10.30"       # Adresse IP du client Ubuntu
CLIENT_USER="wilder"           # Utilisateur sur le client Ubuntu

# Fonction pour créer un répertoire
function creation_repertoire {
    read -p "Veuillez indiquer le nom du dossier à créer : " dossier_a_creer
    if [ -z "$dossier_a_creer" ]; then
        echo "Vous devez indiquer un nom de répertoire pour permettre sa création !"
        echo ""
        creation_repertoire
    else
        ssh $CLIENT_USER@$CLIENT_IP "mkdir -p '$dossier_a_creer'" && {
            echo "Le dossier '$dossier_a_creer' a été créé avec succès sur la machine distante !"
        } || {
            echo "Erreur : Impossible de créer le dossier '$dossier_a_creer' sur la machine distante."
        }
    fi
}

# Fonction pour modifier ou supprimer un répertoire
function modification_repertoire {
    read -p "Veuillez indiquer le nom du dossier concerné : " dossier_a_modifier
    if [ -z "$dossier_a_modifier" ]; then
        echo "ERREUR : réponse invalide !"
        echo ""
        modification_repertoire
    else
        echo ""
        echo "Quelle opération souhaitez-vous effectuer ?

        --------> Renommer le dossier                               (  tapez R  )

        --------> Copier le dossier dans le répertoire courant      (  tapez C  )

        --------> Copier le dossier dans un autre répertoire        (  tapez CA )

        --------> Déplacer le dossier dans un autre répertoire      (  tapez D  )

        --------> Supprimer le dossier et tout son contenu          (  tapez S  )"
        echo ""
        read -p "Veuillez sélectionner votre choix : " action_modif_dossier
        clear

        case $action_modif_dossier in
            r|R)
                read -p "Comment souhaitez-vous renommer le dossier ? " new_name
                if [ -z "$new_name" ]; then
                    echo "ERREUR : réponse invalide !"
                    echo ""
                    modification_repertoire
                else
                    ssh $CLIENT_USER@$CLIENT_IP "mv '$dossier_a_modifier' '$new_name'" && {
                        echo "Le dossier a été renommé avec succès sur la machine distante !"
                    } || {
                        echo "Erreur : Impossible de renommer le dossier sur la machine distante."
                    }
                fi
                ;;
            c|C)
                ssh $CLIENT_USER@$CLIENT_IP "cp -r '$dossier_a_modifier' './${dossier_a_modifier}-copie'" && {
                    echo "Le dossier '$dossier_a_modifier' a été copié avec succès sur la machine distante !"
                } || {
                    echo "Erreur : Impossible de copier le dossier sur la machine distante."
                }
                ;;
            ca|CA)
                read -p "Veuillez indiquer le chemin où le dossier doit être copié : " path
                if [ -z "$path" ]; then
                    echo "ERREUR : réponse invalide !"
                    echo ""
                    modification_repertoire
                else
                    ssh $CLIENT_USER@$CLIENT_IP "cp -r '$dossier_a_modifier' '$path/$dossier_a_modifier'" && {
                        echo "Le dossier a été copié avec succès dans '$path' sur la machine distante !"
                    } || {
                        echo "Erreur : Impossible de copier le dossier dans '$path' sur la machine distante."
                    }
                fi
                ;;
            d|D)
                read -p "Veuillez indiquer le chemin où le dossier doit être déplacé : " path
                if [ -z "$path" ]; then
                    echo "ERREUR : réponse invalide !"
                    echo ""
                    modification_repertoire
                else
                    ssh $CLIENT_USER@$CLIENT_IP "mv '$dossier_a_modifier' '$path/$dossier_a_modifier'" && {
                        echo "Le dossier a été déplacé avec succès dans '$path' sur la machine distante !"
                    } || {
                        echo "Erreur : Impossible de déplacer le dossier dans '$path' sur la machine distante."
                    }
                fi
                ;;
            s|S)
                read -p "Veuillez confirmer la suppression du dossier $dossier_a_modifier en écrivant GO ! " confirmation_suppression
                if [ "$confirmation_suppression" = "GO" ]; then
                    ssh $CLIENT_USER@$CLIENT_IP "rm -r '$dossier_a_modifier'" && {
                        echo "Le dossier '$dossier_a_modifier' a été supprimé avec succès sur la machine distante !"
                    } || {
                        echo "Erreur : Impossible de supprimer le dossier sur la machine distante."
                    }
                else
                    echo "ERREUR : suppression de dossier non confirmée !"
                    modification_repertoire
                fi
                ;;
            *)
                echo "ERREUR : vous devez saisir une réponse valide !"
                echo ""
                modification_repertoire
                ;;
        esac
    fi
}

# Menu principal
while true; do
    echo ""
    echo "Vous souhaitez : 

        --------> Créer un répertoire                   ( tapez C )

        --------> Modifier ou supprimer un répertoire   ( tapez M )

        --------> Retourner au menu précédent           ( tapez P )

        --------> Quitter                               ( tapez X )"

    echo ""
    read -p "Sélectionnez votre choix : " action_repertoire
    clear

    case $action_repertoire in
        c|C)
            creation_repertoire
            ;;
        m|M)
            modification_repertoire
            ;;
        p|P)
            echo "Retour au menu précédent !"
            return
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
