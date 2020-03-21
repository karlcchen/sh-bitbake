#!/bin/bash
#
#

USE_ABS_DIR_NAME=1

b_REALPATH=0
BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

#echo
#echo "BB_DIR=${BB_DIR}" 
#echo

export BB_DIR
source "${BB_DIR}/src-setup-project-dir-list.sh"
if [ $? -ne 0 ] ; then 
    exit 1
fi 

# for debug only 
#echo 
#echo "${CD_LIST}"
#echo 
#
echo
N_COUNT=0
for dir_name in ${DIR_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${dir_name} 
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd %s failed!\n" ${N_COUNT} "${dir_name}"
        exit 3 
    fi 
    CUR_DIR="`pwd`"

    if [ ${USE_ABS_DIR_NAME} -ne 0 ] ; then  
        printf "%s %02d\n" "${CUR_DIR}" ${N_COUNT} 
    else 
        printf "%s %02d\n" "${dir_name}" ${N_COUNT} 
    fi 

    GIT_BRANCH=`git branch | grep '*'` 
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git branch\" failed at DIR: %s\n" ${N_COUNT} "${dir_name}"
        exit 4 
    fi 
#
    if [ "${GIT_BRANCH}" != '* (no branch)' ] ; then 
        N_BRANCH=$((N_BRANCH+1))
        git branch
        if [ $? -ne 0 ] ; then 
            printf "\nERROR: #%d, \"git branch\" failed at DIR: %s\n" ${N_COUNT} "${dir_name}"
            exit 4 
        fi 
    fi 
    popd >/dev/null
done
echo
