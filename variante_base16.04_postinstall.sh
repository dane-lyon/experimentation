#!/bin/bash
## A MODIFIER


# AVERTISSEMENT
# Ce 2ème script post-install est optionnel et conçu pour toutes les variantes d'Ubuntu basé sur la 16.04 comme :
# Xubuntu 16.04, Lubuntu 16.04, Ubuntu Gnome 16.04, Ubuntu Mate 16.04, Linux Mint 18

#############################################
# Run using sudo, of course.
#############################################
if [ "$UID" -ne "0" ]
then
  echo "Il faut etre root pour executer ce script. ==> sudo "
  exit 
fi 

# Vérification que le système est a jour
apt-get update && apt-get -y dist-upgrade

#-----------------------------------------
# Installation de logiciel supplémentaire 
#-----------------------------------------

#[[bureautique]]
apt-get -y install ttf-mscorefonts-installer libreoffice libreoffice-gtk libreoffice-l10n-fr libreoffice-help-fr freeplane scribus

#[[web]]
apt-get -y install firefox chromium-browser flashplugin-downloader pepperflashplugin-nonfree

#[[multimedia]]
apt-get -y install gimp pinta imagination openshot audacity inkscape gthumb vlc x264 x265 ffmpeg2theora flac vorbis-tools lame mypaint libdvdread4

#[[systeme]]
apt-get -y install gparted vim pyrenamer unrar htop shutter

#[[mathematiques]]
apt-get -y install geogebra algobox carmetal

#[[sciences]]
apt-get -y install stellarium celestia avogadro

#[[programmation]]
apt-get -y install scratch idle-python3.5 ghex geany imagemagick

## Custom spécifique Xubuntu

# créer un menu qui demande si il faut customiser Xubuntu
#si oui alors :

apt-get -y install plank
wget http://nux87.online.fr/xubuntu16.04/skel.tar.gz
tar xzvf skel.tar.gz -C /etc && rm -rf skel.tar.gz

#-----------------------------------------
# Fin
#-----------------------------------------

echo "L'installation est terminé, voulez vous rebooter ?"
read -p "Voulez-vous redémarrer immédiatement ? [O/n] " rep_reboot
if [ "$rep_reboot" = "O" ] || [ "$rep_reboot" = "o" ] || [ "$rep_reboot" = "" ] ; then
  reboot
fi
