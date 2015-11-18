#!/bin/bash

# cron d'extinction automatique a lancer ?

echo "Pour terminer, voulez vous activer l'extinction automatique des postes le soir dans le cas ou des pc auraient oubliés d'être éteints par les élèves ?"
echo "0 ou aucune valeure saisie = non, pas d'extinction auto le soir"
echo "1 = oui, extinction a 19H00"
echo "2 = oui, extinction a 20H00"
echo "3 = oui, extinction a 21H00"
echo "4 = oui, extinction a 23H00"
read -p "Répondre par le chiffre correspondant (0,1,2,3,4) : " rep_proghalt

if [ "$rep_proghalt" = "1" ] ; then
        echo "val1" 
        else if [ "$rep_proghalt" = "2" ] ; then
                echo "val2"
                else if [ "$rep_proghalt" = "3" ] ; then
                        echo "val3"
                        else if [ "$rep_proghalt" = "4" ] ; then
                                echo "val4"
                             fi
                      fi
             fi
fi

exit
