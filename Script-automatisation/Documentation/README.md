## TSSR_PARIS_0924_P2_G4

### Présentation du projet et objectifs finaux

Le projet consiste à créer un script qui s’exécute sur une machine et effectue des tâches sur des machines distantes. L’ensemble des machines sont sur le même réseau.
> Depuis une machine Windows Server, on exécute un script PowerShell qui cible des ordinateurs Windows.

> Depuis une machine Debian, on exécute un script shell qui cible des ordinateurs Ubuntu.

### Introduction et mise en contexte

Le projet permet de disposer d'une documentation métier permettant de : 
- Mettre en place une architecture client/serveur
- Créer et gérer des scripts bash et PowerShell
- Comprendre toutes les étapes
- Faire une démonstration de la réalisation finale

### Membres du groupe de projet et rôle par sprint

| Sprint hebdomadaire vs rôle | BENZAI Walid | CLERY Alexandra | KONATE Mamadou | 
| :---: | :---: | :---: | :---: | 
21/10/24 au 27/10/24 | Scrum Master | Product Owner | Scrum Master 
28/10/24 au 03/11/24 | Product Owner | Scrum master | Scrum Master  
04/11/24 au 10/11/24 | Scrum Master | Scrum Master | Product Owner 
12//11/24 au 15/11/24 |  Scrum Master | Product Owner | Scrum Master 

### Choix techniques

| Type machine | Nom | Système d'exploitation | Compte | Adresse IP fixe |
| :---: | :---: | :---: | :---: | :---: |
Client | CLIWIN01 | Windows 10 | utilisateur wilder | 172.16.10.20/24
Client | CLILIN01 | Ubuntu 22.04/24.04 LTS | utilisateur wilder | 172.16.10.30/24
Serveur | SRVWIN01 | Windows Server 2022 | Administrator | 172.16.10.5/24
Serveur | SRVLIX01 | Debian 12 | root | 172.16.10.10/24

### Arborescence du menu proposé

- Souhaitez-vous réaliser une action (A) ou obtenir une information (I) ?
- Votre action concerne un utilisateur (U) ou un Ordinateur client (O) ?
- Votre action/information concerne :  
- Menus successifs pour répondre aux commandes sélectionnées 
  
### Difficultés rencontrées et solutions trouvées

| Difficultés | solutions |
| :--- | :--- |
Gestion de la conduite du projet via GitHub | S'assurer d'une organisation cohérente des branches et de la maitrise des commandes GitHub  
Mise en place du partage à distance | S'assurer de la viabilité de la mise en place des fonctionnalités SSH et WinRM 
Gestion du travail à objectifs multiples | S'assurer d'organiser les sprints avec un suivi de l'avancement des sujets divers à mettre en place : environnement / scripting / documentation

### Améliorations possibles et suggestions d’améliorations futures

Veiller à mettre en place l'environnement interconnecté au plus tôt et réaliser des tests fonctionnels tout au long du projet pour s'assurer de la viabilité des scripts et du partage à distance. 
