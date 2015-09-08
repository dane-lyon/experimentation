#! /bin/bash

#### script pour installer Odoo 8 sur scribe 2.4 #######
#### DANE rectorat de lyon ######
#### Dominique J, Simon B, Jean-Philippe.P ####
#### Version 4 ######

#### on teste si le paquet est présent inutile d'aller plus loin si c'est la cas
#dpkg -s odoo &>/dev/null
#if [ $? -eq 0 ] ; then
#	echo "odoo est déjà présent"
#	exit 0
#else


#### on rajoute les outils eole pour lancer postgresql et Odoo
# désactivé pour scribe 2.4 car message indique que ça ne doit plus être utilisé
#. /usr/share/eole/FonctionsEoleNg


##### on installe Odoo
apt-get -y install postgresql
wget http://nightly.odoo.com/8.0/nightly/deb/odoo_8.0.20150908_all.deb
dpkg -i odoo_8.0.20150908_all.deb
apt-get -fy install

#### ouverture des ports sur le scribe , en fait ce fichier devrRA REDESCENDRE VIA LA VARIANTE ET C'EST INUTILE DE LE CREER SI TU NE RECONFIGURE PAS, LE FICHIER NE SERA PAS TRAITE DONC PAS DE REGLES.
echo "allow_src(interface='eth0', ip='0/0', port='8069')
allow_src(interface='eth0', ip='0/0', port='5432')" > /usr/share/eole/firewall/00_root_odoo.fw
#donc on ajoute les autorisations à la volée
/sbin/iptables -I wide-root -p tcp -m state --state NEW -m tcp --dport 8069 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT
/sbin/iptables -I wide-root -p tcp -m state --state NEW -m tcp --dport 5432 --tcp-flags FIN,SYN,RST,ACK SYN -j ACCEPT


#### paramétrage de postgres pour le rendre accessible depuis le réseau
### on remplace #listen_addresses = 'localhost' par listen_addresses = '*' dans ####le fichier de conf pour que le serveur écoute

sed -i.BAK  "s/^\#listen_addresses =.*/listen_addresses = '*'/g" /etc/postgresql/9.1/main/postgresql.conf
### modification du fichier pg_hba.conf

#### attention je passe par un numéro de ligne donc cette opération peut échouer
sed -i.BAK "85i\host    all        all    0.0.0.0/0    trust" /etc/postgresql/9.1/main/pg_hba.conf

#### on redémarre postgresql et odoo pour que la config remonte

service postgresql restart
service odoo restart

###### on rajoute la base postgresql dans la sauvegarde bacula
###### on crée le fichier avec touch et on écrit dedans

echo "Include {
File = /var/lib/postgresql
}" /etc/bacula/baculafichiers.d/openerp.conf

#### on rajoute les tests dans le diagnose
# bon de toute façon cette partie ça peux pas marcher pour odoo pour le diagnose pour l'instant...
echo "#! /bin/bash
. /usr/share/eole/FonctionsEoleNg
. /etc/eole/containers.conf
. ParseDico
if [ \$activer_mysql == 'oui' ]; then
EchoGras \"*** Odoo\"
TestPid PostgreSql postgres
fi

if [ \"\$activer_apache\" != \"non\" ];then
	. /usr/share/eole/FonctionsEoleNg
	if [ \$adresse_ip_web = '127.0.0.1' ];then
	TestHTTPPage Odoo http://\$adresse_ip_eth0:8069
	else
	TestService Web \$container_ip_web:80
	fi
	echo
fi
exit 0 " > /usr/share/eole/diagnose/module/151-odoo
chmod +x /usr/share/eole/diagnose/module/151-odoo

#### message de fin d'installation

echo "L'installation est terminée. Il faut faire un reconfigure et un diagnose pour vérifier que tout est ok. Attention le reconfigure coupera l'accès au réseau temporairement !!!"
echo "un log contenant les dossiers modifiés est disponible sur le perso de l'admin. Ce log s'appelle InstallationOdoo.log"

echo "les fichiers modifiés par cette installation sont:
/usr/share/eole/firewall/00_root_openerp.fw
/etc/postgresql/8.4/main/postgresql.conf
/etc/postgresql/8.4/main/pg_hba.conf
/etc/bacula/baculafichiers.d/odoo.conf
/usr/share/eole/diagnose/module/151-odoo

Les anciens fichiers de configuration ont une extension en .BAK. Vous pouvez toujours utiliser cp pour les remettre en place en cas de problème " > /home/a/admin/perso/InstallationOdoo.log



##### Nouvelle fonction ####

# Ajout d'un cron pour redémarrer chaque jour les services pour OpenERP 
echo "30 23 * * * root /etc/init.d/postgresql restart" > /etc/cron.d/odoo_restart
echo "35 23 * * * root /etc/init.d/odoo restart" >> /etc/cron.d/odoo_restart

# Déporte les bases d'OpenERP dans le home

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
#fi
