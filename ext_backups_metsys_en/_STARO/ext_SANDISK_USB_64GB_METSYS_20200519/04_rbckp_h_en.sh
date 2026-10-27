#! /bin/bash

### Name:	04_rbckp_h-en.sh
### Date:	2017-09-11
### Decription:
### 
### rsync backup /h/energetika
### rsync backup /h/2017/_2017_podloge/
###
### UPDATE 20171208: timestamp function
### --progress replaced with --info=misc2,stats2 
###
### UPDATE 20180314
### --progress replaced with --info=misc2,stats2
### added timestamps and done in xxx sconds
###
### UPDATE 20190926
### removed test for DONOTBACKUP* file existance
###
### UPDATE 20191023
### NEW FOLDER STRUCTURE (NEW HDD)
###
### UPDATE 20200519
### function crtc -- sepparator draw
### *********************************************************************************************************


curryr=2020

# timestamp
function tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
}


crtn=100
function crtc() {
    for ((i=1; i<=$1; i++)); do
        echo -n "-"
    done
    echo
}


# VARIABLES
gr_CURRDATE="$(date +%Y%m%d)"
gr_DANES="$(date +%Y%m%d)"
gr_CURRT="$(date +%Y%m%d_%H%M%S)"
gr_CURDRV=${PWD}


gr_0="$(realpath $0)"


# VARIABLES new 20170303
# UPDATED 20171208: --progress replaced with --info=misc2,stats2
# UPDATED 20180411: --info=name0,stats2,progress0; gr_FILT='\grep "files\|total"'
gr_RSDRO='rsync -rltDn --update --info=name0,stats2,progress0 --modify-window=2'       # DRY-RUN options
gr_RSO='rsync -rltD --update --info=name0,stats2,progress0 --modify-window=2'           # RUN backup ptions
gr_FILT='/usr/bin/grep "files\|total"'

# EXPORTS
export gr_DRIVE=${gr_CURDRV}
export gr_BEKAPD=${gr_DRIVE}/bekaps_en
export gr_LOGF=${gr_BEKAPD}/bekap_en.log


# RUN ...
dT1=$(date +"%s")
(tms; echo "Starting ${gr_0} ... ") | tee -a ${gr_LOGF}

### change 20190115
# read -p "Current Drive is: [ ${gr_CURDRV} ]. OK?"
tms; echo "Current Drive is: [ ${gr_CURDRV} ]."

tms; echo "log-file: ${gr_LOGF}"

### added 20190115
# check if bekaps directory exists
if [ ! -e ${gr_BEKAPD} ]; then
    (tms; echo "Wrog DRIVE letter or there is no ${gr_BEKAPD}. Aborting ...") | tee -a ${gr_LOGF}
	exit 1
fi

### changed 20190926
### # check if --exclude-from file exists
### if [ ! -e ${gr_DNBCKP} ]; then
###     (tms; echo "Wrog DRIVE letter or there is no ${gr_DNBCKP}. Aborting ...") | tee -a ${gr_LOGF}
### 	exit 1
### fi


### changed 20190926
tms; echo "${gr_BEKAPD} exists. It is safe to continue ..."

cd ${gr_BEKAPD}
tms; echo "Current directory is ${PWD} ..."
### changed 20190115
# read -p "Continue?"

# START
# tms; echo "-----------------------------------------------------------------------------"
(tms; echo "Backing up /h/energetika to ${gr_BEKAPD} ... ") | tee -a ${gr_LOGF}
(tms; echo "Syncing ...  ") | tee -a ${gr_LOGF}
${gr_RSO} --delete /h/energetika/ ${gr_BEKAPD}/h_en_energetika/ | eval ${gr_FILT} | while read line; do(tms; echo $line); done
(tms; crtc $(($crtn-20))) | tee -a ${gr_LOGF}

(tms; echo "Backing up /h/${curryr}/_${curryr}_podloge/ to ${gr_BEKAPD} ... ") | tee -a ${gr_LOGF}
(tms; echo "Syncing ...  ") | tee -a ${gr_LOGF}
${gr_RSO} /h/${curryr}/_${curryr}_podloge/ ${gr_BEKAPD}/h_en_${curryr}_podloge/ | eval ${gr_FILT} | while read line; do(tms; echo $line); done
(tms; crtc $(($crtn-20))) | tee -a ${gr_LOGF}

dT2=$(date +"%s")
(tms; echo "${gr_0} done in $((dT2-dT1)) seconds!") | tee -a  ${gr_LOGF}
crtc $crtn | tee -a ${gr_LOGF}
exit

