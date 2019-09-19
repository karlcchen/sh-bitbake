#!/bin/bash
#
#
DIR_BASE="SonicCoreX"
source cdjump "${DIR_BASE}" "${DIR_BASE}/projects"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump %s failed!\n" "${DIR_BASE}"
    exit 1 
fi 

# remove ".git" at ned of pathname
CD_LIST=`dname ".git" | sed "s/\.git//g"`

# for debug only 
#echo 
#echo "${CD_LIST}"
#echo 
#
N_COUNT=0
for cd_name in ${CD_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${cd_name} 
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd %s failed!\n" ${N_COUNT} "${cd_name}"
        exit 2 
    fi 
    GIT_STATUS="`git status`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git status\" failed at DIR: %s\n" ${N_COUNT} "${cd_name}"
        exit 3 
    fi 
    echo "${GIT_STATUS}" | grep "modified" >/dev/null
    if [ $? -eq 0 ] ; then 
        printf "\n=== #%d, DIR %s ===\n" ${N_COUNT} "${cd_name}"
        echo "${GIT_STATUS}"               
    fi 
    popd >/dev/null
done
