#/bin/bash

# désactiver mode intéractif pour automatiser l'installation de wireshark
export DEBIAN_FRONTEND="noninteractive"

add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner" 

apt-get install libdvd-pkg -y
dpkg-reconfigure libdvd-pkg

exit
