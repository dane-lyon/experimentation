# NE PAS UTILISER CE SCRIPT, IL N'EST PAS TERMINE, IL NE FONCTIONNE DONC PAS TANT QUE VOUS VOYEZ CE MESSAGE !!!!

# Dépot & Mise a jour
wget {{lien a mettre ici sources.list}}
mv -f sources.list /etc/apt/
apt-get update 
apt-get -y install pkg-mozilla-archive-keyring deb-multimedia-keyring
apt-get update
apt-get -y dist-upgrade

# Activation du multiarch 32b 
dpkg --add-architecture i386
apt-get update

# Backportage de Iceweasel alias Firefox 
apt-get -t jessie-backports install iceweasel iceweasel-l10n-fr

# Backportage de LibreOffice
apt-get -t jessie-backports install libreoffice libreoffice-gtk libreoffice-l10n-fr libreoffice-help-fr

[[ APPLI ]]



