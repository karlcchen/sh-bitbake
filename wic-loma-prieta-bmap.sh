#!/bin/bash
#
# 
if [ "$1" = "" ] ; then 
    echo -e "/nERROR: need dest device input: for example /dev/sdd/n"
    exit 1 
fi 
~/sh-bitbake/bmap-tool-copy-wic2.sh -f build_output/deploy/images/loma-prieta/diag-minimal-loma-prieta.wic $1

