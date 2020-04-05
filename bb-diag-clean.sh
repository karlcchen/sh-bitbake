#!/bin/bash
#

if [ "$1" == "" ] ; then 
    BUILD_CONF="standard"
else
    BUILD_CONF="${1}"
    shift 1
fi 

LOG_FILE="diag-${BUILD_CONF}-clean-sstate.log"
TEE_LOG="tee --append ${LOG_FILE}"
rm -f ${LOG_FILE}
bitbake -c cleansstate diag-${BUILD_CONF} 2>&1 | ${TEE_LOG}
if [ $? -ne 0 ] ; then 
    echo "ERROR1: bitbake -c cleansstate diag-%s failed!" "${BUILD_CONF}"
    exit 1
fi 
bitbake -c cleanall diag-${BUILD_CONF} 2>&1 | ${TEE_LOG}
if [ $? -ne 0 ] ; then 
    echo "ERROR2: bitbake -c cleanall diag-%s failed!" "${BUILD_CONF}"
    exit 2
fi 
