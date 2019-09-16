#!/bin/bash
# 'source'd file, not for shell exec
#
# setup-diag-anderson-peak.sh
#

if [ "$1" == "" ] ; then 
    printf "\nERROR: need machine name as first argument\n"
    printf "\nFor example: \n\t ./setup-diag.sh anderson-peak\n\n"
    exit 1
fi 

export BUILD_MACHINE="$1"
# 
# remove the argument to avoid source taking it, IF PASSED AS ARGUMENT
shift 1
export BUILD_TARGET="diag"
#source ~/sh-bitbake/setup-build.sh ${BUILD_MACHINE} ${BUILD_TARGET}
source ~/sh-bitbake/setup-build.sh 

