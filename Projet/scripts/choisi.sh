#!/bin/bash

nom=$1
type=$2 
	#0 = choisi sa carte
	#autre = choisi la ligne a recuperer
manche=$3
tour=$4

cd $PWD

	#Pour choix de la carte a poser
if [ $type -eq 0 ];then
	#renvoie la valeur de sa carte qui a l'ecart positif le plus bas avec l'une des dernières cartes du plateau (Si la carte n'est pas la 5em)
	#Si ne peut jouer aucune carte, joue
	minEcart=105
	for maVal in $(cat $nom | grep -w "manche$manche carte" |grep -w + |cut -d " " -f3 | tr -d l )
	do
		for i in {1..4}
		do
			indiceMax=$(cat historique |grep -w "manche$manche tour$tour ligne$i" | wc -w)
			derniereCarte=$(cat historique |grep -w "manche$manche tour$tour ligne$i" | cut -d " " -f$(($indiceMax-2))|tr -d l)
			ecart=$(($maVal - $derniereCarte))
			if [[ $ecart -gt 0 && $ecart -lt $minEcart && $indiceMax -ne 18 ]]
			then
				minEcart=$ecart
				valFinal=$maVal
			fi
		done
	done
		#Si n'a pas de carte jouable
	if [ -z "$valFinal" ]
	then 
		valFinal=$(cat $nom | grep -w "manche$manche carte" |grep -w +|head -n 1 | cut -d " " -f3 | tr -d l) #Prend par defaut la première valeur
		maxTete=$(cat $nom | grep -w "manche$manche carte" |grep -w +|head -n 1 | cut -d " " -f5 ) #Prend par defaut la première valeur de tête
		#Joue la carte avec la plus haute tête de boeuf
		cat $nom |grep -w "manche$manche carte" |grep -w + > cartesDispo$nom
		for maLigne in $(cat cartesDispo$nom | tr " " "_")
		do
			numCarte=$(echo $maLigne |tr "_" " " |cut -d " " -f3 | tr -d l)
			numTete=$(echo $maLigne |tr "_" " " |cut -d " " -f5)
			if [ $numTete -gt $maxTete ]
			then
				valFinal=$numCarte
				maxTete=$numTete
			fi
		done
			rm cartesDispo$nom
			#--------
	fi
	#---------
	#Pour choix de la ligne a recuperer
	#Cherche la ligne avec les valeurs de tête cumulé les moins haute
else
	ligne=$(cat historique |grep -w "manche$manche tour$tour ligne1")
	minSomme=0
	minLigne=1
	maxIndice=$(echo $ligne | wc -w)
	for i in {0..4} #Initialisation aux valeurs de la première ligne
	do
		indice=$(( 6 + ($i*3)))
		if [ $maxIndice -ge $indice ];then
			teteCarte=$(echo $ligne | cut -d " " -f$indice)
			minSomme=$(($minSomme + $teteCarte))
		fi
	done

	for i in {2..4} # boucle sur les ligne 2 3 4
	do
		ligne=$(cat historique |grep -w "manche$manche tour$tour ligne$i")
		somme=0
		maxIndice=$(echo $ligne | wc -w)
		for c in {0..4} #Initialisation aux valeurs de la première ligne
		do
			indice=$(( 6 + ($c*3)))
			if [ $maxIndice -ge $indice ];then
				teteCarte=$(echo $ligne | cut -d " " -f$indice)
				somme=$(($somme + $teteCarte))
			fi
		done
		if [ $somme -lt $minSomme ];then
			minSomme=$somme
			minLigne=$i
			
		fi
	done
	valFinal=$minLigne;
fi
	#---------

echo $valFinal





















