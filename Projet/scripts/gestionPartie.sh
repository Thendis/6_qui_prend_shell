#!/bin/bash

#Gere le deroulement de la partie#
#Distribution des cartes#
#Ouverture des terminaux individuel#
# : J_1 À j_6#

#count=0
manche=1
maxPoints=0


cd $PWD #Se deplace dans le dossier de partie
trap 'count=$(($count+1));echo signal$count.' USR1
#tir les cartes du plateau
for i in ligne1 ligne2 ligne3 ligne4
do
	carte=$(../../scripts/tirCarte.sh)
	echo manche$manche tour1 $i $carte >> historique
done

#Distribue les cartes 
#Créer un terminal pour chaque jour
for i in $1 $2 $3 $4 $5 $6
do
	echo "manche$manche tour1 points : 0">>$i
	../../scripts/distribueCartes.sh $i $manche
	xterm -e  ../../scripts/joueur.sh $i $$ &
done

loop=true
while($loop)
do :
	count=0
	for tour in {1..10};do
		echo
		echo MANCHE $manche ,TOUR $tour
			#Attend les reponses des 6 joueurs
		while(( $count < 6 ))
		do
			true
		done
			#-----
			#Ordonne en numero choisi PID nom
		for i in $(ls | grep '^J_' )
		do
			echo "$(cat $i |grep -w "manche$manche"|grep -w "tour$tour"|grep -w "reponse" | cut -d " " -f4)-$(cat $i | grep PID | cut -d " " -f3)-$i" >> reponses
		done
			#-----
			#Appel les joueurs par ordre de valeur de carte
		for i in $(cat reponses | sort -g)
		do
			ID=$(echo $i |cut -d "-" -f2)
			nomJ=$(echo $i |cut -d "-" -f3)
			echo $nomJ est entrain de placer sa carte
			kill -USR2 $ID
			count=0;
				#Attend fin de traitement pour ID
			while(($count < 1))
			do
				true
			done
				#-------
			lignePoints=$(cat $nomJ |grep -w "manche$manche" |grep -w "tour$tour points :")
			points=$(echo $lignePoints | cut -d " " -f5)
			if [ $tour -eq 10 ];then
				echo "manche$(($manche+1)) tour1 points : $points" >> $nomJ
			else
				echo "manche$manche tour$(($tour+1)) points : $points" >> $nomJ
			fi
			
			if [ $points -gt $maxPoints ];then
				maxPoints=$points
			fi
		done
		rm reponses
			#------

			#Prepare histo prochain tour
		for i in {1..4}
		do
			ligne=$(cat historique |grep -w "manche$manche" |grep  -w "tour$tour"|grep -w "ligne$i" )
			newLigne=$(echo $ligne |sed "s/tour$tour/tour$(($tour+1))/" )
			echo $newLigne >> historique
		done
			#------
			sleep 1
		
		if [ $tour -lt 10 ];then #Init prochain tour ou non
			count=0
				#Signal pour prochain tour
			for i in $(ls | grep '^J_' )
			do
				ID=$(cat $i | grep PID | cut -d " " -f3)
				kill -USR1 $ID
			done
				#-------
		fi
	done 
		#Fin boucle tour

	if [ $maxPoints -gt 65 ];then
			loop=false
	
	else
		mv paquetCarte paquetCarteManche$manche
		manche=$(($manche+1))
		../../scripts/initCarte.sh $7 $8
			#tir les cartes du plateau
		for i in {1..4}
		do
			carte=$(../../scripts/tirCarte.sh)
			echo manche$manche tour1 ligne$i $carte >> historique
		done
			#-------
			#Distribue les cartes 
		for i in $1 $2 $3 $4 $5 $6
		do
			../../scripts/distribueCartes.sh $i $manche
		done
			#-------
			#Signal pour prochain tour
		for i in $(ls | grep '^J_' )
		do
			echo \~signal nouvelle manche
			ID=$(cat $i | grep PID | cut -d " " -f3)
			kill -USR1 $ID
		done
			#-------
	fi
	
done

echo __________________________ >> classement
echo AFFICHAGE DES RESULTATS >>classement
sleep 2
for i in $(ls | grep "^J_");do
	echo $(cat $i |grep "manche$manche tour10 points : "|cut -d " " -f5)-$i >> classement
done
cat classement |tr "-" " " |sort -g >tmpClassement
cat tmpClassement > classement
rm tmpClassement
echo END >> historique #Permet aux joueur de savoir que la partie est fini
cat classement

basename $PWD #Affiche le nom de la partie
read




















