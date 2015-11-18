#!/bin/bash

# cron d'extinction automatique a lancer ?

echo "Pour terminer, voulez vous activer l'extinction automatique des postes le soir ?"
echo "0 ou aucune valeure saisie = non, pas d'extinction auto le soir"
echo "1 = oui, extinction a 19H00"
echo "2 = oui, extinction a 20H00"
echo "3 = oui, extinction a 22H00"
read -p "Répondre par le chiffre correspondant (0,1,2,3) : " rep_proghalt

if [ "$rep_proghalt" = "1" ] ; then
        echo "0 19 * * * root /sbin/shutdown -h now" > /etc/cron.d/prog_extinction
        else if [ "$rep_proghalt" = "2" ] ; then
                echo "0 20 * * * root /sbin/shutdown -h now" > /etc/cron.d/prog_extinction
                else if [ "$rep_proghalt" = "3" ] ; then
                        echo "0 22 * * * root /sbin/shutdown -h now" > /etc/cron.d/prog_extinction
                     fi
             fi
fi

exit
