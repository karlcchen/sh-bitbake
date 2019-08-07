#!/bin/bash
BASE_DIR1="SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp"
BASE_DIR2="SonicCoreX/projects/lithium/sonicgit/bsp/vendor-sdk/Marvell/UMSD"
REMOTE_DEV_BRANCH="remotes/m/WIP/soniccorex/lithium/sonicos/6.5.4/dev"

pushd .
cd ${BASE_DIR1}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'cd ${BASE_DIR1}' faied!\n"
    exit 1
fi 
git checkout --track ${REMOTE_DEV_BRANCH}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'git checkout --track ${REMOTE_DEV_BRANCH}' failed~\n"
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
git checkout --track ${REMOTE_DEV_BRANCH}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'git checkout --track ${REMOTE_DEV_BRANCH}' failed!\n"
    exit 4
fi
popd

