#!/bin/bash
#
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

DIR_BASE="SonicCoreX"
JUMP_TO_DIR="projects"

pushd . >/dev/null
source cdjump "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump from %s to %s failed!\n" "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
    popd >/dev/null
    exit 1 
fi 

${BB_DIR}/git-status-modified.sh 
popd >/dev/null


