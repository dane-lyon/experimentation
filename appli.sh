#!/bin/bash

# Script crée par Simon BERNARD
# précision : non terminé

# -----------------------------------------------------
# Vérification que le script est lancé avec sudo
# -----------------------------------------------------

if [ "$UID" -ne "0" ]
then
  echo "Il faut etre root pour executer le script => sudo !!"
  exit 
fi 

# -----------------------------------------------------
# choix du profil
# -----------------------------------------------------

echo "Voici la liste des profils d'applications diposnibles : "

echo "a = établissement scolaire - distribution Ubuntu Trusty (14.04) ou variante"
echo "b = établissement scolaire - distribution Debian Jessie (8) ou variante"
echo "c = technicien sous linux / DANE - distribution Ubuntu Trusty (14.04) ou variante"
echo "d = technicien sous linux / DANE - distribution Debian Jessie (8) ou variante"
echo "e = utilisation personnelle - distribution Ubuntu Trusty (14.04) ou variante"
echo "f = utilisation personnelle - distribution Debian Jessie (8) ou variante"
echo "g = utilisation sous Archlinux"
echo "h = utilisation familiale - distribution Ubuntu Trusty (14.04) ou variante"
echo "i = utilisation familiale - distribution Debian Jessie (8) ou variante"
echo "j = profil libre non défini 1"
echo "k = profil libre non défini 2"
echo "l = profil libre non défini 3"
echo "m = profil libre non défini 4"

read -p "Répondre par la lettre correspondante en minuscule (exemple : f) : " rep


# -----------------------------------------------------
# Profil "a" : établissement scolaire - distribution Ubuntu Trusty (14.04) ou variante
# -----------------------------------------------------

if [ "$rep" = "a" ] ; then
        echo "profil a"

#maj
apt-get update && apt-get -y dist-upgrade

#bureautique
apt-get -y install ttf-mscorefonts-installer libreoffice libreoffice-l10n-fr libreoffice-help-fr freeplane scribus
#UI
#apt-get -y install xubuntu-restricted-extras xubuntu-restricted-addons xfce4-goodies xfwm4-themes ## pour XFCE
#apt-get -y install ubuntu-restricted-extras ubuntu-restricted-addons ## Pour Unity
#apt-get -y install lubuntu-restricted-extras lubuntu-restricted-addons ## Pour Lxde

#internet
apt-get -y install firefox chromium-browser flashplugin-downloader pepperflashplugin-nonfree

#multimedia
apt-get -y install gimp pinta imagination openshot audacity inkscape gthumb vlc x264 ffmpeg2theora flac vorbis-tools lame mypaint libdvdread4

#systeme
apt-get -y install gparted vim pyrenamer unrar htop shutter

#math
apt-get -y install geogebra algobox carmetal

#sciences
apt-get -y install stellarium celestia avogadro

#prog
apt-get -y install scratch idle-python2.7

#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 
        
else

# -----------------------------------------------------
# Profil "b" : établissement scolaire - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "b" ] ; then
                echo "profil b"
                
#maj
apt-get update && apt-get -y dist-upgrade

#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 

else     

# -----------------------------------------------------
# Profil "c" : technicien sous linux / DANE - distribution Ubuntu Trusty (14.04) ou variante
# -----------------------------------------------------

if [ "$rep" = "c" ] ; then
                echo "profil c"
                
#maj
apt-get update && apt-get -y dist-upgrade

#bureautique
apt-get -y install ttf-mscorefonts-installer libreoffice libreoffice-l10n-fr zim dia
#UI
#apt-get -y install xubuntu-restricted-extras xubuntu-restricted-addons xfce4-goodies xfwm4-themes ## pour XFCE
#apt-get -y install ubuntu-restricted-extras ubuntu-restricted-addons ## Pour Unity
#apt-get -y install lubuntu-restricted-extras lubuntu-restricted-addons ## Pour Lxde

#internet
apt-get -y install firefox thunderbird pidgin chromium-browser flashplugin-downloader pepperflashplugin-nonfree xchat

#multimedia
apt-get -y install gimp pinta vlc 

#systeme
apt-get -y install gparted vim unrar htop shutter keepassx virtualbox

#prog
apt-get -y install scratch idle-python2.7 bluefish pgadmin3

#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 


else  

# -----------------------------------------------------
# Profil "d" : technicien sous linux / DANE - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "d" ] ; then
                echo "profil d"
                
#maj
apt-get update && apt-get -y dist-upgrade

#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 

else  

# -----------------------------------------------------
# Profil "e" : utilisation personnelle - distribution Ubuntu Trusty (14.04) ou variante
# -----------------------------------------------------

if [ "$rep" = "e" ] ; then
                echo "profil e"
                
#maj
apt-get update && apt-get -y dist-upgrade

#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 

else  

# -----------------------------------------------------
# Profil "f" : utilisation personnelle - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "f" ] ; then
                echo "profil f"
                
#maj
apt-get update && apt-get -y dist-upgrade

#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 

else  

# -----------------------------------------------------
# Profil "g" : utilisation sous Archlinux
# -----------------------------------------------------

if [ "$rep" = "g" ] ; then
                echo "profil g"
                
#maj
pacman -Syu

#bureautique
pacman -S libreoffice-fresh libreoffice-fresh-fr

#internet
pacman -S firefox firefox-i18n-fr thunderbird thunderbird-i18n-fr chromium flashplugin qupzilla

#multimedia
pacman -S gimp pinta openshot audacity inkscape gthumb vlc x265 flac lame libdvdread

#systeme
pacman -S gparted vim unrar htop shutter

#sciences
pacman -S celestia

#prog
pacman -S bluefish scratch emacs terminator

#nettoyage
#pacman -Qdtq && pacman -Sc && pacman -Rs -

else  

# -----------------------------------------------------
# Profil "h" : utilisation familiale - distribution Ubuntu Trusty (14.04) ou variante
# -----------------------------------------------------

if [ "$rep" = "h" ] ; then
                echo "profil h"
                
#maj
apt-get update && apt-get -y dist-upgrade






#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 

else  

# -----------------------------------------------------
# Profil "i" : utilisation familiale - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "i" ] ; then
                echo "profil i"
                
#maj
apt-get update && apt-get -y dist-upgrade

#nettoyage
apt-get -y autoremove --purge && apt-get -y clean 

else  
                
# -----------------------------------------------------
# Profil "j" : profil libre non défini 1
# -----------------------------------------------------

if [ "$rep" = "j" ] ; then
                echo "profil j"
else                  
                
# -----------------------------------------------------
# Profil "k" : profil libre non défini 2
# -----------------------------------------------------

if [ "$rep" = "k" ] ; then
                echo "profil k"
else  

# -----------------------------------------------------
# Profil "l" : profil libre non défini 3
# -----------------------------------------------------

if [ "$rep" = "l" ] ; then
                echo "profil l"
else  

# -----------------------------------------------------
# Profil "m" : profil libre non défini 4
# -----------------------------------------------------

if [ "$rep" = "m" ] ; then
                echo "profil m"

# Fin de la mega-boucle...
                                                                                                fi
                                                                                        fi
                                                                                fi
                                                                        fi
                                                                fi
                                                        fi
                                                fi
                                        fi
                                fi
                        fi
                fi
        fi
fi

# -----------------------------------------------------
# Fin
# -----------------------------------------------------

echo "Installation des paquets terminés !"
read -p "Voulez-vous redémarrer immédiatement ? [O/n] " rep_reboot
if [ "$rep_reboot" = "O" ] || [ "$rep_reboot" = "o" ] ; then
  reboot
fi
