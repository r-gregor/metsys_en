#! /bin/bash

# 013-rbckp-cyggr-en.sh
# 20250430
# *********************************************************************************************************

# --- LOCAL VARS ---
if [ $CURRENT_YEAR_ENV -ne $(date +%Y) ]; then
		curryr=$CURRENT_YEAR_ENV
	else
		curryr=$(date +%Y)
fi

gr_CURRDATE="$(date +%Y%m%d)"
gr_DANES="$(date +%Y%m%d)"
gr_CURRT="$(date +%Y%m%d_%H%M%S)"
gr_CURDRV=$(cd $(dirname ${BASH_SOURCE[0]}) && cd ../ && pwd)

gr_0="$(realpath $0)"

gr_RSDRO='rsync -rltDWn --exclude '.git/' --update --info=name1,stats2,progress0 --modify-window=2'  # DRY-RUN options
gr_RSO='rsync -rltDW --exclude '.git/' --update --info=name0,stats2,progress0 --modify-window=2'     # RUN backup ptions
gr_FILT='/usr/bin/grep "files\|total"'

# --- EXPORTS ---
export gr_DRIVE=${gr_CURDRV}
export gr_BEKAPD=${gr_DRIVE}/bekaps_en
export gr_INCLD=${gr_DRIVE}/en_METSYS/CYGGR.txt
export gr_CNT=${gr_DRIVE}/en_METSYS/tcount

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

(tms; echo "Backing up @Cygwin/home/gregor.redelonghi/ to ${gr_BEKAPD} ...")
(tms; echo "Syncing ...  ")
${gr_RSO} --delete /home/gregor.redelonghi/ ${gr_BEKAPD}/cygwin_hgr_en/ | eval ${gr_FILT} | while read line; do (tms; echo $line); done
(tms; crtc $crtn)


dT2=$(date +"%s")
dlt=$((dT2-dT1))
time=$(($(cat ${gr_CNT})+${dlt}))
echo $time > ${gr_CNT}
(tms; echo "${gr_0} done in $dlt seconds!")
crtc $crtn

exit

