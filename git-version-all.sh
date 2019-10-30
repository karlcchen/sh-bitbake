#!/bin/bash
#
#

if [ ! "${1}" = "" ] ; then 
    cd $1
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: cd \"%s\" failed!\n" "${1}"
        exit 1
    fi 
fi 

CD_LIST="`~/sh-bitbake/git-dirs.sh`"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: ~/sh-bitbake/git-dirs.sh %s failed!\n" "${1}"
    exit 2
fi 

# for debug only 
#echo 
#echo "${CD_LIST}"
#echo 
#
N_COUNT=0
CUR_DIR="`pwd`"
COMMIT_VER_ID_FNAME="${CUR_DIR}/prj-ver-id.txt"
COMMIT_BRANCH_FNAME="${CUR_DIR}/prj-branch.txt"
rm -f ${COMMIT_VER_ID_FNAME}
rm -f ${COMMIT_BRANCH_FNAME}
for cd_name in ${CD_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${cd_name} 
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd %s failed!\n" ${N_COUNT} "${cd_name}"
        exit 3 
    fi 
    GIT_COMMIT_ID="`git log --decorate=short -p -1 | head -n1 | awk '{print $2 }'`"
    GIT_COMMIT_BRANCH="`git log --decorate=short -p -1 | head -n1 | awk '{print $4}' | sed s/\,//g`"
    if [ "${GIT_COMMIT_ID}" = "->" ] ; then 
        GIT_COMMIT_ID="`git log --decorate=short -p -1 | head -n1 | awk '{print $3 }'`"
        GIT_COMMIT_BRANCH="`git log --decorate=short -p -1 | head -n1 | awk '{print $5}' | sed s/\,//g`"
    fi 
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git log -p -1 | grep commit\" failed at DIR: %s\n" ${N_COUNT} "${cd_name}"
        exit 4 
    fi 
    printf "%d %s %s %s\n" ${N_COUNT} "${cd_name}" "${GIT_COMMIT_ID}" "${GIT_COMMIT_BRANCH}"
    printf "%s %s\n" "${cd_name}" "${GIT_COMMIT_ID}"     >>${COMMIT_VER_ID_FNAME}
    printf "%s %s\n" "${cd_name}" "${GIT_COMMIT_BRANCH}" >>${COMMIT_BRANCH_FNAME}
    popd >/dev/null
done

printf "\n=====  git-version-all.sh DONE  =====\n"
ls -l prj*.txt
