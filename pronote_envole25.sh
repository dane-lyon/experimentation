#!/bin/bash

# Récupération du code RNE

read -p "Veuillez indiquer votre code RNE : " coderne

# Création du fichier pronote

cd /etc/apache2/sites-available/
echo "RedirectMatch ^/pronote https://$coderne.index-education.net/pronote/" > pronote.conf

# Création lien symbolique
a2ensite pronote.conf

# Création fichier pronote_apps.ini
echo "[Pronote]
baseurl=/pronote/
scheme=both
addr=$coderne.index-education.net
typeaddr=dns
filter=pronote" > /usr/share/sso/app_filters/pronote_apps.ini

# Création fichier pronote.ini
echo "[utilisateur]
nom=sn
prenom=givenName
login=ENTPersonLogin
categories=ENTPersonProfils
dateNaissance=ENTPersonDateNaissance
codePostal=ENTPersonCodePostal
eleveClasses=ENTEleveClasses
user=uid" > /usr/share/sso/app_filters/pronote.ini

# Relance du service apache
service apache2 reloard

