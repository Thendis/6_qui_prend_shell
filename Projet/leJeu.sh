#!/bin/bash

#Initialisation
nbJoueur=$1
nbCarteMin=$2
nbCarteMax=$3
j1=bot1
j2=bot2 
j3=bot3
j4=bot4
j5=bot5
j6=bot6
#

#Recupère noms joueurs
count=0
for i in j1 j2 j3 j4 j5 j6
do
	if [ $count -eq $nbJoueur ]
	then
		break
	fi
	echo Pseudo de $i \:
	read $i
	count=$(($count+1))
done
#Créer le dossier de partie
cheminVersPartie=LesParties/$(scripts/initPartie.sh J_$j1 J_$j2 J_$j3 J_$j4 J_$j5 J_$j6 $nbCarteMin $nbCarteMax)
cd $cheminVersPartie
#Lance la partie
../../scripts/gestionPartie.sh J_$j1 J_$j2 J_$j3 J_$j4 J_$j5 J_$j6 $nbCarteMin $nbCarteMax











