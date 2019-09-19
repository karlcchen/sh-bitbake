#!/bin/bash
#
#
DIR_BASE="SonicCoreX"
pushd . >/dev/null
source cdjump "${DIR_BASE}" "${DIR_BASE}/projects"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump %s failed!\n" "${DIR_BASE}"
    popd >/dev/null
    exit 1 
fi 

~/sh-bitbake/git-status-all.sh 
popd >/dev/null


