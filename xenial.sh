#!/bin/bash
# NE PAS UTILISER CE SCRIPT TANT QUE VOUS VOYEZ CETTE PHRASE ECRITE !

###################################################################################################
#--- Nouveau script d'intégration d'Ubuntu & Variante 16.04 LTS avec un Scribe 2.3, 2.4 ou 2.5 ---#
###################################################################################################

#### Nouveautés depuis la 16.04 (Simon) ####
# - valeur de vérification 12.04 remplacé par 16.04
# - paquet a installer smbfs remplacé par cifs-utils car il a changé de nom (depuis la 14.04)
# - ajout groupe dialout
# - ajout fonction pour programmer l'extinction automatique des postes le soir
# - ajout du paquet ntpdate qui n'est pas forcément présent suivant la variante
# - section spécifique a Unity qui ne se lance pas avec les autres variantes
# - section spécifique a MDM et GDM pour certaine variante
# - ajout du choix de la variante utilisé basé sur la 16.04 
# - jeux intégrés par défaut supprimés
# - possibilité de backportage de LibreOffice si l'utilisateur le souhaite 
# - couleur dans le shell sur les messages d'avertissement dans le script

#Christophe Deze - Rectorat de Nantes
#Cédric Frayssinet - Mission Tice Ac-lyon
#Xavier GAREL - Mission Tice Ac-lyon
#Simon BERNARD - Dane Lyon

# version 3.0.1 alpha (avec proxy system)

# Ce script est compatible avec un Scribe 2.3, 2.4 et 2.5 par contre si vous avez un scribe 2.4/2.5, afin d'avoir
# tous les partages (communs, matière etc...) il faut faire cette petite manip sur votre scribe :
# https://dane.ac-lyon.fr/spip/Client-Linux-activer-les-partages?ticket=

## declaration couleur ##
rouge='\e[0;31m'
rose='\e[1;31m'
violet='\e[0;35m'
vert='\e[0;32m'
orange='\e[0;33m'
gris='\e[1;30m'
cyan='\e[0;36m'
bleu='\e[0;34m'
jaune='\e[1;33m'
neutre='\e[0;m'

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
  echo -e "${rouge} Il faut etre root pour executer ce script => sudo ./script.sh${neutre}"
  exit 
fi 

########################################################################
#vérification de la bonne version
########################################################################
. /etc/lsb-release
if [ "$DISTRIB_RELEASE" != "16.04" ] && [ "$DISTRIB_RELEASE" != "18" ]
then
  echo -e "${rouge}Vous n'êtes pas sous une version compatible avec ce script, il faut utiliser la 16.04 !${neutre}"
  exit
fi

########################################################################
# Quelle variante d'Ubuntu est utilisé ?
########################################################################
echo "Quelle variante d'Ubuntu voulez vous intégrer au domaine ? : "
echo -e "${rouge}ATTENTION : pour certaine variante (notamment Mint et Ubuntu Mate), il est impératif que la case 'client linux' soit coché dans l'EAD du Scribe pour les utilisateurs pour que ça fonctionne${neutre}"
echo -e "${vert}==================================================${neutre}"
echo "1 = Ubuntu 16.04 Xenial Xerus (UI : Unity 7/8)"
echo "2 = Xubuntu 16.04 Xenial Xerus (UI : Xfce 4.12)"
echo "3 = Lubuntu 16.04 Xenial Xerus (UI : Lxde 0.8)"
echo "4 = Ubuntu Mate 16.04 Xenial Xerus (UI : Mate 1.12)"
echo "5 = Ubuntu Gnome 16.04 Xenial Xerus (UI : Gnome 3.18)"
echo "(prochainement ici : Linux Mint 18 Sarah)"
echo -e "${vert}==================================================${neutre}"
read -p "Répondre par le chiffre correspondant (1,2,3,4,5) : " distrib

while [ "$distrib" != "1" ] && [ "$distrib" != "2" ] && [ "$distrib" != "3" ] && [ "$distrib" != "4" ] && [ "$distrib" != "5" ]
do
  echo -e "${rouge}Désolé vous avez saisi un mauvais choix, veuillez recommencer !${neutre}"
  read -p "Répondre par le chiffre correspondant (1,2,3,4,5) : " distrib
done


##############################################################################
### Questionnaire : IP du scribe, proxy firefox, port proxy, exception proxy #
##############################################################################
echo -e "${orange}RAPPEL : si votre serveur Scribe est en version 2.4 ou 2.5, il y a une manip supplémentaire a faire de votre part pour avoir tous les partages, cf : https://dane.ac-lyon.fr/spip/Client-Linux-activer-les-partages${neutre}"
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

###################################################
# cron d'extinction automatique a lancer ?
###################################################

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

###################################################
# Backportage de LibreOffice ?
###################################################
echo "Souhaitez vous activer le backportage (PPA LO Stable) de LibreOffice ? :"
  echo -e "${violet}Si vous ne comprenez pas la question ou si c'est non, laissez le choix par défaut a savoir 'non'${neutre}"
  read -p "NON (choix par défaut, vous serez alors toujours avec la version 5.1.x) => valider sans rien mettre ou n'importe quelle valeure autre que oui."
  read -p "OUI (5.1 => 5.2 => 5.3 etc...) => saisir exactement en minuscule : oui" backport_lo

######## Mises a jour du système ########
apt-get update && apt-get -y dist-upgrade

## variante ##

if [ "$distrib" = "1" ] ; then  # ubuntu
  apt-get -y install ubuntu-restricted-extras
  apt-get -y purge aisleriot gnome-mines gnome-sudoku gnome-mahjongg
fi

if [ "$distrib" = "2" ] ; then  # xubuntu 
  apt-get -y install libreoffice libreoffice-gtk libreoffice-l10n-fr xubuntu-restricted-extras
  apt-get -y purge pidgin transmission-gtk gnome-mines gnome-sudoku blueman
fi

if [ "$distrib" = "3" ] ; then  # lubuntu  
  apt-get -y install libreoffice libreoffice-gtk libreoffice-l10n-fr lubuntu-restricted-extras
  apt-get -y purge abiword gnumeric pidgin transmission-gtk
fi

if [ "$distrib" = "4" ] ; then  # ubuntu mate  #shell linux activé obligatoire !
  apt-get -y install ubuntu-restricted-extras
  apt-get -y purge hexchat transmission-gtk ubuntu-mate-welcome 
fi

if [ "$distrib" = "5" ] ; then  # ubuntu gnome  
  apt-get -y install ubuntu-restricted-extras
# TO DO : désactiver userlist de GDM
fi

#if [ "$distrib" = "x" ] ; then   # plus tard
#  apt-get -y purge mintwelcome
#  changer le thème MDM pour ne pas avoir "l'userlist" par défaut
#fi


########################################################################
# Backportage de LibreOffice (si oui)
########################################################################
if [ "$backport_lo" = "oui" ] ; then
  add-apt-repository -y ppa:libreoffice/ppa
  apt-get update && apt-get -y upgrade
fi

########################################################################
#rendre debconf silencieux
########################################################################
export DEBIAN_FRONTEND="noninteractive"
export DEBIAN_PRIORITY="critical"

########################################################################
#Mettre la station à l'heure à partir du serveur Scribe
########################################################################
apt-get -y install ntpdate
ntpdate $ip_scribe

########################################################################
#installation des paquets necessaires
#numlockx pour le verrouillage du pave numerique
#unattended-upgrades pour forcer les mises à jour de sécurité à se faire
########################################################################
apt-get install -y ldap-auth-client libpam-mount cifs-utils nscd numlockx unattended-upgrades

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

########################################################################
#parametrage du script de demontage du netlogon pour lightdm
########################################################################
touch /etc/lightdm/logonscript.sh
grep "if mount | grep -q \"/tmp/netlogon\" ; then umount /tmp/netlogon ;fi" /etc/lightdm/logonscript.sh  >/dev/null
if [ $? == 0 ]
then
  echo "Presession Ok"
else
  echo "if mount | grep -q \"/tmp/netlogon\" ; then umount /tmp/netlogon ;fi" >> /etc/lightdm/logonscript.sh
fi
chmod +x /etc/lightdm/logonscript.sh

touch /etc/lightdm/logoffscript.sh
echo "sleep 2 \
umount -f /tmp/netlogon \ 
umount -f \$HOME
" > /etc/lightdm/logoffscript.sh
chmod +x /etc/lightdm/logoffscript.sh

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
#parametrage du lightdm.conf (sauf pour Mint car n'utilise pas LigthDM)
#activation du pave numerique par greeter-setup-script=/usr/bin/numlockx on
########################################################################

#manip effectué pour toutes les variantes sauf Ubuntu Gnome (5) et Mint (X) car ils utilisent GDM ou MDM a la place de LightDM
if [ "$distrib" != "5" ] && [ "$distrib" != "X" ] ; then 

echo "[SeatDefaults]
    allow-guest=false
    greeter-show-manual-login=true
    greeter-hide-users=true
    session-setup-script=/etc/lightdm/logonscript.sh
    session-cleanup-script=/etc/lightdm/logoffscript.sh
    greeter-setup-script=/usr/bin/numlockx on" > /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf
fi


# == Unity == #
if [ "$distrib" = "1" ] ; then  # Uniquement pour Ubuntu/Unity

########################################################################
#supression de l'applet switch-user pour ne pas voir les derniers connectés
#paramétrage d'un laucher unity par défaut : nautilus, firefox, libreoffice, calculatrice, editeur de texte et capture d'ecran
########################################################################
echo "[com.canonical.indicator.session]
user-show-menu=false
[org.gnome.desktop.lockdown]
disable-user-switching=true
disable-lock-screen=true
[com.canonical.Unity.Launcher]
favorites=[ 'nautilus-home.desktop', 'firefox.desktop','libreoffice-startcenter.desktop', 'gcalctool.desktop','gedit.desktop','gnome-screenshot.desktop' ]
" > /usr/share/glib-2.0/schemas/my-defaults.gschema.override

fi
# == Fin Section dédié a Unity == #

#######################################################
#Paramétrage des paramètres Proxy pour tout le système
#######################################################
if  [ "$ip_proxy" != "" ] || [ "$port_proxy" != "" ] ; then

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

########################################################################
#suppression de l'envoi des rapport d'erreurs
########################################################################
echo "enabled=0" > /etc/default/apport

########################################################################
#suppression de l'applet network-manager
########################################################################
mv /etc/xdg/autostart/nm-applet.desktop /etc/xdg/autostart/nm-applet.old

########################################################################
#suppression du menu messages
########################################################################
apt-get -y remove indicator-messages 

########################################################################
#nettoyage station avant clonage
########################################################################
apt-get -y autoremove --purge
apt-get -y clean

########################################################################
#FIN
########################################################################
echo "C'est fini ! Un reboot est nécessaire..."
read -p "Voulez-vous redémarrer immédiatement ? [O/n] " rep_reboot
if [ "$rep_reboot" = "O" ] || [ "$rep_reboot" = "o" ] || [ "$rep_reboot" = "" ] ; then
  reboot
fi
