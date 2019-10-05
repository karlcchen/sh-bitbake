#!/bin/bash
#
# 1. create a new local branch 
# 2. push it to remote repo
#
git checkout -b "$1"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: git checkout -b %s\n" "$1"
    exit 1
fi 
git push -u origin "$1"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: git push -u origin %s\n" "$1"
    exit 2
fi 

