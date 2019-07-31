#!/bin/bash
#
BB_PROJECT="diag-minimal"
LOG_FILE="${BB_PROJECT}-clean-sstate.log"
TEE_LOG="tee --append ${LOG_FILE}"
rm -f ${LOG_FILE}
bitbake -c cleansstate ${BB_PROJECT} 2>&1 | ${TEE_LOG}
if [ $? -ne 0 ] ; then 
    echo "ERROR: bitbake -c cleansstate ${BB_PROJECT} failed!"
    exit 1
fi 
#
~/sh-bitbake/bb-diag.sh

