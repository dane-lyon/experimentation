#! /bin/bash
# remplacement valeur du proxy dans  la configuration ESU
cp -a /home/esu /home/esu.backup
read -p "Veuillez indiquer exactement l'ancien url par défaut (exemple : https://www.google.fr)" oldurl
read -p "Donnez la valeur du nouveau url (exemple : https://lite.qwant.com) :" newurl
# remplacement de l'ancienne valeur par la nouvelle valeur dans la configuration ESU existante
sed -i  "s/$oldurl/$newurl/g" /home/esu/Base/*/*xml
exit 0
