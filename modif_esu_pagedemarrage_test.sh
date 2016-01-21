#! /bin/bash

# remplacement valeur de la page d'acceuil dans  la configuration ESU

cp -a /home/esu /home/esu.backup

read -p "Donnez l'adresse url pour la page de démarrage ?" urldefault

# remplacement de l'ancienne valeur par la nouvelle valeur dans la configuration ESU existante
sed -i  "s/$/$/g" /home/esu/Base/*/*xml
exit 0
