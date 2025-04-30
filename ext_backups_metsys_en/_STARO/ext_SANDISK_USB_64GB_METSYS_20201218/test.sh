#! /bin/bash

curryr=2020


gCurrDir=$(realpath ${BASH_SOURCE})
echo "Current dir: ${gCurrDir}"

if [[ $(grep "SAMSUNG" ${gCurrDir}) == *"SAMSUNG"* ]]; then
	echo "IT IS USB-key!"
elif [[ $(grep "WD" ${gCurrDir}) == *"WD"* ]]; then
	echo "IT IS WD HDD!"
else
	echo "NO vialble backup media found!"
fi

read -p "Continue?"


