# /bin/bash

########ce script permet de modifier dans tous les groupes machines, de remplacer la page d'accueil google.fr par la page lite.qwant.com
########  © Virginie Favrat & Jean philippe Patrizio DANE
 
sed -i 's/\(<Variable nom="browser.startup.homepage.*>\)\(.*\)\(<\/Variable>\)/\1 https:\/\/lite.qwant.com \3/' /home/esu/Base/*/*xml
sed -i 's/\(<Variable nom="Start Page.*>\)\(.*\)\(<\/Variable>\)/\1 https:\/\/lite.qwant.com \3/' /home/esu/Base/*/*xml
