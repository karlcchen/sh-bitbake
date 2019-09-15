#
# cd-diag.sh
#
# source this from working directory to go to recipes-diag
#
if [ -d ./SonicCoreX ] ; then 
    cd ./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/soniccorex-core
elif [ -d ./projects ] ; then 
    cd ./projects/lithium/sonicgit/soniccore/componentsx/soniccorex-core
elif [ -d ./lithium ] ; then 
    cd ./lithium/sonicgit/soniccore/componentsx/soniccorex-core
elif [ -d ./sonicgit ] ; then 
    cd ./sonicgit/soniccore/componentsx/soniccorex-core
elif [ -d ./soniccore ] ; then 
    cd ./soniccore/componentsx/soniccorex-core
elif [ -d ./componentsx ] ; then 
    cd ./componentsx/soniccorex-core
elif [ -d ./soniccorex-core ] ; then 
    cd ./soniccorex-core
else 
    echo -e "cannot cd to the \'soniccorex-core\' dir"
    exit 1
fi

