#!/bin/bash
#
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"
LOOK_FOR_STR1="modified:"
LOOK_FOR_STR2="on branch"

if [ ! "${1}" = "" ] ; then 
    cd $1
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: cd \"%s\" failed!\n" "${1}"
        exit 1
    fi 
fi 

DIR_LIST="`${BB_DIR}/git-dirs.sh`"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: ${BB_DIR}/git-dirs.sh \"%s\" failed!\n" "${1}"
    exit 2
fi 

# for debug only 
#echo 
#echo "${DIR_LIST}"
#echo 
#
N_COUNT=0
N_FOUND=0
for dir_name in ${DIR_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${dir_name} 
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd \"%s\" failed!\n" ${N_COUNT} "${dir_name}"
        exit 3 
    fi 
    GIT_STATUS="`git status`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git status\" failed at DIR: \"%s\"\n" ${N_COUNT} "${dir_name}"
        exit 4 
    fi 
    echo "${GIT_STATUS}" | grep "${LOOK_FOR_STR1}" >/dev/null
    if [ $? -eq 0 ] ; then 
        printf "\n=== #%d, git DIR \"%s\", search \"%s\" ===\n" ${N_COUNT} "${dir_name}" "${LOOK_FOR_STR1}"
        echo "${GIT_STATUS}"               
        N_FOUND=$((N_FOUND+1))
    else 
        echo "${GIT_STATUS}" | grep "${LOOK_FOR_STR2}" >/dev/null
        if [ $? -eq 0 ] ; then 
            printf "\n=== #%d, git DIR \"%s\", search \"%s\" ===\n" ${N_COUNT} "${dir_name}" "${LOOK_FOR_STR2}"
            echo "${GIT_STATUS}"               
            N_FOUND=$((N_FOUND+1))
        fi 
    fi 
    popd >/dev/null
done

printf "\n=====  %s DONE  =====\n" "$0"
printf "INFO: git status, %d found out of %d directories, searching: \"%s\" \"%s\" \n\n" ${N_FOUND} ${N_COUNT} "${LOOK_FOR_STR1}" "${LOOK_FOR_STR2}"
