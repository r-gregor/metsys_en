#! /bin/bash

curryr=2020

gr_CURDRV=$(cd $(dirname ${BASH_SOURCE[0]}) && cd ../ && pwd)

${gr_CURDRV}/en_METSYS/011-rbckp-cgr-en.sh && \
${gr_CURDRV}/en_METSYS/012-rbckp-cgr-en-Downloads.sh && \
${gr_CURDRV}/en_METSYS/013-rbckp-cyggr-en.sh && \
${gr_CURDRV}/en_METSYS/02-rbckp-cgr-en-${curryr}.sh\
