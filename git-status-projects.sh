#!/bin/bash
#
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

DIR_BASE="SonicCoreX"
pushd . >/dev/null
source cdjump "${DIR_BASE}" "${DIR_BASE}/projects"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump %s failed!\n" "${DIR_BASE}"
    popd >/dev/null
    exit 1 
fi 

${BB_DIR}/git-status-all.sh 
popd >/dev/null


