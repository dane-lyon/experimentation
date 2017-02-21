#!/bin/bash
#v0.1

# Le but de ce script est de faire l'inverse du script d'intégration au domaine c'est a dire :
# Retirer du domaine un Ubuntu (ou variante) qui a été précédemment intégré avec le script d'intégration.

apt-get purge -y ldap-auth-client libpam-mount cifs-utils nscd numlockx unattended-upgrades
rm -f /etc/ldap.conf
rm -f /usr/share/pam-configs/my_groups
rm -f /etc/auth-client-config/profile.d/open_ldap
rm -f /usr/share/pam-configs/mkhomedir
rm -f /etc/lightdm/logonscript.sh
rm -f /etc/lightdm/logoffscript.sh
rm -f /usr/share/lightdm/lightdm.conf.d/50-no-guest.conf


########################################################################
#ne pas creer les dossiers par defaut dans home
########################################################################
sed -i "s/enabled=False/enabled=True/g" /etc/xdg/user-dirs.conf
