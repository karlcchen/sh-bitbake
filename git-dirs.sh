#!/bin/bash
#
# git-dirs.sh
#

if [ ! "${1}" = "" ] ; then 
    cd $1
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: cd \"%s\" failed!\n" "${1}"
        exit 1
    fi 
fi 

dname ".git" | sed "s/\.git//g"

