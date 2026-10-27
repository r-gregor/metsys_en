#! /bin/bash

# 012-rbckp-cgr-en-Downloads.sh
# 20250430
### *********************************************************************************************************

# --- LOCAL VARS ---
curryr=$(date +%Y)

gCurrDir=$(realpath ${BASH_SOURCE})
gr_CURRDATE="$(date +%Y%m%d)"
gr_DANES="$(date +%Y%m%d)"
gr_CURRT="$(date +%Y%m%d_%H%M%S)"
gr_CURDRV=$(cd $(dirname ${BASH_SOURCE[0]}) && cd ../ && pwd)

gr_0="$(realpath $0)"

gr_RSDRO='rsync -rltDWn --update --info=name0,stats2,progress0 --modify-window=2'       # DRY-RUN options
gr_RSO='rsync -rltDW --update --info=name0,stats2,progress0 --modify-window=2'           # RUN backup ptions
gr_FILT='/usr/bin/grep "files\|total"'

# --- EXPORTS ---
export gr_DRIVE=${gr_CURDRV}
export gr_BEKAPD=${gr_DRIVE}/bekaps_en
export gr_INCLD=${gr_DRIVE}/en_METSYS/CUGR_Downloads.txt
export gr_CNT=${gr_DRIVE}/en_METSYS/tcount


# --- FUNCTIONS ---
function runHDD() {
	${gr_RSO} /c/Users/gregor.redelonghi/Downloads/ ${gr_BEKAPD}/Downloads_cugr_en/ | eval ${gr_FILT} | while read line; do (tms; echo $line); done
}

function runUSB() {
	${gr_RSO} --exclude "Downloaded-ISO-s" --exclude "_IMAGES" /c/Users/gregor.redelonghi/Downloads/ ${gr_BEKAPD}/Downloads_cugr_en/ | eval ${gr_FILT} | while read line; do (tms; echo $line); done
}

function runBackup() {
	if [[ "${gCurrDir}" == *"_SANDISK_"* ]]; then
		runUSB
	elif [[ "${gCurrDir}" == *"WD"* ]]; then
		runHDD
	else
		echo "NO backup media found!"
		exit 1
	fi
}


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
(tms; echo "Starting ${gr_0} ... ")

tms; echo "Current Drive is: [ ${gr_CURDRV} ]."

if [ ! -e ${gr_BEKAPD} ]; then
    (tms; echo "Wrog DRIVE letter or there is no ${gr_BEKAPD}. Aborting ...")
	exit 1
fi

if [ ! -e ${gr_INCLD} ]; then
    (tms; echo "Wrog DRIVE letter or there is no ${gr_INCLD}. Aborting ...")
	exit 1
fi

tms; echo "${gr_BEKAPD} and ${gr_INCLD} exist. It is safe to continue ..."

cd ${gr_BEKAPD}
tms; echo "Current directory is ${PWD} ..."

(tms; echo "Backing up /c/Users/gregor.redelonghi/Downloads/ to ${gr_BEKAPD} ...")
(tms; echo "Syncing ...  ") 
runBackup
(tms; crtc $crtn)


dT2=$(date +"%s")
dlt=$((dT2-dT1))
time=$(($(cat ${gr_CNT})+${dlt}))
echo $time > ${gr_CNT}

(tms; echo "${gr_0} done in $dlt seconds!")
crtc $crtn

exit

