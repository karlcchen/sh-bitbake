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

DIR_LIST="`${BB_DIR}/git-dirs.sh`"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: ${BB_DIR}/git-dirs.sh %s failed!\n" "${1}"
    exit 2
fi 

# for debug only 
#echo 
#printf "DEBUG: DIR_LIST:%s\n" "${DIR_LIST}"
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
        printf "\n ERROR: #%d, cd %s failed!\n" ${N_COUNT} "${dir_name}"
        exit 3 
    fi 
    GIT_STATUS="`git status`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git status\" failed at DIR: %s\n" ${N_COUNT} "${dir_name}"
        exit 4 
    fi 
    printf "\n=== #%d, DIR %s ===\n" ${N_COUNT} "${dir_name}"
    echo "${GIT_STATUS}"               
    N_FOUND=$((N_FOUND+1))
    popd >/dev/null
done

printf "\n=====  git-status-all.sh DONE  =====\n"
printf " %d git dir found\n\n" ${N_FOUND}
