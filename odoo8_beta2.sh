#! /bin/bash

#### script pour installer Odoo 8 sur scribe 2.4 #######
#### DANE rectorat de lyon ######
#### Simon B, Dominique J, Jean-Philippe.P ####


#### Version 4.0 spécifique a Odoo 8 pour Scribe 2.4 ######
# Script modifié pour la nouvelle version par Simon.B avec l'aide de Karim.A

#### on teste si le paquet est présent inutile d'aller plus loin si c'est la cas
dpkg -s odoo &>/dev/null
if [ $? -eq 0 ] ; then
	echo "odoo est déjà présent"
	exit 0
else


#### on rajoute les outils eole 
#. /usr/lib/eole/ihm.sh


##### on installe Odoo
apt-get -y install postgresql
wget http://nightly.odoo.com/8.0/nightly/deb/odoo_8.0.20150908_all.deb
dpkg -i odoo_8.0.20150908_all.deb
apt-get -fy install

#### ouverture des ports sur le scribe, penser au reconfigure a la fin
# La méthode a changé en Scribe 2.4, il faut utiliser maintenant le fichier dico.xml déployé par Zephir

#### paramétrage de postgres pour le rendre accessible depuis le réseau
### on remplace #listen_addresses = 'localhost' par listen_addresses = '*' dans ####le fichier de conf pour que le serveur écoute

#sed -i.BAK  "s/^\#listen_addresses =.*/listen_addresses = '*'/g" /etc/postgresql/9.1/main/postgresql.conf

### modification du fichier pg_hba.conf
#### attention je passe par un numéro de ligne donc cette opération peut échouer
#sed -i.BAK "85i\host    all        all    0.0.0.0/0    trust" /etc/postgresql/9.1/main/pg_hba.conf

#### on redémarre postgresql et odoo pour que la config remonte

service postgresql restart
service odoo restart

###### on rajoute la base postgresql dans la sauvegarde bacula
###### on crée le fichier avec touch et on écrit dedans

## cette partie ne fonctionne pas sur 2.4 pour l'instant

#echo "Include {
#File = /var/lib/postgresql
#}" /etc/bacula/baculafichiers.d/odoo.conf

#### on rajoute les tests dans le diagnose
#echo "#! /bin/bash
#. /usr/lib/eole/ihm.sh
#. /etc/eole/containers.conf

#if [ \$activer_mysql == 'oui' ]; then
#EchoGras \"*** Odoo\"
#TestPid PostgreSql postgres
#fi
#
#if [ \"\$activer_apache\" != \"non\" ];then
#	. /usr/lib/eole/ihm.sh
#	if [ \$adresse_ip_web = '127.0.0.1' ];then
#	TestHTTPPage Odoo http://\$adresse_ip_eth0:8069
#	else
#	TestService Web \$container_ip_web:80
#	fi
#	echo
#fi
#exit 0 " > /usr/share/eole/diagnose/151-odoo
#chmod +x /usr/share/eole/diagnose/151-odoo

#### message de fin d'installation

echo "L'installation est terminée. Il faut faire un reconfigure et un diagnose pour vérifier que tout est ok. Attention le reconfigure coupera l'accès au réseau temporairement !!!"
echo "un log contenant les dossiers modifiés est disponible sur le perso de l'admin. Ce log s'appelle InstallationOdoo.log"

echo "les fichiers modifiés par cette installation sont:
/usr/share/eole/firewall/00_root_odoo.fw
/etc/postgresql/9.1/main/postgresql.conf
/etc/postgresql/9.1/main/pg_hba.conf
/etc/bacula/baculafichiers.d/odoo.conf
/usr/share/eole/diagnose/module/151-odoo

Les anciens fichiers de configuration ont une extension en .BAK. Vous pouvez toujours utiliser cp pour les remettre en place en cas de problème " > /home/a/admin/perso/InstallationOdoo.log


##### Nouvelle fonction ####

# Ajout d'un cron pour redémarrer chaque jour les services pour Odoo
echo "30 23 * * * root /etc/init.d/postgresql restart" > /etc/cron.d/odoo_restart
echo "35 23 * * * root /etc/init.d/odoo restart" >> /etc/cron.d/odoo_restart

# Déporte les bases d'Odoo dans le home

/etc/init.d/postgresql stop
/etc/init.d/odoo stop

mkdir /home/odoo_base
mv /var/lib/postgresql/9.1/main/base /home/odoo_base
ln -s /home/odoo_base /var/lib/postgresql/9.1/main/base
chown -R postgres:postgres /home/odoo_base
chmod -R u=rwx /home/odoo_base

/etc/init.d/postgresql start
/etc/init.d/odoo start

exit 0
fi
