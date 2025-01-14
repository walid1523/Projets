## Guide Administrateur

### Sommaire
- [1. Introduction](#1-introduction)
- [2. Prérequis techniques](#2-prérequis-techniques)
- [3. Installation et configuration](#3-installation-et-configuration)
  - [Configuration du script PowerShell sur Windows Server](#configuration-du-script-powershell-sur-windows-server)
  - [Configuration du script shell sur Debian](#configuration-du-script-shell-sur-debian)
  - [Configuration des machines clientes (Windows)](#configuration-des-machines-clientes-windows)
  - [Configuration des machines clientes (Ubuntu)](#configuration-des-machines-clientes-ubuntu)
  - [Vérification de la configuration](#vérification-de-la-configuration)
- [4. FAQ](#4-faq)
- [5. Conclusion](#5-conclusion)

### 1. Introduction

Ce projet vise à automatiser des tâches sur des machines distantes à l'aide de scripts.
2. Utilisation de base
Lancement du script sur Windows

Les scripts Bash et PowerShell permettent d'automatiser des tâches liées à la gestion des utilisateurs et des ordinateurs, telles que la création ou la modification d'utilisateurs, la récupération d'informations système, etc. Ils vous proposent un menu interactif qui permettent aux utilisateurs de choisir facilement l'action à effectuer, en appelant les scripts correspondants pour chaque tâche.

Le script Bash est prévu pour fonctionner depuis une machine Serveur Debian et pour intéragir avec une machine client Ubuntu et le script PowerShell est prévu pour fonctionner depuis une machine Serveur Windows et pour intéragir avec une machine client Windows.

### 2. Prérequis techniques

Configuration requise des machines (serveur et clientes)

| Type machine | Nom | Système d'exploitation | Compte | Adresse IP fixe |
| :---: | :---: | :---: | :---: | :---: |
Client | CLIWIN01 | Windows 10 | utilisateur wilder | 172.16.10.20/24
Client | CLILIN01 | Ubuntu 22.04/24.04 LTS | utilisateur wilder | 172.16.10.30/24
Serveur | SRVWIN01 | Windows Server 2022 | Administrator | 172.16.10.5/24
Serveur | SRVLIX01 | Debian 12 | root | 172.16.10.10/24


### 3. Installation et configuration
#### Configuration du script PowerShell sur Windows Server et machine client Windows

Pour que le serveur puisse envoyer des commandes à la machine cliente à distance, PowerShell Remoting doit être activé. Ce service permet au serveur d'exécuter des scripts sur un autre ordinateur via le réseau.

**Installation et configuration de WinRM**

WinRM (Windows Remote Management) est un service utilisé pour permettre à un serveur de communiquer à distance avec une machine cliente Windows. Il doit être installé et configuré sur la machine cliente pour accepter les connexions à distance.

Étapes pour installer et configurer WinRM :

- Activer WinRM sur la machine cliente : ouvrez PowerShell en mode administrateur et exécutez cette commande pour activer WinRM :

```bash
Enable-PSRemoting -Force
``` 

  Cette commande active WinRM et configure la machine pour accepter les connexions à distance.

- Vérifier la configuration de WinRM : pour vérifier que WinRM est bien activé sur la machine cliente, vous pouvez exécuter cette commande depuis le serveur :

```bash
Test-WsMan -ComputerName <NomDeLaMachineClient>
```

Si WinRM est activé, vous verrez une réponse indiquant que la machine cliente est prête à recevoir des commandes.

- Ouvrir les ports nécessaires dans le pare-feu : si un pare-feu est activé sur la machine cliente, vous devrez vous assurer que les ports nécessaires à WinRM (port 5985 pour HTTP, port 5986 pour HTTPS) sont ouverts.

Pour ce faire, tapez cette commande dans PowerShell sur la machine cliente :

```bash
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"
```

#### Configuration du script shell sur Debian et machine cliente Ubuntu

Pour que le serveur Debian puisse envoyer des commandes à la machine cliente Ubuntu à distance, SSH (Secure Shell) doit être activé. Ce service permet au serveur d'exécuter des scripts sur un autre ordinateur via le réseau.

SSH (Secure Shell) est un service qui permet de communiquer à distance entre une machine serveur Debian et une machine cliente Ubuntu. Il doit être installé et configuré sur la machine cliente pour accepter les connexions à distance.

**Installation et configuration de SSH**

- Installer le serveur SSH sur la machine cliente Ubuntu : sur la machine cliente Ubuntu, ouvrez un terminal et exécutez la commande suivante pour installer le serveur SSH 

```bash
sudo apt update
sudo apt install openssh-server
```

Cette commande installe le serveur SSH et configure la machine cliente Ubuntu pour accepter les connexions à distance via SSH.

- Vérifier la configuration de SSH : pour vérifier que SSH est bien installé et fonctionne sur la machine cliente Ubuntu, vous pouvez utiliser cette commande pour vérifier l'état du service SSH :

```bash
sudo systemctl status ssh
```

Si SSH est activé, vous verrez un message indiquant que le service SSH est "en cours d'exécution".

- Vérifier la connexion SSH : depuis le serveur Debian, vous pouvez tester la connexion SSH à la machine cliente Ubuntu avec cette commande 

```bash
ssh <utilisateur>@<Adresse_IP_de_la_machine_client>
```

Si la connexion est réussie, vous serez invité à entrer le mot de passe de l'utilisateur sur la machine cliente Ubuntu. Cela confirme que SSH est bien configuré et que le serveur peut accéder à la machine cliente à distance.

- Ouvrir les ports nécessaires dans le pare-feu : si un pare-feu est actif sur la machine cliente Ubuntu, vous devez vous assurer que le port 22 (port par défaut pour SSH) est ouvert. Si vous utilisez UFW (Uncomplicated Firewall), vous pouvez ouvrir ce port avec la commande suivante 
```bash
sudo ufw allow ssh
```
Cette commande autorise les connexions SSH entrantes sur le port 22, permettant ainsi au serveur Debian de se connecter à la machine cliente Ubuntu via SSH.

- Exécuter des commandes à distance via SSH : une fois SSH configuré, vous pouvez exécuter des scripts ou des commandes à distance depuis le serveur Debian sur la machine cliente Ubuntu. Par exemple, pour exécuter un script à distance, vous pouvez utiliser la commande suivante depuis le serveur :

```bash
ssh <utilisateur>@<Adresse_IP_de_la_machine_client> 'bash -s' < /path/to/script.sh
```

Cette commande permet d'exécuter le script spécifié sur la machine cliente Ubuntu à distance.

#### Vérification de la configuration
Pour vous assurer que tout fonctionne correctement après avoir installé et configuré WinRM (pour Windows) ou SSH (pour Debian/Ubuntu), il est important de vérifier que les services sont bien activés et que les machines peuvent communiquer entre elles. Voici comment procéder :

**Vérification de WinRM sur Windows :**

Sur la machine serveur (Windows), vous pouvez tester la connexion à la machine cliente en utilisant la commande PowerShell suivante :

```bash
Test-WsMan -ComputerName <NomDeLaMachineClient>
```

Si WinRM est correctement configuré sur la machine cliente, cette commande retournera un message de succès. Cela signifie que le serveur peut communiquer avec la machine cliente à distance.

**Vérification de SSH sur Debian/Ubuntu :**

Sur le serveur Debian, testez la connexion SSH à la machine cliente Ubuntu avec la commande suivante :

```bash
ssh <utilisateur>@<Adresse_IP_de_la_machine_client>
```

Si SSH est activé et fonctionne correctement sur la machine cliente, vous serez invité à entrer le mot de passe de l'utilisateur. Une fois le mot de passe correct saisi, vous serez connecté à la machine cliente, ce qui confirme que SSH est configuré correctement.

**Points de vigilance pour assurer une configuration correcte :**

Vérifiez les services : Assurez-vous que WinRM (sur Windows) ou SSH (sur Ubuntu) est bien en cours d'exécution. Si le service n'est pas démarré, les connexions à distance échoueront.

- **Pare-feu** : vérifiez que les ports nécessaires sont ouverts dans le pare-feu. Pour WinRM, ce sont les ports 5985 et 5986. Pour SSH, c'est le port 22. Si ces ports ne sont pas ouverts, les connexions à distance seront bloquées.

- **Connexion réseau** : Assurez-vous que les machines serveur et cliente peuvent communiquer entre elles sur le réseau. Vous pouvez utiliser la commande ping pour tester la connectivité entre les deux machines.

- **Permissions utilisateurs** : Vérifiez que l'utilisateur qui exécute les scripts a les autorisations nécessaires sur la machine cliente pour effectuer les actions demandées.

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

L'automatisation des tâches à distance est une solution simple et efficace pour faciliter la gestion des systèmes. Avec des scripts PowerShell sur Windows et Bash sur Linux, cela permet d'exécuter des actions à distance sans avoir à intervenir sur chaque machine.

En activant des services comme WinRM pour Windows ou SSH pour Linux, il est possible de connecter les serveurs aux machines clientes et exécuter des commandes facilement. Cela permet de gérer des utilisateurs, récupérer des informations système, etc, pour gagner en temps et en efficacité.
