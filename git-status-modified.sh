#!/bin/bash
#
#

b_REALPATH=0 
BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

# default search list 
SEARCH_LIST="^Changes"   

source "${BB_DIR}/src-setup-project-dir-list.sh"
if [ $? -ne 0 ] ; then 
    exit 1
fi 

if [ ! "${2}" = "" ] ; then 
    SEARCH_LIST="${2}"
    printf "\nINFO: use Custom Search List: \"%s\"\n" "${SEARCH_LIST}"
fi 

# for debug only 
#echo 
#echo "${DIR_LIST}"
#echo 
#
N_COUNT=0
N_STASH=0
N_FOUND=0
N_BRANCH=0
for dir_name in ${DIR_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${dir_name} 
#
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR3: #%d, cd \"%s\" failed!\n" ${N_COUNT} "${dir_name}"
        popd >/dev/null
        exit 3 
    fi 
#
    GIT_STATUS="`git status`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR4: #%d, \"git status\" failed at DIR: \"%s\"\n" ${N_COUNT} "${dir_name}"
        popd >/dev/null
        exit 4 
    fi 
#
    GIT_BRANCH="`git branch | grep '*'`"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR5: #%d, \"git branch\" failed at DIR: \"%s\"\n" ${N_COUNT} "${dir_name}"
        popd >/dev/null
        exit 5 
    fi 
#
    if [ "${GIT_BRANCH}" != '* (no branch)' ] ; then 
        N_BRANCH=$((N_BRANCH+1))
        printf "\n=== Dir#%02d: %s\n" ${N_COUNT} "${dir_name}" 
        printf " found Branch#%02d: %s\n" ${N_BRANCH} "${GIT_BRANCH}"
    fi 
#
    GIT_STASH="`git stash list`"
    if [ "${GIT_STASH}" != "" ] ; then 
        N_STASH=$((N_STASH+1))
        printf "\n=== Stash_Dir#%02d: %s\n" ${N_STASH} "${dir_name}" 
        printf " found GIT_stash_list: %s\n" "${GIT_STASH}"
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
            printf "\n=== #%02d, git branch: %s\n" ${N_FOUND}  "${GIT_BRANCH}"
            printf " Dir#%02d: %s \tSearching#%d: \"%s\"\n" ${N_COUNT} "${dir_name}" ${N_SEARCH} "${search_str}"
            echo "${GIT_STATUS}"               
        fi
    done 
#
    popd >/dev/null
done

printf "\n### Done Info: git status, %d \"%s\" found out of %d Directories\n\n" ${N_FOUND} "${SEARCH_LIST}" ${N_COUNT}  
