#! /bin/bash

# NOVO 20191023
#
# ext_usbHDD_SAMPLE_d
# |-- bekaps_d
# |   |-- bekaps_d
# |   |-- mark
# |   |-- rgregor
# |   |-- spela
# |   |-- tadeja
# |   `-- zala
# |-- d_METSYS

# optional: might already exist!!
# |-- ODPRTO_drpbx
# `-- SKUPNI_drpbx

# create dir strucrue
mkdir -p $PWD/{bekaps_d,d_METSYS}

# optional: might already exist!!
# mkdir -p $PWD/{ODPRTO_drpbx,SKUPNI_drpbx}

cd $PWD/bekaps_d
mkdir -p \
./{rgregor,\
tadeja,\
zala,\
spela,\
mark}
