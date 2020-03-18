#!/bin/bash 
#
#
 
N_LOOPS=0
while [ ! "$1" = "" ] ; 
do  
    N_LOOPS=$((N_LOOPS+1))
    source cdjump "SonicCoreX" "$1"
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: loop=%d, cd-loop.sh %s failed!" ${N_LOOPS} "$1"
        exit 1 
    fi 
    PWD=`pwd`
    COMMIT_ID=`git rev-parse HEAD`
#    printf "LOOP=%2d, PWD=%s\n" ${N_LOOPS} "${PWD}"
    printf "./git-checkout-commit-id.sh %s %s\n" "$1" "${COMMIT_ID}"
    printf "if [ $? -ne 0 ] ; then\n" "$1" 
    printf "\t echo \"at %s, git-checkout-commit-id.sh failed!\"\n" "$1"
    printf "\t exit %d\n" "${N_LOOPS}" 
    printf "fi\n\n"
    shift 1 
done 
