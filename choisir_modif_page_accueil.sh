#!/bin/bash

########### ce script est pour modifier la page d'accueil de firefox et I.E. #############
###########  DANE rectorat de lyon #########
###########  Virginie  Favrat  &  Jean Philippe Patrizio. ########


########### on efface l'écran
clear

echo -e "\n\n\n\n"

echo "ce script permet de modifier dans tous les groupes machines, la page d'accueil google.fr par la page de votre choix."

#### on sauvegarde le dossier esu

cp -r /home/esu /home/esu.bak

echo -e "\n\n"

read -p "		Saisissez le domaine ex: (https://lite.qwant.com) que vous souhaitez déployer : " domaine

#### Attention on échape les caractères // avec # comme séparateur.

domaine=$(echo $domaine | sed 's#/#\\/#g')

#### On remplace

sed -i 's/\(<Variable nom="Start Page.*>\)\(.*\)\(<\/Variable>\)/\1'$domaine'\3/' /home/esu/Base/*/*xml

sed -i 's/\(<Variable nom="browser.startup.homepage.*>\)\(.*\)\(<\/Variable>\)/\1'$domaine'\3/' /home/esu/Base/*/*xml
