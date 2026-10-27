#! /usr/bin/env bash
# fname: _update-remotes.sh
# descpt: 
# 20261027 v1
# last: 20261027
# ---

printf "[!] updating remotes ... "
git remote rm origin
git remote add ghmts git@github.com:r-gregor/metsys_en.git
git remote add glmts git@gitlab.com:r-gregor/metsys_en.git
# git remote add cbmts git@codeberg.org:r-gregor/metsys_en.git
printf "done\n\n"
git remote -v

