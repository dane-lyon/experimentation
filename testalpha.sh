#!/bin/bash
## ne surtout pas utiliser ce script !

#constance
export ROOT=~/jessie_in &&
export LOG=~/log &&
export DATA=$ROOT/data &&

# Avez-vous un proxy sur votre reseau ?

export proxy='yes' &&
##export proxy='no' &&

# Informations concernant l'architecture reseau de l'EPLE : a modifier (si besoin) avant de lancer les scripts 

# Paramètre IP #
	export ip_scribe='10.149.46.65' 
	export ip_proxy='' 
	export port_proxy='3128' 

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


#fonctions

# permet :
# (1) de sauver les fichiers/repertoires initiaux en les renommant en *.old si ils existent  
# (2) de copier les fichiers/repertoires bien parametres

move()
{
local REP=$1 &&
local name=$2 &&
if [ -f $REP/$name ]||[ -d $REP/$name ] ; then 
	mv $REP/$name $REP/$name.old &&
	cp -rf $DATA/$name $REP/
else
	cp -rf $DATA/$name $REP/
fi 
}

startinstall()
{
local module=$1 && 
local log_err=$2 &&
local log_out=$3 &&
local module_time=$4 &&
# La sortie des erreurs est redirigee vers un fichier *.err.
# La sortie standard est dupliquee et recopiee vers un fichier *.out
# La sortie de la sequence de commandes entre parentheses est redirigee vers un fichier *.time. 
(time $module 2> $log_err | tee $log_out) 2> $module_time 
}





	
ntpdate $ip_scribe 


