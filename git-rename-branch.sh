#!/bin/bash
#
# rename a branch name 
#
# Renaming a local Git Branch is just a matter of one command. 
# However you can’t directly rename a remote branch, 
# you need to delete it and then re-push the renamed local branch.
#

OLD_BRANCN="${1}"
NEW_BRANCH="${2}"
GIT_REMOTE="sonicgit"
#
git checkout ${OLD_BRANCH}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git checkout ${OLD_BRANCN} failed!" 
    exit 1
fi 
git branch -m ${NEW_BRANCH}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git branch -m ${NEW_BRANCN}"
    exit 2
fi 
git push ${GIT_REMOTE} --delete ${OLD_BRANCN}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git push origin --delete ${OLD_BRANCN}"
    exit 3
fi 
git push ${GIT_REMOTE} -u ${NEW_BRANCN}
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: git push origin -u ${NEW_BRANCN}"
    exit 4
fi 

echo "\n rename branch completed!"
echo "\n new branch name is:"
git branch
