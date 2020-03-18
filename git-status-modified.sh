#!/bin/bash
#
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

SEARCH_LIST="^Changes"   

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
N_BRANCH=0
for dir_name in ${DIR_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${dir_name} 
#
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd \"%s\" failed!\n" ${N_COUNT} "${dir_name}"
        popd >/dev/null
        exit 3 
    fi 
#
    GIT_STATUS="`git status`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git status\" failed at DIR: \"%s\"\n" ${N_COUNT} "${dir_name}"
        popd >/dev/null
        exit 4 
    fi 
#
    GIT_BRANCH="`git branch | grep '*'`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git branch\" failed at DIR: \"%s\"\n" ${N_COUNT} "${dir_name}"
        popd >/dev/null
        exit 5 
    fi 
#
    if [ "${GIT_BRANCH}" != '* (no branch)' ] ; then 
        N_BRANCH=$((N_BRANCH+1))
        printf "\n=== Dir#%d:\"%s\"\n" ${N_COUNT} "${dir_name}" 
        printf " found Branch#%d: \"%s\"\n" ${N_BRANCH} "${GIT_BRANCH}"
    fi 
#
    N_SEARCH=0
    for search_str in ${SEARCH_LIST}
    do 
        N_SEARCH=$((N_SEARCH+1))
        echo "${GIT_STATUS}" | grep "${search_str}" >/dev/null
        if [ $? -eq 0 ] ; then 
            N_FOUND=$((N_FOUND+1))
            GIT_BRANCH="`git branch | grep '\*'`"
            printf "\n=== #%d, git branch: \"%s\"\n" ${N_FOUND}  "${GIT_BRANCH}"
            printf " Dir#%d:\"%s\", Searching#%d: \"%s\"\n" ${N_COUNT} "${dir_name}" ${N_SEARCH} "${search_str}"
            echo "${GIT_STATUS}"               
        fi
    done 
#
    popd >/dev/null
done

printf "\n### Done Info: git status, %d found out of %d Directories, Searching:\"%s\"\n\n" ${N_FOUND} ${N_COUNT} "${SEARCH_LIST}" 
