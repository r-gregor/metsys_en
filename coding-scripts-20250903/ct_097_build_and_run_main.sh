#! /bin/env bash


echo "[INFO ] - Building main ..."

# set -xe
gcc -ggdb -Wall -o bin/main main.c -lm


if [ $? -eq 0 ]; then
	echo "[INFO ] - Succesfully built main.c into ./bin/main!"
else
	echo "[ERROR] - Building ./bin/main failed!"
fi

echo "[INFO ] - Running ./bin/main ..."
./bin/main


if [ $? -eq 0 ]; then
	echo "[INFO ] - Succesfully created \"imgs/output.png\""
else
	echo "[ERROR] - Running ./bin/main failed!"
fi
