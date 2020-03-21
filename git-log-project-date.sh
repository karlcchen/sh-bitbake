#!/bin/bash
#
#

b_REALPATH=1 
BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

DIR_BASE="SonicCoreX"
JUMP_TO_DIR="${DIR_BASE}/projects"
SEARCH_STR="^Date"

HEAD_LINES="5"
TAIL_LINES="5"
pushd . >/dev/null

if [ ! "$1" = "" ] ; then 
    HEAD_LINES="$1"
    TAIL_LINES="$1"
fi 
if [ ! "$2" = "" ] ; then 
    TAIL_LINES="$2"
fi 
#
source ~/bin/cdjump "${DIR_BASE}" "${JUMP_TO_DIR}"
#source ~/bin/cdjump "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
if [ $? -ne 0 ] ; then 
    printf "\nERROR1: cdjump from %s to %s failed!\n" "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
    popd >/dev/null
    exit 1 
fi 

if [ ${b_REALPATH} -eq 0 ] ; then 
    DIR_LIST=`${BB_DIR}/git-dirs.sh`
else
    DIR_LIST=`${BB_DIR}/git-dirs.sh | xargs realpath`
fi 
#
DIR_LIST2="`echo "${DIR_LIST}" | tr '\n' ' '`"
#
for dir_name in ${DIR_LIST2}
do 
    pushd . >/dev/null
    cd ${dir_name}
    if [ $? -ne 0 ] ; then 
        printf "\nERROR2: cd %s failed!\n" "${dir_name}"
        popd >/dev/null
        popd >/dev/null
        exit 2 
    fi 
    DATE_STR=`git log | grep "${SEARCH_STR}" | head -n ${HEAD_LINES} | tail -n ${TAIL_LINES}` 
    if [ $? -ne 0 ] ; then 
        printf "\nERROR3: git log failed!\n" 
        popd >/dev/null
        popd >/dev/null
        exit 3 
    fi 
    printf "%s \t%s\n" "${DATE_STR}" "${dir_name}"
    popd >/dev/null
    echo
done 
#
popd >/dev/null
