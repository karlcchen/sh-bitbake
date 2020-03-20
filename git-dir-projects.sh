#!/bin/bash
#
#

b_REALPATH=1 
BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

DIR_BASE="SonicCoreX"
JUMP_TO_DIR="${DIR_BASE}/projects"

pushd . >/dev/null

source ~/bin/cdjump "${DIR_BASE}" "${JUMP_TO_DIR}"
#source ~/bin/cdjump "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump from %s to %s failed!\n" "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
    popd >/dev/null
    exit 1 
fi 

if [ ${b_REALPATH} -eq 0 ] ; then 
    ${BB_DIR}/git-dirs.sh
else
    ${BB_DIR}/git-dirs.sh | xargs realpath
fi 
popd >/dev/null


