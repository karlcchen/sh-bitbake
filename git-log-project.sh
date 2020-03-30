#!/bin/bash
#
#

b_REALPATH=0 
BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

DIR_BASE="SonicCoreX"
JUMP_TO_DIR="${DIR_BASE}/projects"
SEARCH_LIST="^commit ^Author: ^Date:"

HEAD_LINES="1"
TAIL_LINES="1"

# -------------------------------------------------------------------------------------
pushd . >/dev/null
source ~/bin/cdjump "${DIR_BASE}" "${JUMP_TO_DIR}"
#source ~/bin/cdjump "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
if [ $? -ne 0 ] ; then 
    printf "\nERROR1: cdjump from %s to %s failed!\n" "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
    popd >/dev/null
    exit 1 
fi 

source "${BB_DIR}/src-setup-project-dir-list.sh"
if [ $? -ne 0 ] ; then 
    exit 1
fi 

# ------------------------------------------------------------------------------------
if [ ! "$1" = "" ] ; then 
    HEAD_LINES="$1"
    TAIL_LINES="$1"
fi 
if [ ! "$2" = "" ] ; then 
    TAIL_LINES="$2"
fi 
if [ ! "$3" = "" ] ; then 
    SEARCH_LIST="$3"
fi 

#
DIR_LIST2="`echo "${DIR_LIST}" | tr '\n' ' '`"
#
GIT_CMD="`echo $4 | tr -d ' '`"
N_COUNT=0
for dir_name in ${DIR_LIST2}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${dir_name}
    if [ $? -ne 0 ] ; then 
        printf "\nERROR2: cd %s failed!\n" "${dir_name}"
        popd >/dev/null
        popd >/dev/null
        exit 2 
    fi 
    GIT_LOG="`git log`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR3: git log failed!\n" 
        popd >/dev/null
        popd >/dev/null
        exit 3 
    fi 
    N_FOUND=0 
    for srh_str in ${SEARCH_LIST}
    do 
        FOUND_STR=`echo "${GIT_LOG}" | grep "${srh_str}" | head -n ${HEAD_LINES} | tail -n ${TAIL_LINES}` 
        if [ $? -ne 0 ] ; then 
            printf "\nERROR4: git log failed!\n" 
            popd >/dev/null
            popd >/dev/null
            exit 4 
        fi 
        if [ ! "${FOUND_STR}" = "" ] ; then 
            N_FOUND=$((N_FOUND+1))
            printf "#%d %s" ${N_COUNT} "${FOUND_STR}" 
            if [ ${N_FOUND} -eq 1 ] ; then 
                printf "\t%s\n" ${dir_name}
            else
                echo
            fi 
        fi
    done 
    if [ ! "$4" = "" ] ; then 
        printf "pushd . >/dev/null\n" 
        printf "cd %s\n" "${dir_name}"
#
        printf "if [ \$\? -ne 0 ] ; then\n" 
        printf "\t echo ERROR1-%d\n" ${N_COUNT}
        printf "\t exit %d\n" ${N_COUNT}
        printf "fi\n"
#
        if [ ! "${GIT_CMD}" = "" ] ; then 
            ARG1="`echo ${GIT_LOG_STR} | awk '{print $2}'`" 
            printf "%s %s\n" "$4" "${ARG1}"
            printf "if [ \$\? -ne 0 ] ; then\n" 
            printf "\t echo ERROR2-%d\n" ${N_COUNT}
            printf "\t exit %d\n" ${N_COUNT}
            printf "fi\n"
        fi 
        printf "popd >/dev/null\n" 
    fi 
    popd >/dev/null
    echo
done 
#
popd >/dev/null
