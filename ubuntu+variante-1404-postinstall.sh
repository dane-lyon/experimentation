#!/bin/bash

#############################################
# Run using sudo, of course.
#############################################
if [ "$UID" -ne "0" ]
then
  echo "Il faut etre root pour executer ce script. ==> sudo "
  exit 
fi 

# Vérification que le système est a jour
apt-get update ; apt-get -y dist-upgrade

################################
# Concerne toutes les variantes
################################

# trouver solution pour ce paquet pour pas demander confirmation :
apt-get -y --force-yes install ttf-mscorefonts-installer

#[ Bureautique ]

# LibreOffice toujours en dernière version (PPA)
add-apt-repository -y ppa:libreoffice/ppa ; apt-get update ; apt-get -y upgrade
apt-get -y install libreoffice libreoffice-l10n-fr libreoffice-help-fr 

apt-get -y install freeplane scribus

#[ Web ]
apt-get -y install firefox chromium-browser flashplugin-downloader pepperflashplugin-nonfree

#[ Multimedia ]
apt-get -y install gimp pinta imagination openshot audacity inkscape gthumb vlc x264 ffmpeg2theora flac vorbis-tools lame mypaint

#[ Systeme ]
apt-get -y install gparted vim pyrenamer unrar htop shutter

#[ Mathematiques ]
apt-get -y install geogebra algobox carmetal

#[ Sciences ]
apt-get -y install stellarium celestia avogadro

#[ Programmation ]
apt-get -y install scratch idle-python3.4 ghex geany imagemagick


################################
# Concerne Ubuntu / Unity
################################

#si variante = ubu alors :

#[ Paquet AddOns ]
apt-get -y install ubuntu-restricted-extras ubuntu-restricted-addons



################################
# Concerne Xubuntu / XFCE
################################

#si variante = xub alors :

#[ Paquet AddOns ]
apt-get -y install xubuntu-restricted-extras xubuntu-restricted-addons xfce4-goodies xfwm4-themes

# Customisation XFCE

add-apt-repository -y ppa:docky-core/stable ; apt-get update ; apt-get -y install plank
wget http://lien/skel.tar.gz ; tar xzvf skel.tar.gz -C /etc ; rm -rf skel.tar.gz
