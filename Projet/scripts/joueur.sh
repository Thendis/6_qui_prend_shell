#!/bin/bash
#Gère les informations dédidé a un joueur#
cd $PWD
trap 'attend=false; echo \~signal usr1 reçu $manche $tour' USR1
trap '
carteNum=$(cat $nom |grep -w "manche$manche"|grep -w "tour$tour"|grep -w "reponse" | cut -d " " -f4);
../../scripts/placeCarte.sh $nom $carteNum $manche $tour;
kill -USR1 $pere' USR2


pere=$2
nom=$1
points=0
manche=1
loop=true
enJeu=true
echo Je suis dans \:
pwd
echo Creation du joueur de $1
echo PID \: $$ >> $nom
echo Pere = $pere
while($enJeu)
do 
	#boucle des tours
	for i in {1..10}
	do
		tour=$i;
		../../scripts/affichePlateau.sh $manche $tour #Affiche le plateau
			#Créer liste des vals+tete (Pour afficheCartes)
		listVal=$(cat $nom | grep "manche$manche carte"|grep + |tr -d l |cut -d " " -f3)
			listVal=$(echo $listVal | tr " " "," )
		listTete=$(cat $nom | grep "manche$manche carte"|grep +| cut -d " " -f5 )
			listTete=$(echo $listTete | tr " " "," )
			#-------

		echo MANCHE $manche, TOUR $tour
		echo Voici vos carte. Choisi en une carte par son numero central
		../../scripts/afficheCartes.sh $listVal $listTete #Affiche les cartes jouable
		echo 
			
		echo $(cat $nom | grep "J_bot")
		if [ -n "$(cat $nom | grep "J_bot")" ];then #Si est un bot
			sleep 2
			#carte=$(cat $nom | grep -w "manche$manche carte" |grep +|head -n 1)
			#reponse=$(echo $carte | cut -d " " -f3 | tr -d l)
			reponse=$(../../scripts/choisi.sh $nom 0 $manche $tour)
			echo Je choisi la carte = $reponse
		else
				#Verifie que la carte existe
			while($loop)
			do
				echo Choisi ta carte;read reponse
				cherche=$(echo $listVal | grep $reponse)
				if [  -n "$cherche" ];then
					loop=false;
				fi
			done
				#-----------
		fi		
		
			

		loop=true;
			#Maj de historique perso
		echo manche$manche tour$tour reponse $reponse >> $nom 
		getLine=$(cat $nom | grep -w "manche$manche carte l$reponse +")
		
			#recupere la carte a modifier et change le + en -
		modif=$(echo $getLine | tr + -)
		cat $nom | sed "s/$getLine/$modif/" > tmp$nom
		cat tmp$nom > $nom
		rm tmp$nom
			#------

			kill -USR1 $pere 
			echo signal envoyé pour m$manche t$tour
				#--Fin de tour

			#Attend le signal de gestionPartie
			#Verifie si le jeu est fini
			attend=true
		echo Attente des autres joueurs
		while $attend
		do
			if [ -n "$(cat historique|grep -w END)" ]
			then
				attend=false
				enJeu=false
			fi
		done
			#--------
	done
	manche=$(($manche+1))
done

if [ -n "$(cat $nom | grep "J_bot")" ] #Si est un joueur, laisse le temps de voir le classement
then
	exit 0
else
	cat classement
	read
	exit 0
fi

exit 1

















