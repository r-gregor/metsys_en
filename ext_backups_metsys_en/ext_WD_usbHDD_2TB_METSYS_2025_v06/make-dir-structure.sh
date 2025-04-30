#! /usr/bin/env bash

# make-dir-structure.sh
# 20240530
# ------------------------------------

created=0

dirs=(bekaps_en \
	bekaps_en/cugr_en \
	bekaps_en/CURRYR_cugr_en \
	bekaps_en/Downloads_cugr_en \
	bekaps_en/cygwin_hgr_en \
	bekaps_en/h_CURRYR_podloge_en \
	bekaps_en/myprogs_cugr_en)

for DIR in ${dirs[@]}; do
	if [ ! -d $DIR ]; then
		echo "[INFO] $DIR does not exist. Creating one ..."
		echo -n "       "
		mkdir -v -p $DIR
		let created=created+1
	else
		continue
	fi
done

echo "[INFO] ${created} directories created"

