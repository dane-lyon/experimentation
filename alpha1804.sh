#!/bin/bash
# version 0.0.1alpha #POUR TEST UNIQUEMENT !

## Roadmap a faire plus tard pour la 18.04LTS :
# [prioritaire]
# - Pour le nouveau gestionnaire de session GDM, désactiver l'userlist. Procédure ici : https://help.gnome.org/admin/system-admin-guide/stable/login-userlist-disable.html.en
# - Bug à résoudre sur "login-service" qui ne se lance pas en VM avec artful (si integrdom avant).
# - Ne pas installer "Unity Tweak Tool" si la 18.04 est détecté et installer a la place "Gnome Tweak Tool"
# - Ne pas lancer la partie du script qui concerne LightDM ou Unity (les 2 n'étant plus présent)
# - Erreur avec install.css/libdvdread pour lire les DVD commerciaux avec artful
# - Supprimer icon Amazon (supprimer le fichier : /usr/share/ubuntu-web-launchers/amazon...)

# [secondaire]
# - Installer par défaut "net-tools" (donne la possibilité de faire ifconfig)
# - Envisager éventuellement d'installer en supplément la session "Vanilla" de Gnome 
# - Envisager de désactiver les effets visuels de Gnome par défaut (pc des établissements généralement peu performant)
# - Envisager de remplacer Totem par VLC ou MPV
# - Sur le script de postinstall : Java8 devra être remplacé par Java9 
# - Sur le script de postinstall : le paquet "openprinting-gutenprint" n'est plus bon (voir version + récente)
# - Sur le script de postinstall : le paquet python (idle-python3.4) n'est plus bon (version + récente)

# --------------------------------------------------------------------------------------------------------------------

## Liste des contributeurs au script :
# Christophe Deze - Rectorat de Nantes
# Cédric Frayssinet - Mission Tice Ac-lyon
# Xavier Garel - Mission Tice Ac-lyon
# Simon Bernard - Technicien Ac-Lyon

# Proxy system
###########################################################################
#Paramétrage par défaut
#Changez les valeurs, ainsi, il suffira de taper 'entrée' à chaque question
###########################################################################
scribe_def_ip="192.168.220.10"
proxy_def_ip="172.16.0.252"
proxy_def_port="3128"
proxy_gnome_noproxy="[ 'localhost', '127.0.0.0/8', '172.16.0.0/16', '192.168.0.0/16', '*.crdp-lyon.fr', '*.crdplyon.lan' ]"
proxy_env_noproxy="localhost,127.0.0.1,192.168.0.0/16,172.16.0.0/16,.crdp-lyon.fr,.crdplyon.lan"
pagedemarragepardefaut="https://lite.qwant.com"

#############################################
# Run using sudo, of course.
#############################################
if [ "$UID" -ne "0" ]
then
  echo "Il faut etre root pour executer ce script. ==> sudo "
  exit 
fi 

# Pour identifier le numéro de la version 
. /etc/lsb-release

########################################################################
#vérif
########################################################################

if [ "$DISTRIB_RELEASE" != "18.04" ]
then
  echo "Vous n'êtes pas sûr une version compatible !"
  exit
fi

##############################################################################
### Questionnaire : IP du scribe, proxy firefox, port proxy, exception proxy #
##############################################################################
read -p "Donnez l'ip du serveur Scribe ? [$scribe_def_ip] " ip_scribe
if [ "$ip_scribe" = "" ] ; then
  ip_scribe=$scribe_def_ip
fi
echo "Adresse du serveur Scribe = $ip_scribe"

#####################################
# Existe-t-il un proxy à paramétrer ?
#####################################

read -p "Faut-il enregistrer l'utilisation d'un proxy ? [O/n] " rep_proxy
if [ "$rep_proxy" = "O" ] || [ "$rep_proxy" = "o" ] || [ "$rep_proxy" = "" ] ; then
  read -p "Donnez l'adresse ip du proxy ? [$proxy_def_ip] " ip_proxy
  if [ "$ip_proxy" = "" ] ; then
    ip_proxy=$proxy_def_ip
  fi
  read -p "Donnez le n° port du proxy ? [$proxy_def_port] " port_proxy
  if [ "$port_proxy" = "" ] ; then
    port_proxy=$proxy_def_port
  fi
else
  ip_proxy=""
  port_proxy=""
fi

########################################################################
#rendre debconf silencieux
########################################################################
export DEBIAN_FRONTEND="noninteractive"
export DEBIAN_PRIORITY="critical"

#######################################################
#Paramétrage des paramètres Proxy pour tout le système
#######################################################
if [[ "$ip_proxy" != "" ]] || [[ $port_proxy != "" ]] ; then

  echo "Paramétrage du proxy $ip_proxy:$port_proxy" 

#Paramétrage des paramètres Proxy pour Gnome
#######################################################
  echo "[org.gnome.system.proxy]
mode='manual'
use-same-proxy=true
ignore-hosts=$proxy_gnome_noproxy
[org.gnome.system.proxy.http]
host='$ip_proxy'
port=$port_proxy
[org.gnome.system.proxy.https]
host='$ip_proxy'
port=$port_proxy
" >> /usr/share/glib-2.0/schemas/my-defaults.gschema.override

  glib-compile-schemas /usr/share/glib-2.0/schemas

#Paramétrage du Proxy pour le systeme
######################################################################
echo "http_proxy=http://$ip_proxy:$port_proxy/
https_proxy=http://$ip_proxy:$port_proxy/
ftp_proxy=http://$ip_proxy:$port_proxy/
no_proxy=\"$proxy_env_noproxy\"" >> /etc/environment

#Paramétrage du Proxy pour apt
######################################################################
echo "Acquire::http::proxy \"http://$ip_proxy:$port_proxy/\";
Acquire::ftp::proxy \"ftp://$ip_proxy:$port_proxy/\";
Acquire::https::proxy \"https://$ip_proxy:$port_proxy/\";" > /etc/apt/apt.conf.d/20proxy

#Permettre d'utiliser la commande add-apt-repository derriere un Proxy
######################################################################
echo "Defaults env_keep = https_proxy" >> /etc/sudoers

fi

# Modification pour ne pas avoir de problème lors du rafraichissement des dépots avec un proxy (désactivé pour l'instant)

# cette ligne peut être commenté/ignoré si vous n'utilisez pas de proxy ou avec la 14.04.
#echo "Acquire::http::No-Cache true;" >> /etc/apt/apt.conf
#echo "Acquire::http::Pipeline-Depth 0;" >> /etc/apt/apt.conf


# Vérification que le système est bien a jour
apt update
apt-get full-upgrade -y

########################################################################
#Mettre la station à l'heure à partir du serveur Scribe
########################################################################
apt install ntpdate net-tools -y
ntpdate $ip_scribe

########################################################################
#installation des paquets necessaires
#numlockx pour le verrouillage du pave numerique
#unattended-upgrades pour forcer les mises à jour de sécurité à se faire
########################################################################
apt install ldap-auth-client libpam-mount cifs-utils nscd numlockx unattended-upgrades -y

########################################################################
# activation auto des mises à jour de sécu
########################################################################
echo "APT::Periodic::Update-Package-Lists \"1\";
APT::Periodic::Unattended-Upgrade \"1\";" > /etc/apt/apt.conf.d/20auto-upgrades

########################################################################
# Configuration du fichier pour le LDAP /etc/ldap.conf
########################################################################
echo "
# /etc/ldap.conf
host $ip_scribe
base o=gouv, c=fr
nss_override_attribute_value shadowMax 9999
" > /etc/ldap.conf

########################################################################
# activation des groupes des users du ldap
########################################################################
echo "Name: activate /etc/security/group.conf
Default: yes
Priority: 900
Auth-Type: Primary
Auth:
        required                        pam_group.so use_first_pass" > /usr/share/pam-configs/my_groups

########################################################################
#auth ldap
########################################################################
echo "[open_ldap]
nss_passwd=passwd:  files ldap
nss_group=group: files ldap
nss_shadow=shadow: files ldap
nss_netgroup=netgroup: nis
" > /etc/auth-client-config/profile.d/open_ldap

########################################################################
#application de la conf nsswitch
########################################################################
auth-client-config -t nss -p open_ldap

########################################################################
#modules PAM mkhomdir pour pam-auth-update
########################################################################
echo "Name: Make Home directory
Default: yes
Priority: 128
Session-Type: Additional
Session:
       optional                        pam_mkhomedir.so silent" > /usr/share/pam-configs/mkhomedir

grep "auth    required     pam_group.so use_first_pass"  /etc/pam.d/common-auth  >/dev/null
if [ $? == 0 ]
then
  echo "/etc/pam.d/common-auth Ok"
else
  echo  "auth    required     pam_group.so use_first_pass" >> /etc/pam.d/common-auth
fi

########################################################################
# mise en place de la conf pam.d
########################################################################
pam-auth-update consolekit ldap libpam-mount unix mkhomedir my_groups --force

########################################################################
# mise en place des groupes pour les users ldap dans /etc/security/group.conf
########################################################################
grep "*;*;*;Al0000-2400;floppy,audio,cdrom,video,plugdev,scanner,dialout" /etc/security/group.conf  >/dev/null; if [ $? != 0 ];then echo "*;*;*;Al0000-2400;floppy,audio,cdrom,video,plugdev,scanner,dialout" >> /etc/security/group.conf; else echo "group.conf ok";fi

########################################################################
#on remet debconf dans sa conf initiale
########################################################################
export DEBIAN_FRONTEND="dialog"
export DEBIAN_PRIORITY="high"

# echo "GVFS_DISABLE_FUSE=1" >> /etc/environment

########################################################################
#Paramétrage pour remplir pam_mount.conf
########################################################################

eclairng="<volume user=\"*\" fstype=\"cifs\" server=\"$ip_scribe\" path=\"eclairng\" mountpoint=\"/media/Serveur_Scribe\" />"
grep "/media/Serveur_Scribe" /etc/security/pam_mount.conf.xml  >/dev/null
if [ $? != 0 ]
then
  sed -i "/<\!-- Volume definitions -->/a\ $eclairng" /etc/security/pam_mount.conf.xml
else
  echo "eclairng deja present"
fi

homes="<volume user=\"*\" fstype=\"cifs\" server=\"$ip_scribe\" path=\"perso\" mountpoint=\"~/Documents\" />"
grep "mountpoint=\"~\"" /etc/security/pam_mount.conf.xml  >/dev/null
if [ $? != 0 ]
then sed -i "/<\!-- Volume definitions -->/a\ $homes" /etc/security/pam_mount.conf.xml
else
  echo "homes deja present"
fi

netlogon="<volume user=\"*\" fstype=\"cifs\" server=\"$ip_scribe\" path=\"netlogon\" mountpoint=\"/tmp/netlogon\"  sgrp=\"DomainUsers\" />"
grep "/tmp/netlogon" /etc/security/pam_mount.conf.xml  >/dev/null
if [ $? != 0 ]
then
  sed -i "/<\!-- Volume definitions -->/a\ $netlogon" /etc/security/pam_mount.conf.xml
else
  echo "netlogon deja present"
fi

grep "<cifsmount>mount -t cifs //%(SERVER)/%(VOLUME) %(MNTPT) -o \"noexec,nosetuids,mapchars,cifsacl,serverino,nobrl,iocharset=utf8,user=%(USER),uid=%(USERUID)%(before=\\",\\" OPTIONS)\"</cifsmount>" /etc/security/pam_mount.conf.xml  >/dev/null
if [ $? != 0 ]
then
  sed -i "/<\!-- pam_mount parameters: Volume-related -->/a\ <cifsmount>mount -t cifs //%(SERVER)/%(VOLUME) %(MNTPT) -o \"noexec,nosetuids,mapchars,cifsacl,serverino,nobrl,iocharset=utf8,user=%(USER),uid=%(USERUID)%(before=\\",\\" OPTIONS)\"</cifsmount>" /etc/security/pam_mount.conf.xml
else
  echo "mount.cifs deja present"
fi

########################################################################
#/etc/profile
########################################################################
echo "
export LC_ALL=fr_FR.utf8
export LANG=fr_FR.utf8
export LANGUAGE=fr_FR.utf8
" >> /etc/profile

########################################################################
#ne pas creer les dossiers par defaut dans home
########################################################################
sed -i "s/enabled=True/enabled=False/g" /etc/xdg/user-dirs.conf

########################################################################
# les profs peuvent sudo
########################################################################
grep "%professeurs ALL=(ALL) ALL" /etc/sudoers > /dev/null
if [ $?!=0 ]
then
  sed -i "/%admin ALL=(ALL) ALL/a\%professeurs ALL=(ALL) ALL" /etc/sudoers
  sed -i "/%admin ALL=(ALL) ALL/a\%DomainAdmins ALL=(ALL) ALL" /etc/sudoers
else
  echo "prof deja dans sudo"
fi


########################################################################
#suppression de l'envoi des rapport d'erreurs
########################################################################
echo "enabled=0" > /etc/default/apport

# Changement page d'accueil firefox
echo "user_pref(\"browser.startup.homepage\", \"$pagedemarragepardefaut\");" >> /usr/lib/firefox/defaults/pref/channel-prefs.js


# Pour le fonctionnement du dossier /etc/skel (Désactivé pour l'instant)
#sed -i "30i\session optional        pam_mkhomedir.so" /etc/pam.d/common-session

# Suppression de notification de mise a niveau (Désactivé pour l'instant)
#sed -r -i 's/Prompt=lts/Prompt=never/g' /etc/update-manager/release-upgrades


########################################################################
# NOUVEAU
########################################################################
# Modif GDM : désactiver la liste des utilisateurs (pour saisir manuellement le login)

echo "user-db:user
system-db:gdm
file-db:/usr/share/gdm/greeter-dconf-defaults" > /etc/dconf/profile/gdm

mkdir /etc/dconf/db/gdm.d
echo "[org/gnome/login-screen]
# Do not show the user list
disable-user-list=true" > /etc/dconf/db/gdm.d/00-login-screen

#prise en compte du changement
dconf update

########################################################################
#nettoyage station avant clonage
########################################################################
apt autoremove --purge -y
apt clean -y

########################################################################
#FIN
########################################################################
echo "C'est fini ! Un reboot est nécessaire..."
read -p "Voulez-vous redémarrer immédiatement ? [O/n] " rep_reboot
if [ "$rep_reboot" = "O" ] || [ "$rep_reboot" = "o" ] || [ "$rep_reboot" = "" ] ; then
  reboot
fi
