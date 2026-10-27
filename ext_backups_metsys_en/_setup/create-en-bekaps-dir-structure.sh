#! /bin/bash

# NOVO 20191023
#
#  ext_usbHDD_SAMPLE
#  |-- bekaps_en
#  |   |-- cugr_en
#  |   |-- 2019_cugr_en
#  |   |-- cygwin_hgr_en
#  |   |-- Downloads_cugr_en
#  |   |-- h_en_2019_podloge
#  |   |-- h_en_energetika
#  |   `-- myprogs_cugr_en
#  |-- en_METSYS
#  |-- ODPRTO_drpbx
#  `-- SKUPNI_drpbx

# create dir strucrue
mkdir -p $PWD/{bekaps_en,en_METSYS}

mkdir -p $PWD/{ODPRTO_drpbx,SKUPNI_drpbx}

cd $PWD/bekaps_en
mkdir -p \
./{cugr_en,\
2019_cugr_en,\
cygwin_hgr_en,\
Downloads_cugr_en,\
h_en_2019_podloge,\
h_en_energetika,\
myprogs_cugr_en}
