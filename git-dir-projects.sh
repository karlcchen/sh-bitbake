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

source "${BB_DIR}/src-setup-project-dir-list.sh"
if [ $? -ne 0 ] ; then 
    exit 1
fi 

printf "%s\n" "${DIR_LIST}"

popd >/dev/null


