#! /bin/env bash


echo "[INFO ] - Building wang ..."

# set -xe
gcc -ggdb -Wall -o bin/wang wang.c -lm


if [ $? -eq 0 ]; then
	echo "[INFO ] - Succesfully built wang.c into ./bin/wang!"
else
	echo "[ERROR] - Building ./bin/wang failed!"
fi

echo "[INFO ] - Running ./bin/wang ..."
./bin/wang


if [ $? -eq 0 ]; then
	echo "[INFO ] - Succesfully created \"imgs/output.png\""
else
	echo "[ERROR] - Running ./bin/wang failed!"
fi
