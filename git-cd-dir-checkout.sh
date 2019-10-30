#!/bin/bash
#
#

source ./cdjump "SonicCoreX" "$1"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump \"%s\" failed!" "$1"
    exit 1 
fi 
git checkout $2
if [ $? -ne 0 ] ; then 
    printf "\nERROR: it checkout %s failed!" "$2"
    exit 2 
fi 

