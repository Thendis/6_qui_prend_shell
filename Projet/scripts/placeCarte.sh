#!/bin/bash
#Depose une carte sur le plateau de jeu : nomJoueur n°Carte manche tour#
cd $PWD
nomJ=$1
manche=$3
tour=$4
carte=$(cat $nomJ | grep -w "manche$manche"|grep -w "l$2" | tr -d "[a-k][m-z]" )
carte=${carte#???}
	#Determine la ligne ou placer la carte dans historique
maxVal=0
champsMaxVal=0
ligne=0

for i in {1..4}
do
	longeur=$(cat historique | grep -w "manche$manche"|grep -w "tour$tour"|grep -w "ligne$i" | wc -w)
	longeur=$(($longeur-2)) 
		#Valeur de la dernière carte de la ligne
	val=$(cat historique |grep -w "manche$manche"|grep -w "tour$tour"|grep -w "ligne$i" | cut -d " " -f$longeur |tr -d l )
	
	if [ $2 -gt $val ]  && [ $val -gt $maxVal ];then
		maxVal=$val
		champsMaxVal=$(($longeur+2))
		ligne=$i
	fi
done
	#-------
	
	#Place la carte et gère les evennements
if [ $champsMaxVal -eq 18 ] #Si 5 Cartes sur la ligne
then
	ligneHisto=$(cat historique | grep -w "manche$manche"|grep -w "tour$tour"|grep -w "l$maxVal")
	for i in {0..4};do
		numCarte=$(echo $ligneHisto | cut -d " " -f$((4+$i*3)) | tr -d l)
		../../scripts/recupCarte.sh $nomJ $numCarte $manche $tour
	done
	newLine="manche$manche tour$tour ligne$ligne $carte"
	cat historique | sed "s/$ligneHisto/$newLine/" > tmpCarte
	cat tmpCarte > historique
	rm tmpCarte
elif [ $champsMaxVal -gt 0 ]
then
	ligneHisto=$(cat historique | grep -w "manche$manche"|grep -w "tour$tour"|grep -w "l$maxVal")
	newLine="$ligneHisto $carte"
	cat historique | sed "s/$ligneHisto/$newLine/" > tmpCarte
	cat tmpCarte > historique
	rm tmpCarte
else
	../../scripts/affichePlateau.sh $manche $tour
	
	if [ -n "$(echo $nomJ | grep '^J_bot')" ];then #Si un bot
		#echo Veuillez choisir la ligne a récuperer. Entre 1 et 4 pour $nomJ
		#read ligne <<< $((1+$RANDOM%4))
		ligne=$(../../scripts/choisi.sh $nomJ 1 $manche $tour)
		echo Je choisi la ligne = $ligne
	else
		ligne=0
		while ((ligne < 1  || ligne > 4));do
			echo Veuillez choisir la ligne a récuperer. Entre 1 et 4 pour $nomJ
			read ligne
		done
		
	fi
	ligneHisto=$(cat historique |grep -w "manche$manche"|grep -w "tour$tour"|grep -w "ligne$ligne")
	for i in {0..4};do
		numCarte=$(echo $ligneHisto | cut -d " " -f$((4+$i*3)) | tr -d l)
		if [ -n "$numCarte" ]
		then
			../../scripts/recupCarte.sh $nomJ $numCarte $manche $tour
		fi
	done
	newLine="manche$manche tour$tour ligne$ligne $carte"
	cat historique | sed "s/$ligneHisto/$newLine/" > tmpCarte
	cat tmpCarte > historique
	rm tmpCarte
fi
	#-------





