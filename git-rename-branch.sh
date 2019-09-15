#!/bin/bash
#
# rename branch name 
OLD_BRAHCN="${1}"
NEW_BRANCH="${2}"
#
git checkout ${OLD_BRAHCN}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git checkout ${OLD_BRAHCN} failed!" 
    exit 1
fi 
git branch -m ${NEW_BRAHCN}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git branch -m ${NEW_BRAHCN}"
    exit 2
fi 
git push origin --delete ${OLD_BRAHCN}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git push origin --delete ${OLD_BRAHCN}"
    exit 3
fi 
git push origin -u ${NEW_BRAHCN}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git push origin -u ${NEW_BRAHCN}"
    exit 4
fi 

echo "\n rename branch completed!"
echo "\n new branch name is:"
git branch
