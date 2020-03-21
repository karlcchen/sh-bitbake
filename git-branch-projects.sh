#!/bin/bash
#
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"
USE_ABS_DIR_NAME=1

b_REALPATH=0
#echo
#echo "BB_DIR=${BB_DIR}" 
#echo

export BB_DIR

DIR_BASE="SonicCoreX"
JUMP_TO_DIR="${DIR_BASE}/projects"

pushd . >/dev/null

source ~/bin/cdjump "${DIR_BASE}" "${JUMP_TO_DIR}"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump from %s to %s failed!\n" "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
    popd >/dev/null
    exit 1 
fi 

source "${BB_DIR}/src-setup-project-dir-list.sh"
if [ $? -ne 0 ] ; then 
    exit 1
fi 

# for debug only 
#echo 
#echo "${DIR_LIST}"
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

    GIT_BRANCH=`git branch | grep '*'` 
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git branch\" failed at DIR: %s\n" ${N_COUNT} "${dir_name}"
        exit 4 
    fi 
#
    if [ "${GIT_BRANCH}" != '* (no branch)' ] ; then 
        N_BRANCH=$((N_BRANCH+1))
        if [ ${USE_ABS_DIR_NAME} -ne 0 ] ; then  
            printf "%s %02d %02d\n" "${CUR_DIR}" ${N_BRANCH} ${N_COUNT} 
        else 
            printf "%s %02d %02d\n" "${dir_name}" ${N_BRANCH} ${N_COUNT} 
        fi 
        printf "%s\n"  "${GIT_BRANCH}"
    fi 
    popd >/dev/null
done
echo 


