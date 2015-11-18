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
else

# -----------------------------------------------------
# Profil "b" : établissement scolaire - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "b" ] ; then
                echo "profil b"
else     

# -----------------------------------------------------
# Profil "c" : technicien sous linux / DANE - distribution Ubuntu Trusty (14.04) ou variante
# -----------------------------------------------------

if [ "$rep" = "c" ] ; then
                echo "profil c"
else  

# -----------------------------------------------------
# Profil "d" : technicien sous linux / DANE - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "d" ] ; then
                echo "profil d"
else  

# -----------------------------------------------------
# Profil "e" : utilisation personnelle - distribution Ubuntu Trusty (14.04) ou variante
# -----------------------------------------------------

if [ "$rep" = "e" ] ; then
                echo "profil e"
else  

# -----------------------------------------------------
# Profil "f" : utilisation personnelle - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "f" ] ; then
                echo "profil f"
else  

# -----------------------------------------------------
# Profil "g" : utilisation sous Archlinux
# -----------------------------------------------------

if [ "$rep" = "g" ] ; then
                echo "profil g"
else  

# -----------------------------------------------------
# Profil "h" : utilisation familiale - distribution Ubuntu Trusty (14.04) ou variante
# -----------------------------------------------------

if [ "$rep" = "h" ] ; then
                echo "profil h"
else  

# -----------------------------------------------------
# Profil "i" : utilisation familiale - distribution Debian Jessie (8) ou variante
# -----------------------------------------------------

if [ "$rep" = "i" ] ; then
                echo "profil i"
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

# Fin boucle
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
