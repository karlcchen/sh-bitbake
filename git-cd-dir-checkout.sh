#!/bin/bash
#
# git-cd-dir-checkout.sh
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

source ${BB_DIR}/cdjump.sh "SonicCoreX" "$1"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump \"%s\" failed!" "$1"
    exit 1 
fi 
git checkout $2
if [ $? -ne 0 ] ; then 
    printf "\nERROR: it checkout %s failed!" "$2"
    exit 2 
fi
