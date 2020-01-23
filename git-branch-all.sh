#!/bin/bash
#
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

echo
echo "BB_DIR=${BB_DIR}" 
echo

export BB_DIR

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
echo 
echo "${CD_LIST}"
echo 
#
N_COUNT=0
for cd_name in ${CD_LIST}
do 
    N_COUNT=$((N_COUNT+1))
    pushd . >/dev/null
    cd ${cd_name} 
    if [ $? -ne 0 ] ; then 
        printf "\n ERROR: #%d, cd %s failed!\n" ${N_COUNT} "${cd_name}"
        exit 3 
    fi 
    CUR_DIR="`pwd`"
    printf "%d %s\n" "${N_COUNT}" "${CUR_DIR}"
    git branch
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: #%d, \"git branch\" failed at DIR: %s\n" ${N_COUNT} "${cd_name}"
        exit 4 
    fi 
    popd >/dev/null
done

printf "\n=====  git-version-all.sh DONE  =====\n"
ls -l prj*.txt
