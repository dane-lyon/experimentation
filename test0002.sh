#!/bin/bash

apt install -y install libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 libnss-mdns:i386 
apt install -y libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libgnome-keyring0:i386 libxaw7
apt install -fy
ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0
ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

wget -O AdobeAIRInstaller.bin http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
chmod +x AdobeAIRInstaller.bin
./AdobeAIRInstaller.bin
rm AdobeAIRInstaller.bin
rm /usr/lib/libgnome-keyring.so.0
rm /usr/lib/libgnome-keyring.so.0.2.0

exit
