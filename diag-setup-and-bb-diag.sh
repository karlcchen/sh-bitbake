#!/bin/bash
#
#
#pwd
#cd SonicCoreX
#if [ $? -ne 0 ] ; then 
#    pwd
#    echo -e "\nERROR: cd SonicCoreX failed!"
#    exit 4 
#fi
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

source ${BB_DIR}/setup-diag-loma-prieta.sh
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: source ${BB_DIR}/setup-diag-loma-prieta.sh failed!"
    exit 1 
fi

${BB_DIR}/bb-diag.sh
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: ${BB_DIR}/bb-diag.sh failed!"
    exit 2
fi

