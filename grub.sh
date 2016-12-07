#!/bin/bash

wget --no-check-certificate https://raw.githubusercontent.com/dane-lyon/fichier-de-config/master/grub_custom.jpg
mv -f grub_custom.jpg /usr/share/themes/

echo 'GRUB_DEFAULT=0
GRUB_TIMEOUT=0
GRUB_HIDDEN_TIMEOUT=3
GRUB_HIDDEN_TIMOUT_QUIET=false
GRUB_DISABLE_RECOVERY=true
GRUB_GFXMODE=640x480
GRUB_BACKGROUND="/usr/share/themes/grub_custom.jpg"' > /etc/default/grub
update-grub

