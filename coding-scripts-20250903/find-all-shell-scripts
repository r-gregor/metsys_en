#! /usr/bin/env bash

# find -type f -exec file {}\; | grep "shell script" | awk -F : '{ print $1 }'
find -type f -iname "*\.sh" | xargs -I{} file {} | grep "shell script" | awk -F : '{ print $1 }'

