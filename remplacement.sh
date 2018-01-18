#! /bin/bash

#Script réalisé par Thibaud galloy et Raphaël Brocq de la DANE de Lyon
#Script sous Licence Créative Commons Attribution - Pas d’Utilisation Commerciale - Partage dans les Mêmes Conditions 4.0 International

####début de la déclaration des variables####



titre='\e[0;31m \e[4m'
important='\e[0;31m'
calme='\e[1;32m'

neutre='\e[0;m'
####fin de la déclaration des variables####

####début de la déclaration des fonctions####
##Conserver, ou non la liste des fichiers
Head()
{
	clear
	echo -e ""
	echo -e "				$titre|Script de remplacement V1.0|$neutre"
	echo -e ""
}


ConservationListe()
{
	Head
	read -n1 -p "Garder la liste des fichiers à remplacer ? [o,n] " rep
	case $rep in
		o|O|oui|Oui) clear && Head && echo -e "\nFichier conservé" ;;
		n|N|non|Non) rm -f liste_fichiers.txt && clear && Head && echo -e "\nFichier supprimé" ;;
		*) clear && Head && echo -e "\nRéponse inconnu, fichier conservé" ;;
	esac
}

Choix1()
{
	erreur=0
	rm -f liste_fichiers.txt
	rm -f resultat.log
	wget http://zone.spip.org/trac/spip-zone/browser/_core_/securite/ecran_securite.php?format=txt && mv ./ecran_securite.php?format=txt ./ecran_securite.php || let "erreur=$erreur + 1"
	find /home/*/www/config/ecran_securite.php > liste_fichiers.txt || let "erreur=$erreur + 2"

	if [[ $erreur -ne 0 ]]; then
		Head
		case $erreur in
			1|3) echo -e "$important Impossible de récupérer le fichier à jour, avez vous internet ? $neutre" ;;
			2) echo -e "$calme Il n'y a aucun fichier à remplacer $neutre" ;;
		esac
		read -n1
		rm -f ecran_securite.php
		MenuUn
	fi

	date +"%D - %H:%M" > resultat.log
	echo "" > tmp_log.txt
	while read line
	do
		cp /home/drtweb/sites/tmpdir/ecran_securite.php $line 2>/dev/null && echo "okay $line" >> tmp_log.txt || echo "erreur $line" >> tmp_log.txt
	done < liste_fichiers.txt
	sort tmp_log.txt >> resultat.log
	rm -f tmp_log.txt
	ConservationListe
}

ChoixPerso()
{
	erreur=0
	rm -f liste_fichiers.txt
	rm -f resultat.log
	Head
	read -p "Nom du fichier à remplacer : " choixUtil1
	read -p "Nom du fichier à mettre à la place : " choixUtil2
	clear
	Head
  cp ./$choixUtil2 ./test && rm ./test || let "erreur=$erreur + 1"
	find / -name "$choixUtil1" > liste_fichiers.txt

fichier="./liste_fichiers.txt"
	if [[ ! -e $fichier ]]; then
		let "erreur=$erreur + 2"
	fi

	if [[ $erreur -ne 0 ]]; then
		Head
		case $erreur in
			1) echo "Nous n'avons pas trouvé le fichier source, l'avez vous placé à côté du script ?" ;;
			2) echo "Nous n'avons pas trouvé le fichier à remplacer" ;;
			3) echo "Nous n'avons pas trouvé le fichier à remplacer ni le fichier source" ;;
		esac
		read -n1
		MenuUn
	fi


	nbligne=$(wc -l liste_fichiers.txt)
	read -n1 -p "Les fichiers vont être remplacé, continuer ? [o,n]" choixContinuer
	case $choixContinuer in
		o|O)
		date +"%D - %H:%M" > resultat.log
		while read line
		do
			cp $choixUtil2 $line 2>/dev/null && echo "OK $line" >> tmp_log.txt || echo "FAIL $line" >> tmp_log.txt
		done < liste_fichiers.txt
		sort tmp_log.txt >> resultat.log
		rm -f tmp_log.txt
		ConservationListe
		MenuUn ;;

		n|N)
		MenuUn ;;
	esac



}

MenuUn()
{
	Head
	echo -e "			1 - Remplacement de \"ecran_securite.php\""
	echo -e "			2 - Remplacement personnalisé"
	echo -e "			Q - Quitter"
	echo -e ""
	read -n1 -p "Votre choix ? " choixM1

	case $choixM1 in
		1)Choix1 ;;
		2)ChoixPerso ;;
		q|Q)clear && exit ;;
		*)MenuUn ;;
	esac
}
####Fin de la déclaration des fonctions####

if [[ $UID -ne 0 ]]; then
	echo -e "$important Vous devez éxécuter ce script avec les droits root !$neutre"
	exit
fi

while [[ true ]]; do
	MenuUn
done
