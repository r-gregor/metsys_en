#! /bin/env bash


if [ ! -d bin ]; then
	echo "No bin directory! Creating one ..."
	mkdir ./bin
fi

echo "Output:"
set -xe
gcc -o bin/unicodechars unicodechars.c -lm
bin/unicodechars

