#! /bin/bash

### Name:	001_rbckp_cgr_en.sh
### Date:	(2017-09-11)
###          20190826
###
### Decription:
### 
### rsync backup /c/Users/gregor.redelonghi/
### rsync backup /c/Users/gregor.redelonghi/myprogs/cygwin64
###
### UPDATE 20171208: timestamp function
### --progress replaced with --info=misc2,stats2 
###
### UPDATE 20180314
### --progress replaced with --info=misc2,stats2
### added timestamps and done in xxx sconds
### 
### UPDATE 20190826
### divided into 001, 002, 003 --> separate backups for cgr, cgr_Downloads and cyggr
###
### UPDATE 20190926
### instead of --exclude-from=DONOTBACKUP.txt --> --include-from=CUGR*.txt
###
### UPDATE 20191023
### NEW FOLDER STRUCTURE (NEW HDD)
### *********************************************************************************************************

# timestamp
function tms() {
    echo -n "[ $(date +%Y%m%d_%H%M%S) ] "
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
gr_RSDRO='rsync -rltDn --info=name0,stats2,progress0 --modify-window=2'       # DRY-RUN options
gr_RSO='rsync -rltD --info=name0,stats2,progress0 --modify-window=2'           # RUN backup ptions
gr_FILT='/usr/bin/grep "files\|total"'

# EXPORTS
export gr_DRIVE=${gr_CURDRV}
export gr_BEKAPD=${gr_DRIVE}/bekaps_en
export gr_LOGF=${gr_BEKAPD}/bekap_en.log
export gr_INCLD=${gr_DRIVE}/en_METSYS/CUGR.txt


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

# check if --exclude-from file exists
if [ ! -e ${gr_INCLD} ]; then
    (tms; echo "Wrog DRIVE letter or there is no ${gr_INCLD}. Aborting ...") | tee -a ${gr_LOGF}
	exit 1
fi

### changed 20190115
# tms; echo "${gr_INCLD} exist. It is safe to continue ..."
tms; echo "${gr_BEKAPD} and ${gr_INCLD} exist. It is safe to continue ..."

cd ${gr_BEKAPD}
tms; echo "Current directory is ${PWD} ..."
### changed 20190115
# read -p "Continue?"

# START

tms; echo "-----------------------------------------------------------------------------"
(tms; echo "Backing up /c/Users/gregor.redelonghi/ to ${gr_BEKAPD} ...") | tee -a ${gr_LOGF}
(tms; echo "Syncing ...  ") | tee -a ${gr_LOGF}
${gr_RSO} --delete --include-from=${gr_INCLD} /c/Users/gregor.redelonghi/ ${gr_BEKAPD}/cugr_en/ | eval ${gr_FILT} | while read line; do (tms; echo $line); done
(tms; echo "-----------------------------------------------------------------------------") | tee -a ${gr_LOGF}

dT2=$(date +"%s")
(tms; echo "${gr_0} done in $((dT2-dT1)) seconds!") | tee -a  ${gr_LOGF}
(tms; echo "-----------------------------------------------------------------------------") | tee -a ${gr_LOGF}
# tms; echo "============================================================================="
exit
