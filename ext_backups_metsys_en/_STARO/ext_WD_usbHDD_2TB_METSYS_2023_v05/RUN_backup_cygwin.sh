#! /usr/bin/env bash

### Name:	RUN_backup_cygwin.sh
###

# --- LOCAL VARS ---
# curryr=$(date +%Y)

if [ $CURRENT_YEAR_ENV -ne $(date +%Y) ]; then
		curryr=$CURRENT_YEAR_ENV
	else
		curryr=$(date +%Y)
fi

CURRDATE="$(date +%Y%m%d)"
DANES="$(date +%Y%m%d)"
CURRT="$(date +%Y%m%d_%H%M%S)"
CURDRV=$(cd $(dirname ${BASH_SOURCE[0]}) && cd ../ && pwd)
SRCDIR="/c/Users/gregor.redelonghi/majstaf_en/majprogs_en/cygwin64"
DESTDIR="${CURDRV}/ext_WD_usbHDD_2TB/CYGWINBCKP"
CNT=${CURDRV}/ext_WD_usbHDD_2TB/en_METSYS/tcount

if [ ! -d ${DESTDIR} ]; then
	echo "[ERR] no such destination: ${DESTDIR}"
	exit
fi

SCRPT="$(realpath $0)"



# --- EXPORTS ---
export DRIVE=${CURDRV}
export CNT


# --- FUNCTIONS ---
function tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}

crtn=3
function crtc() {
    for ((i=1; i<=$1; i++)); do
        echo -n "-"
    done
    echo
}

# --- MAIN ---
dT1=$(date +"%s")
(tms; echo "Starting ${SCRPT} ... ")
(tms; echo "Current Drive is: [ ${CURDRV} ]")

(tms; echo "Backing up ${SRCDIR} to ${DESTDIR}/ ...")
(tms; echo "Syncing ...  ")
# ORIGINAL:
# rsync -rltD --exclude "home"  --progress /c/Users/gregor.redelonghi/majstaf_en/majprogs_en/cygwin64 /d/ext_WD_usbHDD_2TB/CYGWINBCKP/
rsync -rltD --exclude "home"  --progress "${SRCDIR}" "${DESTDIR}/"
(tms; crtc $crtn)


dT2=$(date +"%s")
dlt=$((dT2-dT1))
time=$(($(cat ${CNT})+${dlt}))
echo $time > ${CNT}
(tms; echo "${SCRPT} done in $dlt seconds!")
crtc $crtn

exit

