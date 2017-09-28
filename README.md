# EXPERIMENTATION

Scripts en version Beta qui ont besoin de tests complémentaires. Merci pour les retours !

## ESUBUNTU

### Présentation du projet Esubuntu

ESUBUNTU a été développé par Olivier Calpetard du lycée Antoine Roussin à La Réunion. A la DANE de Lyon, nous avons essayé de le scripter le plus possible afin de faciliter son déploiement.
Il permet :
* de lancer des commandes de manière centralisée (installation d'applications, scripts...)
* d'obtenir des fonds d'écran différents entre élèves et enseignants (admin aura le fond prof)
* d'avoir un panel d'informations en fond : nom du poste, personne connectée, adresse IP, quota... 
* déport de la configuration de Firefox

### Mise en place d'Esubuntu 

**Rappel : validé/testé uniquement pour Ubuntu/Unity en 14.04)**

#### Mise en place du script

1. Créer un nouveau groupe ESU (via la console ESU) pour vos clients Linux, par exemple "posteslinux"
1. Télécharger le contenu de l'archive et le décompresser dans votre nouveau groupe esu pour linux.
Lien ici : https://github.com/dane-lyon/fichier-de-config/blob/master/dans_groupe-esu_linux.zip?raw=true
1. Ensuite sur le poste client Ubuntu, lancer la nouvelle version du Script (dans la partie expérimentation), lien direct ici : 
https://raw.githubusercontent.com/dane-lyon/experimentation/master/ubuntu_integrdom_V2_test
1. Une nouvelle question sera posée "voulez-vous activer esu_ubuntu" : répondre "Oui".
1. Le nom du groupe esu sera demandé, il faudra mettre exactement le même nom que le nouveau groupe esu créé précédemment.
1. A la fin, redémarrer le poste.


#### Paramétrage de upkg (équivalent de WPKG pour Windows)

Dans le groupe esu linux, il y a un dossier "linux" et dedans un dossier "upkg", à l'intérieur 3 fichiers :
* upkg.txt : ne pas toucher pas à ce fichier sauf si l'on veut complètement désactiver cette fonctionnalité (dans ce cas passez la valeur de 1 à 0).
* script_install.sh : c'est dans ce script qu'on indiquera ce qu'on veut déployer, par exemple si l'on veut mettre à jour tous les postes, il faut mettre ceci :

```bash
          #!/bin/bash
          sudo apt-get update
          sudo apt-get dist-upgrade -y
```
          
Si on veut déployer le logiciel "htop" sur tous les postes :
    ```bash

          #!/bin/bash
          sudo apt-get install htop -y
           ```
    
          
Si on veut supprimer le logiciel vlc sur tous les postes :
    ```bash

          #!/bin/bash
          sudo apt-get remove vlc -y
     ```

### Paramétrages complémentaires

* Il est possible de personnaliser le panel conky en allant dans son groupe ESU puis "conky" et enfin fichier "conky.cfg"
* La config de Firefox est déporté aussi dans le groupe_esu. Il est ainsi possible de modifier la page d’accueil et le proxy de tous les postes d'un seul coup, pour cela il faut modifier le fichier "firefox.js" dans le dossier "linux" du groupe esu.
_Attention : le proxy est géré aussi par ce fichier, par défaut il est paramétré sur 172.16.0.252, si l'on a autre chose, bien penser à modifier la valeur._
* Le script upkg n'est lancé qu'une seule fois sur les postes, pour qu'il soit de nouveau lancé (par exemple si on a fait 
des changements dans le script), on doit modifier le fichier "stamp.date", en effet ce fichier est comparé à chaque fois 
avec celui présent en local sur les machines, si il y a une différence, alors le script est lancé et le fichier local maj 
à l'identique sinon rien n'est lancé. 
* Par défaut la période de rafraîchissement pour la vérification est de 20 minutes donc on peut attendre jusqu’à 20 minutes 
maximum avant d'avoir le script de lancé sur les postes clients. Si on veut modifier cette durée, c'est dans le fichier 
/etc/crontab.
* Dernière précision : si vous avez un Scribe en version 2.4, 2.5 ou 2.6, pensez à faire ceci pour avoir les partages réseaux :
https://dane.ac-lyon.fr/spip/Client-Linux-activer-les-partages
