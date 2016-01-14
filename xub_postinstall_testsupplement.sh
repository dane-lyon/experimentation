#!/bin/bash

# AVERTISSEMENT
# Ce 2ème script post-install est optionnel et conçu pour la variante "Xubuntu" exclusivement, si vous utilisez une autre 
# variante, vous devez le modifier avant, en particulier la partie "customisation" qui est faite pour Xfce uniquement !

#############################################
# Run using sudo, of course.
#############################################
if [ "$UID" -ne "0" ]
then
  echo "Il faut etre root pour executer ce script. ==> sudo "
  exit 
fi 

#############################################
# Installation niveau débutant ou avancé ?
#############################################
echo "Installation du script en mode "normale/simple" (conseillé) ou "avancé" ?"
echo "[0] Installation standard (simple, choix recommandé par défaut !)
echo "[1] Installation niveau avancée (pour les linuxiens qui s'y connaissent)
read -p "Tapez 0 pour l'installation par défaut ou 1 pour le mode avancé" rep_install
if [ "$rep_install" = "1" ] ; then

##### Spécifique au niveau avancé #####
### Backportage LO ? ###
echo "Activer le backportage de LibreOffice dans sa dernière version stable possible ?"
read -p "Tapez "n" ou aucune valeure si c'est non sinon tapez 'o" si c'est oui.[n/o]" rep_lo
if [ "$rep_lo" = "o" ] ; then
  add-apt-repository -y ppa:libreoffice/ppa 
  apt-get update
fi

### Backportage du Kernel sous la 14.04 ? ###
echo "Activer le backportage du kernel pour la 14.04 ?"
echo "0 ou aucune valeure saisie = non (conseillé)"
echo "1 = oui, noyau 3.16.X (utopic)"
echo "2 = oui, noyau 3.19.X (vivid)"
echo "3 = oui, noyau 4.2.X (wily)"
read -p "Répondre par le chiffre correspondant (0,1,2,3) : " rep_kernel

if [ "$rep_kernel" = "1" ] ; then
        apt-get -y install linux-image-generic-lts-utopic
        else if [ "$rep_kernel" = "2" ] ; then
                apt-get -y install linux-image-generic-lts-vivid
                else if [ "$rep_kernel" = "3" ] ; then
                        apt-get -y install linux-image-generic-lts-wily
                     fi
             fi
fi







# Vérification que le système est a jour
apt-get update && apt-get -y dist-upgrade

#-----------------------------------------
# Installation de logiciel supplémentaire 
#-----------------------------------------

#[[Paquet demandant confirmation utilisateur ]]
apt-get -y install ttf-mscorefonts-installer

#[[spécifique a XFCE ]] # a modifier si vous n'utilisez pas Xfce !
apt-get -y install xubuntu-restricted-extras xubuntu-restricted-addons xfce4-goodies xfwm4-themes
# si Lubuntu (LXDE), remplacer cette ligne par :
#apt-get -y install lubuntu-restricted-extras lubuntu-restricted-addons

#[[bureautique]]
apt-get -y install libreoffice libreoffice-l10n-fr libreoffice-help-fr freeplane scribus

#[[web]]
apt-get -y install firefox chromium-browser flashplugin-downloader pepperflashplugin-nonfree

#[[multimedia]]
apt-get -y install gimp pinta imagination openshot audacity inkscape gthumb vlc x264 ffmpeg2theora flac vorbis-tools lame mypaint libdvdread4

#[[systeme]]
apt-get -y install gparted vim pyrenamer unrar htop shutter

#[[mathematiques]]
apt-get -y install geogebra algobox carmetal

#[[sciences]]
apt-get -y install stellarium celestia avogadro

#[[programmation]]
apt-get -y install scratch idle-python2.7

#-----------------------------------------
# Customisation graphique Xubuntu (a modifier si vous n'utilisez pas XFCE !)
#-----------------------------------------

add-apt-repository -y ppa:docky-core/stable
apt-get update && apt-get -y install plank
wget http://nux87.online.fr/xubuntu-custom2/skel.tar.gz
tar xzvf skel.tar.gz -C /etc && rm -rf skel.tar.gz

#-----------------------------------------
# Fin
#-----------------------------------------

echo "L'installation est terminé, voulez vous rebooter ?"
read -p "Voulez-vous redémarrer immédiatement ? [O/n] " rep_reboot
if [ "$rep_reboot" = "O" ] || [ "$rep_reboot" = "o" ] || [ "$rep_reboot" = "" ] ; then
  reboot
fi
