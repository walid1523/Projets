Plan pour la documentation technique

    Introduction
        Présentation générale du projet.
        Objectifs du projet.

    Architecture
        Topologie réseau.
        Description des machines (serveur Debian, client Ubuntu).
        Adresses IP et configuration réseau.

    Scripts développés
        Liste des scripts avec une brève description pour chacun.
        Fonctionnement global du système via le menu principal.

    Instructions pour l'installation et la configuration
        Étapes pour mettre en place l’environnement.
        Dépendances requises (paquets, SSH, outils nécessaires).

    Exemples d’utilisation
        Démonstration des principales fonctionnalités.
        Résultats attendus après l'exécution des actions.

    Problèmes rencontrés et solutions
        Défis rencontrés pendant le développement.
        Solutions mises en œuvre.

    Conclusion
        Résumé des résultats obtenus.
        Perspectives d’améliorations futures.

    Annexes
        Codes des scripts (ou liens vers les fichiers sources).
        Commandes utiles.


### Introduction

Le projet consiste à développer un système automatisé de gestion utilisateur, client, et journalisation via des scripts Bash. Les actions sont exécutées à distance sur un client Ubuntu depuis un serveur Debian grâce à SSH.

**Objectifs :**
- Simplifier la gestion des utilisateurs et des groupes.
- Faciliter la gestion des machines clientes (arrêt, redémarrage, etc.).
- Fournir un outil centralisé pour l’analyse des journaux et des logs.

### Architecture

**Topologie réseau :**
- Serveur Debian : `172.16.10.10/24`
- Client Ubuntu : `172.16.10.30/24`

**Détails des machines :**
- Serveur Debian :
  - Nom d’hôte : `debian`
  - Utilisateur : `grd`
- Client Ubuntu :
  - Nom d’hôte : `ubuntu-client`
  - Utilisateur : `wilder`

**Configuration réseau :**
- Les machines communiquent via SSH.
- Serveur Debian utilise OpenSSH (`OpenSSH_9.2`).

### Scripts développés

1. **menu_projet_2.sh** : Menu principal qui centralise toutes les actions et informations.
2. **add_del_users.sh** : Gestion des utilisateurs (création, suppression, désactivation).
3. **add_del_groups.sh** : Gestion des groupes (ajout, suppression).
4. **ch_mdp.sh** : Changement de mot de passe.
5. **gestion_machine.sh** : Gestion des machines clientes (arrêt, redémarrage, verrouillage).
6. **gestion_systeme.sh** : Gestion système (mise à jour, mémoire, processeur).
7. **gestion_repertoire.sh** : Gestion des répertoires (création, modification, suppression).
8. **storage_mngt.sh** : Gestion du stockage (partitions, espace disque, taille des dossiers).
9. **network_config.sh** : Configuration réseau (interfaces, IP, ports ouverts).
10. **logs_mgmt.sh** : Analyse des journaux (utilisateur, machine).

### Installation et configuration

**Pré-requis :**
- Serveur Debian et client Ubuntu configurés avec des adresses IP fixes.
- OpenSSH installé sur les deux machines :
  - `sudo apt install openssh-server openssh-client`
- Permettre l'accès SSH sans mot de passe (utilisation des clés SSH).

**Dépôt des scripts :**
- Copier les scripts dans un dossier `/home/grd/projet_scripts` sur le serveur Debian.
- Rendre les scripts exécutables :
  ```bash
  chmod +x /home/grd/projet_scripts/*.sh



---

#### **5. Exemples d’utilisation**
```markdown
### Exemples d’utilisation

1. **Gestion des utilisateurs**
   - Création d’un utilisateur :
     - Depuis le menu principal, choisir "Réaliser une Action".
     - Sélectionner "Gestion utilisateur".
     - Choisir "Créer un utilisateur" et entrer les informations requises.

2. **Analyse des logs**
   - Depuis le menu principal, choisir "Gestion de journalisation".
   - Rechercher les événements liés à un utilisateur ou une machine spécifique.

    ### Problèmes rencontrés et solutions

1. **Erreur de clé SSH lors de l'exécution des scripts à distance**
   - Solution : Configurer l'accès SSH sans mot de passe à l'aide de clés RSA.

2. **Problème de mot de passe lors de la création d’un utilisateur**
   - Solution : Modifier les paramètres de qualité des mots de passe dans `/etc/security/pwquality.conf`.

3. **Commande introuvable pour verrouiller l’écran**
   - Solution : Installer `gnome-screensaver` sur le client Ubuntu.

### Conclusion

Ce projet a permis de mettre en place une solution centralisée pour la gestion des utilisateurs, machines, stockage, réseau, et journaux à l’aide de scripts Bash. Le système est évolutif et pourrait inclure :
- Une interface graphique pour simplifier l'utilisation.
- Des notifications automatiques pour les alertes système.

Le projet répond aux objectifs fixés et offre une base solide pour des améliorations futures.


### Annexes

1. **Commandes utiles**
   - Afficher les groupes d’un utilisateur :
     ```bash
     groups <nom_utilisateur>
     ```
   - Rechercher des logs pour un utilisateur :
     ```bash
     sudo grep <nom_utilisateur> /var/log/auth.log
     ```

2. **Chemin des scripts**
   - Menu principal : `/home/grd/projet_scripts/menu_projet_2.sh`
   - Scripts associés : `/home/grd/projet_scripts/*.sh`
