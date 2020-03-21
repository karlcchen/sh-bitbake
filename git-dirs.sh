#!/bin/bash
#
# git-dirs.sh
#

b_REALPATH=1

if [ "${1}" = "--rpath" ] ; then 
    b_REALPATH=0
    shift 1
fi 

if [ "${1}" = "--apath" ] ; then 
    b_REALPATH=1
    shift 1
fi 

if [ ! "${1}" = "" ] ; then 
    cd $1
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: cd \"%s\" failed!\n" "${1}"
        exit 1
    fi 
fi 

if [ ${b_REALPATH} -eq 0 ] ; then 
    dname-rpath ".git" | sed "s/\.git//g"
else
    dname ".git" | sed "s/\.git//g"
fi
