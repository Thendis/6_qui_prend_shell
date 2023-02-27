#!/bin/bash

cd $PWD

flag=true
while($flag)
do
	idCarte=l$((1+$RANDOM%104))
	carte=$(cat paquetCarte| grep -w $idCarte | grep +)
	if [ -n "$carte" ]; then
		flag=false
	fi
done

ap=$(echo $carte | tr + -)
cat paquetCarte | sed "s/$carte/$ap/" >tmp
cat tmp > paquetCarte
echo $carte
