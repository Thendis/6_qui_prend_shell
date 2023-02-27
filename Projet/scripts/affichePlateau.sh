#!/bin/bash

cd $PWD
manche=$1
tour=$2
for i in {1..4};do
	line=$(cat historique | grep "manche$manche tour$tour ligne$i")
	for nb in {0..4};do
		posL=$((4+(3*$nb)))
		posT=$((6+(3*$nb)))
		value=$(echo $line | cut -d " " -f$posL | tr -d l)
		tete=$(echo $line | cut -d " " -f$posT)
		listValeurs=$listValeurs,$value
		listTetes=$listTetes,$tete
	done
	echo ~~~~~~~~~~
	echo ~~~~~~~~~~
	../../scripts/afficheCartes.sh $listValeurs $listTetes
	echo 
	listValeurs=$empty
	listTetes=$empty
done
