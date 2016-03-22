#!/bin/bash

# Concerne toutes les variantes








# Concerne uniquement Ubuntu / Unity

#si variante = ubu alors :








# Concerne uniquement Xubuntu / XFCE

#si variante = xub alors :


# Customisation XFCE

add-apt-repository -y ppa:docky-core/stable ; apt-get update ; apt-get -y install plank
wget http://lien/skel.tar.gz ; tar xzvf skel.tar.gz -C /etc ; rm -rf skel.tar.gz
