## Guide Utilisateur

### Sommaire
- [1. Introduction](#1-introduction)
- [2. Utilisation de base](#2-utilisation-de-base)
  - [Lancement du script sur Windows](#lancement-du-script-sur-windows)
  - [Lancement du script sur Debian](#lancement-du-script-sur-debian)
  - [Interaction avec les machines clientes](#interaction-avec-les-machines-clientes)
- [3. Utilisation avancée](#3-utilisation-avancée)
  - [Automatisation des tâches](#automatisation-des-tâches)
- [4. FAQ](#4-faq)
  - [Problèmes courants](#problèmes-courants)
  - [Solutions simples](#solutions-simples)
- [5. Conclusion](#5-conclusion)

### 1. Introduction
Ce projet vise à automatiser des tâches sur des machines distantes à l'aide de scripts. 

### 2. Utilisation de base
#### Lancement du script sur Windows
Le script PowerShell permet d'automatiser des tâches liées à la gestion des utilisateurs et des ordinateurs, telles que la création ou la modification d'utilisateurs, la récupération d'informations système, etc. Il vous propose un menu interactif qui vous permet de choisir facilement l'action à effectuer, en appelant les scripts correspondants pour chaque tâche.

Le script PowerShell est prévu pour fonctionner depuis une machine Serveur Windows et pour intéragir avec une machine client Windows.

*Points de vigilance :*

*Les scripts du menu principal et des scripts appelés en source doivent se trouver au même endroit pour que l'automatisation fonctionne telle que prévue.*

#### Lancement du script sur Debian
Le script Bash permet d'automatiser des tâches liées à la gestion des utilisateurs et des ordinateurs, telles que la création ou la modification d'utilisateurs, la récupération d'informations système, etc. Il vous propose un menu interactif qui vous permet de choisir facilement l'action à effectuer, en appelant les scripts correspondants pour chaque tâche.

Le script Bash est prévu pour fonctionner depuis une machine Serveur Debian et pour intéragir avec une machine client Ubuntu.
  *Points de vigilance :*
  
  *Les scripts du menu principal et des scripts appelés en source doivent se trouver au même endroit pour que l'automatisation fonctionne telle que prévue.*

#### Interaction avec les machines clientes
Dans le cadre des scripts d'automatisation, les machines serveur envoient des instructions aux machines clientes pour effectuer des tâches à distance, comme la gestion des utilisateurs ou la récupération d'informations système, permettant ainsi de simplifier et d'accélérer l'administration des ordinateurs.

### 3. Utilisation avancée
#### Automatisation des tâches
Une utilisation avancée de l'automatisation des tâches consiste à créer des scripts complexes qui non seulement exécutent des actions répétitives sur plusieurs machines en même temps, mais aussi collectent et analysent des données en temps réel, déclenchent des alertes en cas d'anomalies, et génèrent des rapports détaillés pour optimiser la gestion et la maintenance des systèmes.

### 4. FAQ
#### Problèmes courants
Les problèmes courants dans le scripting Bash et PowerShell pour l'automatisation de tâches à distance incluent des erreurs de connexion réseau, des permissions insuffisantes, des conflits de versions de script sur les différentes machines, et des problèmes de compatibilité entre les systèmes d'exploitation.

#### Solutions simples
Voici des solutions simples pour les problèmes courants dans les scripts d'automatisation à distance :

- Erreurs de connexion réseau : vérifiez que les machines peuvent se "pinguer" entre elles et que les bons ports sont ouverts.
- Permissions insuffisantes : assurez-vous que l'utilisateur a les droits nécessaires pour exécuter les scripts à distance.
- Problèmes de compatibilité entre systèmes d'exploitation : utilisez des scripts compatibles avec plusieurs systèmes ou séparez les scripts pour chaque OS.
- Erreurs de syntaxe et de logique : testez les scripts localement avant de les exécuter à distance.
- Problèmes de variables et d'environnement : vérifiez que les variables nécessaires sont définies correctement sur chaque machine.

### 5. Conclusion
En résumé, l'automatisation des tâches à distance via des scripts permet de gagner du temps et d'améliorer l'efficacité de l'administration système. 

Il est important de suivre les bonnes pratiques pour éviter les erreurs courantes, comme les problèmes de connexion, de permissions ou de compatibilité, et de tester systématiquement les scripts pour s'assurer de leur bon fonctionnement. 
