#!/bin/bash

cd $PWD
min=$1
max=$(($2-1))
rand=$(($min + $RANDOM % $max))
echo "l1 + $rand"> paquetCarte
for i in {2..104}
do
	rand=$(($min + $RANDOM % $max))
	echo "l$i + $rand">>paquetCarte
done 
