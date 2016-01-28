#! /bin/bash
# remplacement valeur de la page url dans  la configuration ESU
cp -a /home/esu /home/esu.backup
read -p "Veuillez indiquer l'ancien url par défaut sans le http:// devant (exemple : google.fr)" oldurl
read -p "Donnez la valeur du nouveau url sans le http:// devant (exemple : lite.qwant.com) :" newurl
# remplacement de l'ancienne valeur par la nouvelle valeur dans la configuration ESU existante
sed -i  "s|$oldurl|$newurl|g" /home/esu/Base/*/*xml
exit 0
