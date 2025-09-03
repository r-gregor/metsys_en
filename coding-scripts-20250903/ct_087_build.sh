#! /bin/env bash


if [ ! -d bin ]; then
	echo "No bin directory! Creating one ..."
	mkdir ./bin
fi


set -xe
gcc -o bin/unicodechars unicodechars.c -lm

