#!/bin/bash

#téléchargement des paquets
wget http://nux87.online.fr/esu_ubuntu/esu_ubuntu.zip
unzip esu_ubuntu.zip
  
#création du dossier upkg
mkdir /usr/local/upkg_client/
chmod -R 777 /usr/local/upkg_client

#installation de cntlm zenity et conky
apt-get install -y zenity conky #cntlm 

#on lance la copie des fichiers
cp -rf ./esu_ubuntu/lightdm/* /etc/lightdm/
chmod +x /etc/lightdm/*.sh
cp -rf ./esu_ubuntu/xdg_autostart/* /etc/xdg/autostart/
chmod +x /etc/xdg/autostart/message_scribe.desktop
chmod +x /etc/xdg/autostart/scribe_background.desktop
  
#on lance la gestion du groupe
#salle du pc
echo "Veuillez entrer le groupe ESU de vos postes clients linux : "
read salle
echo "$salle" > /etc/GM_ESU

#on lance le script prof_firefox
chmod -R +x ./esu_ubuntu
./esu_ubuntu/firefox/prof_firefox.sh
  
# Mise en place des wallpaper pour les élèves, profs, admin
wget http://nux87.online.fr/esu_ubuntu/wallpaper.zip
unzip wallpaper.zip
mv wallpaper /usr/share/

#on inscrit la tache upkg dans crontab
echo "*/20 * * * * root /etc/lightdm/groupe.sh" > /etc/crontab
  
#dans le cas ou il resterai encore une trace de cntlm dans xdg autostart :
rm -f /etc/xdg/autostart/cntlm*

exit
