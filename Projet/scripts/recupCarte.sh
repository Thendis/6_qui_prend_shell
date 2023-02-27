#!/bin/bash
#Donne une carte a un joueur. Lui attribu ses points et met a jours son historique perso et l'historique general#
# : nomJoueur n°Carte manche tour#
cd $PWD
nomJ=$1
carte=$(cat paquetCarte | grep -w "l$2" | tr -d "[a-k][m-z]")
oldP=$(cat $nomJ | grep "manche$3 tour$4 points" | cut -d " " -f5)
tete=$(echo $carte | cut -d " " -f3)
newP=$(($oldP + $tete))
oldLine=$(cat $nomJ | grep "manche$3 tour$4 points")
newLine="manche$3 tour$4 points : $newP"
cat $nomJ | sed "s/$oldLine/$newLine/" > tmpRecup
cat tmpRecup > $nomJ
rm tmpRecup
echo manche$3 tour$4 recupere $(cat paquetCarte | grep -w "l$2") >> $nomJ
