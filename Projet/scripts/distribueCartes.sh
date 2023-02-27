#!/bin/bash

#Utilise le paquet pour distribuer 10 cartes à un joueur#
nomJ=$1
manche=$2
cd $PWD
for idC in {1..10}
do
	carte=$(../../scripts/tirCarte.sh)
	echo manche$manche carte $carte >> $nomJ
done
rm tmp

echo Fin distribueCartes \: $nomJ
