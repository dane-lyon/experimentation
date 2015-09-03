#!/bin/bash
## ne surtout pas utiliser ce script !

# prérequis
apt-get update && apt-get -y dist-upgrade
apt-get -y install sudo ntpdate numlockx libnss-ldap libpam-mount cifs-utils

if [ "$proxy" == 'yes' ] 
	then
	   #mettre contenu 01-integrdom.sh
	   #mettre contenu 02-proxy.sh
	else
	   #mettre 01-integrdom.sh
fi
	
ntpdate $ip_scribe 
