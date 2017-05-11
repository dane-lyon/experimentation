#!/bin/bash

# Demande le code RNE
# Afficher "Quel est le code RNE de votre établissement ?"
#récupérer valeure => rne_college

# Création du fichier pronote

cd /etc/apache2/sites-available/
echo "RedirectMatch ^/pronote https://[rne_college].index-education.net/pronote/" > pronote.conf

# Création lien symbolique
a2ensite pronote.conf

# Création fichier pronote_apps.ini
echo "[Pronote]
baseurl=/pronote/
scheme=both
addr=[rne_college].index-education.net
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

