#!/bin/bash
#
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

if [ ! "${1}" = "" ] ; then 
    cd $1
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: cd \"%s\" failed!\n" "${1}"
        exit 1
    fi 
fi 

CD_LIST="`${BB_DIR}/git-dirs.sh`"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: ${BB_DIR}/git-dirs.sh %s failed!\n" "${1}"
    exit 2
fi 

# for debug only 
#echo 
#echo "${CD_LIST}"
#echo 
#
N_COUNT=0
N_FOUND=0
for cd_name in ${CD_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${cd_name} 
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd %s failed!\n" ${N_COUNT} "${cd_name}"
        exit 3 
    fi 
    GIT_STATUS="`git status`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git status\" failed at DIR: %s\n" ${N_COUNT} "${cd_name}"
        exit 4 
    fi 
    echo "${GIT_STATUS}" | grep "modified" >/dev/null
    if [ $? -eq 0 ] ; then 
        printf "\n=== #%d, DIR %s ===\n" ${N_COUNT} "${cd_name}"
        echo "${GIT_STATUS}"               
        N_FOUND=$((N_FOUND+1))
    fi 
    popd >/dev/null
done

printf "\n=====  git-status-all.sh DONE  =====\n"
printf " %d modified git repo found\n\n" ${N_FOUND}
