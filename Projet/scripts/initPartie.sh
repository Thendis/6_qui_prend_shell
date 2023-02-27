#!/bin/bash
#Créer le dossier et les fichiers de partie#

#pid_nbAleatoire(0-32767)_nbDePartiesActuellement
cd $PWD
nomPartie="P_$1_$2_$3_$4_$5_$6_$RANDOM"
#Créer le dossier de partie
mkdir LesParties/$nomPartie
cd LesParties/$nomPartie
#Créer les fichiers de données au noms des joueurs
echo > historique
for i in $1 $2 $3 $4 $5 $6
do
	echo joueur \: [$i] > $i
done
../../scripts/initCarte.sh $7 $8 #Paquet de carte
echo  $nomPartie #Est capturé par leJeu.sh pour créer le chemin
