#!/bin/bash
# en considérant que le PoL partagé se trouve dans /home/.PlayOnLinux (a adapter suivant situation)

moi=`whoami`
sudo chown -R $moi:$moi /home/.PlayOnLinux
/usr/share/playonlinux/playonlinux --run "Pronote 2016" %F
