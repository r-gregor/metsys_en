#! /bin/bash

curryr=$(date +%Y)

gr_CURDRV=$(cd $(dirname ${BASH_SOURCE[0]}) && cd ../ && pwd)


${gr_CURDRV}/en_METSYS/011-rbckp-cgr-en.sh && \
${gr_CURDRV}/en_METSYS/012-rbckp-cgr-en-Downloads.sh && \
${gr_CURDRV}/en_METSYS/013-rbckp-cyggr-en.sh && \
${gr_CURDRV}/en_METSYS/02-rbckp-cgr-en-${curryr}.sh && \
${gr_CURDRV}/en_METSYS/03-rbckp-cgr-drpbx-en.sh && \
${gr_CURDRV}/en_METSYS/04-rbckp-h-en.sh\






