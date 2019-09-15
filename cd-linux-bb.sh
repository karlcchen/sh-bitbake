#
# cd-diag.sh
#
# source this from working directory to go to recipes-diag
#
if [ -d ./SonicCoreX ] ; then 
    cd ./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/soniccorex-core/meta/recipes-kernel/linux
elif [ -d ./projects ] ; then 
    cd ./projects/lithium/sonicgit/soniccore/componentsx/soniccorex-core/meta/recipes-kernel/linux
elif [ -d ./lithium ] ; then 
    cd ./lithium/sonicgit/soniccore/componentsx/soniccorex-core/meta/recipes-kernel/linux
elif [ -d ./sonicgit ] ; then 
    cd ./sonicgit/soniccore/componentsx/soniccorex-core/meta/recipes-kernel/linux
elif [ -d ./soniccore ] ; then 
    cd ./soniccore/componentsx/soniccorex-core/meta/recipes-kernel/linux
elif [ -d ./componentsx ] ; then 
    cd ./componentsx/soniccorex-core/meta/recipes-kernel/linux
elif [ -d ./soniccorex-core ] ; then 
    cd ./soniccorex-core/meta/recipes-kernel/linux
elif [ -d ./meta ] ; then 
    cd ./meta/recipes-kernel/linux
elif [ -d ./recipes-kernel ] ; then 
    cd ./recipes-kernel/linux
elif [ -d ./linux ] ; then 
    cd ./linux
else 
    echo -e "ERROR: cannot cd to dir of 'linux bb' dir"
    exit 1
fi



