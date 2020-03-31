#!/bin/bash

GITLAB_KCHEN="git@sonicgit.eng.sonicwall.com:kchen"

if [ "$1" = "" ] ; then 
    printf "\n=== clone gitlab project from %s\n" "${GITLAB_KCHEN}"		
    printf "\n please input gitlab project name:\n"
    exit 1
else
    git clone "${GITLAB_KCHEN}/$1.git"
fi
