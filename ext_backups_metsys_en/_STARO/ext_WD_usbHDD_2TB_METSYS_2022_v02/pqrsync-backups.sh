#! /bin/bash

### Name:	qrsync_backups_20170911.sh
### Date:	2017_09_11
### Decription:
### 
### quick backup all (01_ ... 04_)
### *********************************************************************************************************
gr_CURDRV=$(cd $(dirname ${BASH_SOURCE[0]}) && cd ../ && pwd)

yes | ${gr_CURDRV}/en_METSYS/05-rbckp-cgr-en-myprgs.sh
