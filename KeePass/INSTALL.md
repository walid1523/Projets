 
 
 ## Installation Keepass ## 
 
- Tout d'abort il est important de noter que Keepass est compatible avec les versions Windows 7 / 8 / 10 / 11 (en version 32-bit et 64-bit), mais aussi les versions serveurs. Il faudra noter aussi, qu'en se qui concerne la configuration minimale nécessaire, cette dernière est moindre que celle pour les systèmes d'exploitations sus mentionés. Son process d'installation et de mise à jour en français est identique quelle que soit le systèmes d'exploitation. 
- Allez sur **Keepass.fr** (https://keepass.info/download.html) et téléchargez la dernière version correspondant à votre système d’exploitation.  Nous vous conseillons la version 2.57.1, pour y accéder cliquez directement sur la version.![**Version 2.57.1**](https://github.com/user-attachments/assets/c5ff16f5-352d-44c3-ad14-4c557754c5f4) 
- Allez dans le dossier où s'est télécharger le fichier.exe, lancez l'instalation, sélectionnez les options que vous désirez, après avoir choisi ou il sera installé cliquez sur suivant.
Notez que Keepas est en Anglais mais qu'il existe un fichier additionel pour le traduire en Fançais.

## Comment passer Keepass en Français #

- Lancer **Keepass**, 
- Appuyer sur l’onglet View, puis sur Change Language ![**Change Language...**](https://github.com/user-attachments/assets/642501b6-aed3-4ba6-a02f-7a59c052b890)
- Puis sur **Get More Languages**, enfin aller à la ligne French, **Version 2.31+**![5](https://github.com/user-attachments/assets/2c95f066-f697-4fa9-849c-d6aa3e7a9636)

- Une fois le fichier télécharger, extrayer le fichier à la racine de Keepas dans le dossier */Keepass Password Safe 2/Languages*.
- Relancer Keepass, appuyer sur l’onglet View, puis sur **Change Language**, double cliquer sur French puis redémarrer l’application pour valider les étapes.
- ![6](https://github.com/user-attachments/assets/8c493b21-3568-46a5-bf90-8f2d1bc12faf)

## Configuration pour Windows serveur 2022 : Créer la base de données KeePass

- **Ouvrez KeePass** sur le serveur.
- Cliquez sur **Fichier > Nouveau** pour créer une nouvelle base de données.
- Sélectionnez l’emplacement où vous souhaitez enregistrer la base de données (par exemple : sur un dossier partagé accessible par tous les clients).
- Donnez un nom à la base de données et cliquez sur **Enregistrer**.
- Configurez une méthode de sécurité pour la base de données :
- **Mot de passe principal** : Un mot de passe fort pour protéger la base.
- **Fichier clé** : Utilisation d’un fichier clé (stocké sur un support externe comme une clé USB) pour augmenter la sécurité.
- **Mot de passe + fichier clé** : Option recommandée pour une sécurité accrue.
- Une fois configuré, cliquez sur **OK

 
## Attention de configurer les permissions du dossier partagé sur le serveur ##

- **Créez un dossier partagé** sur le serveur :
- Cliquez droit sur un dossier > **Propriétés** > **Partage** > **Partage avancé**.
- Cochez l'option **Partager ce dossier**.
- Cliquez sur **Autorisations** et ajoutez les utilisateurs ou groupes qui doivent avoir accès.
- Assurez-vous que les permissions de lecture/écriture sont correctement configurées.

Notez le chemin réseau du dossier partagé (par exemple : `\\serveur\partage\KeePass`).
 
## Configuration pour Windows 10 ##

- Evidement ce process a déjà été éxcécuter sur le Serveur. 
- **Lancer KeePass** sur le PC client.
- Vérifier l' accés à la base de données partagée ; ouvrir la base de données partagée via "Fichier/Ouvrir" dans KeePass, sélectionner le fichier *.kdbx* qui se trouve dans - le dossier réseau partagé ou sur le service cloud, entrer le mot de passe maître (et le fichier clé si configuré) pour accéder à la base de données.





## FAQ ##

- Problème d'accès à la base de donnée du serveur : Assurez-vous que le compte utilisateur du PC client est bien actif et connu sur le serveur.
