#!/bin/bash
#
# run from ./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp
#
BASE_DIR1="./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp"
BASE_DIR2="./SonicCoreX/projects/lithium/sonicgit/bsp/vendor-sdk/Marvell/UMSD"
DEV_BRANCH="WIP/soniccorex/lithium/sonicos/6.5.4/dev"

pushd .
cd ${BASE_DIR1}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'cd ${BASE_DIR1}' faied!\n"
    exit 1
fi 
echo -e "\nINFO: git pull from `pwd`\n"
git pull --rebase sonicgit ${DEV_BRANCH}
if [ $? -ne 0 ] ; then 
    pwd
    echo -e "\nERROR: 'git pull --rebase sonicgit ${DEV_BRANCH}' failed!\n"
    echo -e "\nTIPS: you should run this from ${BASE_DIR1}\n" 
    exit 2
fi 
popd
#
#
pushd .
cd ${BASE_DIR2}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'cd ${BASE_DIR2}' faied!\n"
    exit 3
fi 
echo -e "\nINFO: git pull from `pwd`\n"
git pull --rebase sonicgit ${DEV_BRANCH}
if [ $? -ne 0 ] ; then 
    pwd
    echo -e "\nERROR: 'git pull --rebase sonicgit ${DEV_BRANCH}' failed!\n"
    echo -e "\nTIPS: you should run this from ${BASE_DIR2}\n" 
    exit 4
fi 
popd

