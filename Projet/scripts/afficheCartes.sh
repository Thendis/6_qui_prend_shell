#!/bin/bash

#Affiche les cartes de façon graphique
count=0
read v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 <<< $(echo -n $1 |tr -d l |tr  , " ") #<<< permet de rensseigner une chaine
read t11 t12 t13 t14 t15 t16 t17 t18 t19 t20 t21 <<< $(echo -n $2 | tr , " ")


for i in $v1 $v2 $v3 $v4 $v5
do
	if [ -n "$i" ];then
		ligne1="$ligne1 **./.\.** "
	fi
done

for i in $v1 $v2 $v3 $v4 $v5 
do
	if [ -n "$i" ];then
		ligne2="$ligne2 *./...\.* "
	fi
done

for i in $v1 $v2 $v3 $v4 $v5 
do
	if [ -n "$i" ];then
		if (($i > 99)) 
		then
			ligne3="$ligne3 *.\\$i/.* "
		elif (($i > 9))
		then
			ligne3="$ligne3 *.\.$i/.* "
		else
			ligne3="$ligne3 *.\.$i./.* "
		fi
	fi
done

for i in $v1 $v2 $v3 $v4 $v5 
do
	if [ -n "$i" ];then
		ligne4="$ligne4 *..\./..* "
	fi
done
for i in $t11 $t12 $t13 $t14 $t15 
do
	if [ -n "$i" ];then
		if(($i > 9))
		then
			ligne5="$ligne5 **...$i** "
		else
			ligne5="$ligne5 **....$i** "
		fi
	fi
done

if [ -n "$ligne1" ];then
	echo 
	echo $ligne1
	echo $ligne2
	echo $ligne3
	echo $ligne4
	echo $ligne5
fi

for i in $v6 $v7 $v8 $v9 $v10 
do
	if [ -n "$i" ];then
		ligne6="$ligne6 **./.\.** "
	fi
done

for i in $v6 $v7 $v8 $v9 $v10  
do
	if [ -n "$i" ];then
		ligne7="$ligne7 *./...\.* "
	fi
done

for i in $v6 $v7 $v8 $v9 $v10  
do
	if [ -n "$i" ];then
		if (($i > 99)) 
		then
			ligne8="$ligne8 *.\\$i/.* "
		elif (($i > 9))
		then
			ligne8="$ligne8 *.\.$i/.* "
		else
			ligne8="$ligne8 *.\.$i./.* "
		fi
	fi
done

for i in $v6 $v7 $v8 $v9 $v10  
do
	if [ -n "$i" ];then
		ligne9="$ligne9 *..\./..* "
	fi
done
for i in $t16 $t17 $t18 $t19 $t20  
do
	if [ -n "$i" ];then
		if(($i > 9))
		then
			ligne10="$ligne10 **...$i** "
		else
			ligne10="$ligne10 **....$i** "
		fi
	fi
done

if [ -n "$ligne6" ];then
	echo ----
	echo ----
	echo $ligne6
	echo $ligne7
	echo $ligne8
	echo $ligne9
	echo $ligne10
fi





