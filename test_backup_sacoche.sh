#!/bin/bash

# Dane de Lyon
# Ce script est a placer dans le dossier /root/drt, ne pas oublier les droits d'execution (+x) !
# exemple de cron pour lancer tous les jours a 6H du matin (/etc/cron.d/backup_opener) : 
# 0 4 * * * root /root/drt/backup_sacoche.sh

. ParseDico

#mkdir /home/backup && mkdir /home/backup/base_sacoche
cd /home/backup/base_sacoche

# Lancement avec le compte postgres
# remplacer {mdp_BDD} par le mdp de la base "sacoche"
mysql -h localhost -u sacoche -p{mdp_BDD} sacoche > backup_sacoche.sql

# Compression du fichier de sauvegarde avec la date du jour
tar czvf backup_sacoche-`date +%Y-%m-%d`.tar.gz backup_sacoche.sql
rm -f backup_sacoche.sql

# Placement du backup au bon endroit
mv -f *.tar.gz /home/backup/base_sacoche/

# Purge des anciens backups OpenERP qui ont plus de 30 jours
find /home/backup/base_sacoche/backup_sacoche-* -type f -mtime +30 -exec rm -rf {} \;


### Info pour restaurer :
# tar xzvf archive.tar.gz
# mysql -h localhost -u sacoche -p{mdp_BDD} sacoche < backup_sacoche.sql

# + pour inclure dossier dans bacula, rajouter dans la liste d'inclusion ici : /etc/bacula/listefichiersperso.conf

exit
