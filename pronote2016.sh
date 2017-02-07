#!/bin/bash
# en considérant que le PoL partagé se trouve dans /home/.PlayOnLinux

moi=`whoami`
sudo chown -R $moi:$moi /home/.PlayOnLinux
