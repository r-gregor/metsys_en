#! /bin/env bash


echo "[INFO ] - Building japan ..."

# set -xe
gcc -ggdb -Wall -o bin/japan japan.c -lm


if [ $? -eq 0 ]; then
	echo "[INFO ] - Succesfully built japan.c into bin/japan!"
else
	echo "[ERROR] - Building bin/japan failed!"
fi

