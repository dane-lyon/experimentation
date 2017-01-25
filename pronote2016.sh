#!/bin/bash

# Ce mini-script a pour but de pouvoir lancer Pronote depuis n'importe quel utilisateur (installation PoL partagé)

# Pré-requis :
# Avoir déplacé le dossier ~/.PlayOnLinux sur /home/.PlayOnLinux
# Avoir crée un lien symbolique dans le home de l'utilisateur pointant sur /home/.PlayOnLinux (automatisation avec le skel par ex)

utilisateur='whoami'
sudo chown -R $utilisateur:$utilisateur /home/.PlayOnLinux
/usr/share/playonlinux/playonlinux --run "Pronote 2016" %F
