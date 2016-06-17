#!/bin/bash




#read -p "Veuillez indiquer l'ip du proxy :" ip_proxy
#read -p "Veuillez indiquer le port du proxy :" port_proxy

#export https_proxy=$ip_proxy:$port_proxy
wget https://github.com/dane-lyon/experimentation/blob/master/dane-util-1.0.51.deb
wget https://github.com/dane-lyon/experimentation/blob/master/dane-util.desktop
dpkg -i dane-util.deb
apt-get -f install
mv dane-util.desktop /usr/share/applications/


