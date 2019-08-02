#!/bin/bash
#
# run from ./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp
#
git pull sonicgit WIP/soniccorex/lithium/sonicos/6.5.4/dev
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'git pull sonicgit WIP/soniccorex/lithium/sonicos/6.5.4/dev' failed "\n
    echo -e "\nTIPS: you should run this from ./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp\n" 
    exit 1
fi 
