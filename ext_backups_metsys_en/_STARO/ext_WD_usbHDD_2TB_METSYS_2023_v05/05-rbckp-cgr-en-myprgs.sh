#! /bin/bash

### Name:	05-rbckp-cgr-en-myprgs.sh
### Date:	20230120
###
### *********************************************************************************************************


# --- LOCAL VARS ---
# curryr=$(date +%Y)

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

gr_RSDRO='rsync -rltDn --update --info=name0,stats2,progress0 --modify-window=2'       # DRY-RUN options
gr_RSO='rsync -rltD --update --info=name0,stats2,progress0 --modify-window=2'          # RUN backup ptions
gr_FILT='/usr/bin/grep "files\|total"'

# --- EXPORTS ---
export gr_DRIVE=${gr_CURDRV}
export gr_BEKAPD=${gr_DRIVE}/n_bekaps
export gr_LOGF=${gr_BEKAPD}/bekap_en.log
export gr_DNBCKP=${gr_DRIVE}/en_METSYS/PDONOTBACKUP.txt
export gr_CNT=${gr_DRIVE}/en_METSYS/tcount
BASEDIR="/c/Users/gregor.redelonghi/majstaf_en/majprogs_en"


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
(tms; echo "Starting ${gr_0} ... ") | tee -a ${gr_LOGF}

tms; echo "Current Drive is: [ ${gr_CURDRV} ]."

tms; echo "log-file: ${gr_LOGF}"

if [ ! -e ${gr_BEKAPD} ]; then
    (tms; echo "Wrog DRIVE letter or there is no ${gr_BEKAPD}. Aborting ...") | tee -a ${gr_LOGF}
	exit 1
fi

if [ ! -e ${gr_DNBCKP} ]; then
    (tms; echo "Wrog DRIVE letter or there is no ${gr_DNBCKP}. Aborting ...") | tee -a ${gr_LOGF}
	exit 1
fi

tms; echo "${gr_BEKAPD} and ${gr_DNBCKP} exist. It is safe to continue ..."

cd ${gr_BEKAPD}
tms; echo "Current directory is ${PWD} ..."
(tms; echo "Backing up ${BASEDIR} to ${gr_BEKAPD} ... ") | tee -a ${gr_LOGF}
(tms; echo "Syncing ...  ") | tee -a ${gr_LOGF}
${gr_RSO} --delete --exclude-from=${gr_DNBCKP} ${BASEDIR}/ ${gr_BEKAPD}/myprogs_cugr_en/ | eval ${gr_FILT} | while read line; do(tms; echo $line); done
(tms; crtc $crtn) | tee -a ${gr_LOGF}


dT2=$(date +"%s")
dlt=$((dT2-dT1))
time=$(($(cat ${gr_CNT})+${dlt}))
echo $time > ${gr_CNT}
(tms; echo "${gr_0} done in $dlt seconds!") | tee -a  ${gr_LOGF}
crtc $crtn | tee -a ${gr_LOGF}

exit

