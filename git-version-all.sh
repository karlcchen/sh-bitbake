#!/bin/bash
#
# git-version-all.sh
#

b_REALPATH=0 

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

source "${BB_DIR}/src-setup-project-dir-list.sh"
if [ $? -ne 0 ] ; then 
    exit 1
fi 

PRJ_NAME="`${BB_DIR}/get-prj-name.sh`"

# for debug only 
#echo 
#echo "${DIR_LIST}"
#echo 
#

N_COUNT=0
CUR_DIR="`pwd`"
COMMIT_VER_ID_FNAME="${CUR_DIR}/prj-ver-id-${PRJ_NAME}.txt"
COMMIT_BRANCH_FNAME="${CUR_DIR}/prj-branch-${PRJ_NAME}.txt"
rm -f ${COMMIT_VER_ID_FNAME}
rm -f ${COMMIT_BRANCH_FNAME}
for cd_name in ${DIR_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${cd_name} 
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd %s failed!\n" ${N_COUNT} "${cd_name}"
        exit 3 
    fi 
    GIT_LOG="`git log --decorate=short -p -1`" 
    GIT_COMMIT_ID="`echo "${GIT_LOG}" | head -n1 | awk '{print $2 }'`"
    GIT_COMMIT_BRANCH="`echo "${GIT_LOG}" | head -n1 | awk '{print $4}' | sed s/\,//g`"
    if [ "${GIT_COMMIT_BRANCH}" = "->" ] ; then 
        GIT_COMMIT_BRANCH="`echo "${GIT_LOG}" | head -n1 | awk '{print $5}' | sed s/\,//g`"
        printf "* "
    fi 
    printf "%02d\t%s\t%s\t\t%s\n" ${N_COUNT} "${GIT_COMMIT_ID}" "${cd_name}" "${GIT_COMMIT_BRANCH}"
    printf "%s %s\n" "${cd_name}" "${GIT_COMMIT_ID}"     >>${COMMIT_VER_ID_FNAME}
    printf "%s %s\n" "${cd_name}" "${GIT_COMMIT_BRANCH}" >>${COMMIT_BRANCH_FNAME}
    popd >/dev/null
done

rm -f ${COMMIT_VER_ID_FNAME}.srt ${COMMIT_BRANCH_FNAME}.srt
cat ${COMMIT_VER_ID_FNAME} | sort > ${COMMIT_VER_ID_FNAME}.srt
cat ${COMMIT_BRANCH_FNAME} | sort > ${COMMIT_BRANCH_FNAME}.srt

printf "\n=====  git-version-all.sh DONE  =====\n"
ls -l prj-*
