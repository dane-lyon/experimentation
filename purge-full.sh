#!/bin/bash

# Voici une purge radicale, elle supprime complètement :

# - tous le contenu présent dans les dossiers ".Config" et/ou "Application Data" et/ou "config_eole" de tous les utilisateurs.
# - une statistique stat_purge.txt dans le perso de l'admin qui affiche la taille du home avant & après la purge

# info avant la purge (date+heure+taille occupé du home)
date >> /home/a/admin/perso/stat_purge.txt
df -h /home >> /home/a/admin/perso/stat_purge.txt

#purge de la mort 
rm -rf /home/*/*/perso/{Application\ Data,config_eole,.Config}/*
find /home -type f -name ".~lock.*" -exec rm -rf {} \;
#find /home/workgroups/commun/logiciels/$google -iregex '^.*\.dat.*$' -exec rm -rf {} \;

# info après la purge (date+heure+taille occupé du home)
date >> /home/a/admin/perso/stat_purge.txt
df -h /home >> /home/a/admin/perso/stat_purge.txt
