#!/bin/bash
BASE_DIR="SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp"
DEV_BRANCH="remotes/m/WIP/soniccorex/lithium/sonicos/6.5.4/dev"
cd ${BASE_DIR}
if [ $? -ne 0 ] ; then 
    echo "ERROR: 'cd ${BASE_DIR}' faied!"
    exit 1
fi 
git checkout --track ${DEV_BRANCH}
if [ $? -ne 0 ] ; then 
    echo "ERROR: 'git checkout --track ${DEV_BRANCH}' failed"
    exit 2
fi 

