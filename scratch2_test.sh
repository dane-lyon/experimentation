#!/bin/bash

#Script written by Sébastien LOZANO sat, 13 feb 2016

#Installation of Air and Scratch2 under Ubuntu, Mint,...


#définition des couleurs d'affichage

neutre='\e[0;m'

vertclair='\e[1;32m'


#Fonction qui affiche [OK] en vert clair

function okzed

{

echo -e "${vertclair}[OK]${neutre}"

}

#Run under sudo privilege

if [ $EUID -ne 0 ]; then

   echo "AdobeAir installation script must be run as root."

   echo "Press enter and run this script as root.  (Hint: use sudo)" 1>&2

   read

   exit 1

fi

echo "

This script is only for Ubuntu `printf "\e[32m14.04 Trusty"``echo -e "\033[0m"`/`printf "\e[32m14.10 Utopic"``echo -e "\033[0m"`/`printf "\e[32m12.04 Precise"`\n

`echo -e "\033[0m"` and Linux Mint `printf "\e[32m17 Qiana"``echo -e "\033[0m"`/`printf "\e[32m13 Maya"``echo -e "\033[0m"`/`printf "\e[32m17.3 Rosa"``echo -e "\033[0m"`

"

CHKVer=`/usr/bin/lsb_release -rs`

echo $CHKVer

TVer=`/usr/bin/lsb_release -rs`

echo $TVer

echo "Checking your OS version..."

CHKArch=`uname -m`

echo $CHKArch

echo "Checking your system architecture"

sleep1

echo ""

#Adobe AIR Installation

if [ $CHKVer = "14.04" ] || [ $CHKVer = "17" ]; then

	#For Ubuntu 14.04 64bit

	if [ $CHKArch = "x86_64" ]; then

		if [ $TVer = "14.04" ]; then

		echo "You are running Ubuntu `printf "\e[32m14.04 Trusty"``echo -e "\033[0m"`"

		elif [ $TVer = "17" ]; then

		echo "You are running Linux Mint `printf "\e[32m17 Qiana"``echo -e "\033[0m"`"

		fi

		echo "Installing dependencies..."

		sleep 1

		apt-get install libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 lib32nss-mdns libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libgnome-keyring0:i386 libxaw7

		echo "Linking files..."

		echo "."

		ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0

		echo ".."
		
				ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

	#Ubuntu 14.04 32bit

	elif [ $CHKArch = "i686" ]; then

		if [ $TVer = "14.04" ]; then

		echo "You are running Ubuntu `printf "\e[32m14.04 Trusty"``echo -e "\033[0m"`"

		elif [ $TVer = "17" ]; then

		echo "You are running Linux Mint `printf "\e[32m17 Qiana"``echo -e "\033[0m"`"

		fi

		echo "Installing dependencies..."

		sleep 1

		apt-get install libgtk2.0-0 libxslt1.1 libxml2 libnss3 libxaw7 libgnome-keyring0

		echo "Linking files..."

		echo "."

		ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0

		echo ".."

		ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

	fi


elif [ $CHKVer = "14.10" ]; then

	#For Ubuntu 14.10 64bit

	if [ $CHKArch = "x86_64" ]; then

		echo "You are running Ubuntu `printf "\e[32m14.10 Utopic"``echo -e "\033[0m"`"

		echo "Installing dependencies..."

		sleep 1
		
		apt-get install libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 lib32nss-mdns libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libgnome-keyring0:i386 libxaw7

		echo "Linking files..."

		echo "."

		ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0

		echo ".."

		ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

	#Ubuntu 14.10 32bit

	elif [ $CHKArch = "i686" ]; then

		echo "You are running Ubuntu `printf "\e[32m14.10 Utopic"``echo -e "\033[0m"`"

		echo "Installing dependencies..."

		sleep 1

		apt-get install libgtk2.0-0 libxslt1.1 libxml2 libnss3 libxaw7 libgnome-keyring0

		echo "Linking files..."

		echo "."

		ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0

		echo ".."

		ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

	fi


elif [ $CHKVer = "12.04" ] || [ $CHKVer = "13" ]; then

	#Ubuntu 12.04 32bit

	if [ $CHKArch = "i686" ]; then

		if [ $TVer = "12.04" ]; then

		echo "You are running Ubuntu `printf "\e[32m12.04 Precise"``echo -e "\033[0m"`"

		elif [ $TVer = "13" ]; then

		echo "You are running Linux Mint `printf "\e[32m13 Maya"``echo -e "\033[0m"`"

		fi

		echo "Installing dependencies..."

		sleep 1

		apt-get install libhal-storage1 libgnome-keyring0 libgnome-keyring0 libgtk2.0-0 libxslt1.1 libxml2

		echo "Linking files..."

		echo "."

		ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0

		echo ".."

		ln -sf /usr/lib/i386-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

	#Ubuntu 12.04 64bit

	elif [ $CHKArch = "x86_64" ]; then

		if [ $TVer = "12.04" ]; then

		echo "You are running Ubuntu `printf "\e[32m12.04 Precise"``echo -e "\033[0m"`"

		elif [ $TVer = "13" ]; then
		
				echo "You are running Linux Mint `printf "\e[32m13 Maya"``echo -e "\033[0m"`"

		fi

		echo "Installing dependencies..."

		sleep 1

		apt-get install ia32-libs lib32nss-mdns libhal-storage1 libgnome-keyring0 libgnome-keyring0 libgtk2.0-0 libxslt1.1 libxml2

		echo "Symbolic linking files..."

		echo "."

		ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0

		echo ".."

		ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

	fi

	elif [ $CHKVer = "17.3" ]; then

		#For Linux Mint 17.3 64bit

		if [ $CHKArch = "x86_64" ]; then

		echo "You are running Linux Mint `printf "\e[32m17.3 Rosa"``echo -e "\033[0m"`"

	fi

else

echo "You are not running Ubuntu `printf "\e[32m14.04 Trusty"``echo -e "\033[0m"`/`printf "\e[32m14.10 Utopic"``echo -e "\033[0m"`/`printf "\e[32m12.04 Precise"`\n

`echo -e "\033[0m"` and Linux Mint `printf "\e[32m17 Qiana"``echo -e "\033[0m"`/`printf "\e[32m13 Maya"``echo -e "\033[0m"`/`printf "\e[32m17.3 Rosa"``echo -e "\033[0m"`"

sleep 1

echo "Exiting..."

exit 1

fi

mkdir $HOME/Bureau/installScratch2

echo "Downloading AdobeAir Installer from Adobe site"

sleep 1

wget -P $HOME/Bureau/installScratch2 http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin

echo -n "AdobeAir Download ... "

okzed

echo -n "Making installer executable ... "

okzed

sleep 1

chmod +x $HOME/Bureau/installScratch2/AdobeAIRInstaller.bin

if [ $CHKVer = "17.3" ]; then

	#For Linux Mint 17.3 64bit

        if [ $CHKArch = "x86_64" ]; then

		echo "You are running Linux Mint `printf "\e[32m17.3 Rosa"``echo -e "\033[0m"`"

		dirlib=$(readlink -f $(dirname $(locate libgnome-keyring.so.0.2.0)))

		echo "Running Adobe Air installer be patient ... "

		LD_LIBRARY_PATH=$dirlib $HOME/Bureau/installScratch2/AdobeAIRInstaller.bin

		echo -n "Adobe Air Installation ... "

		okzed

	fi

else

	echo "Running Adobe Air installer be patient ... "

	$HOME/Bureau/installScratch2/AdobeAIRInstaller.bin

	echo -n "Adobe Air Installation ... "

	okzed

	echo -n "Removing installer file and unlinking symbolic files ..."

	rm $HOME/Bureau/installScratch2/AdobeAIRInstaller.bin

	rm /usr/lib/libgnome-keyring.so.0

	rm /usr/lib/libgnome-keyring.so.0.2.0

	okzed

fi

echo ""

#Scratch2 Installation

echo "Downloading Scratch2 ver.443 from Adobe site"

sleep 1

wget -P $HOME/Bureau/installScratch2 https://scratch.mit.edu/scratchr2/static/sa/Scratch-443.air

echo -n "Scratch2 ver.443 Download... "

okzed

echo "Running Scratch2 installer be patient ... "

/opt/Adobe\ AIR/Versions/1.0/Adobe\ AIR\ Application\ Installer $HOME/Bureau/installScratch2/Scratch-443.air

echo -n "Scratch2 ver.443 Installation ... "

okzed

read -p "Removing installer files?(o/n) : " rep

if [ $rep = "o" ]

then

    echo "Removing ... BANZAÏ !"

    sudo rm -r $HOME/Bureau/installScratch2

    echo -n "Removing ... "

    okzed

else

    echo "Keeping files -- no cleaning ! "

fi

echo "Press Enter to quit!"

read
