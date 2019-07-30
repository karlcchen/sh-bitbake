#
# cd-diag.sh
#
# source this from working directory to go to recipes-diag
#
if [ -d ./SonicCoreX ] ; then 
    cd ./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp/recipes-diag
elif [ -d ./projects ] ; then 
    cd ./projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp/recipes-diag
elif [ -d ./lithium ] ; then 
    cd ./lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp/recipes-diag
elif [ -d ./sonicgit ] ; then 
    cd ./sonicgit/soniccore/componentsx/meta-soniccorex-bsp/recipes-diag
elif [ -d ./soniccore ] ; then 
    cd ./soniccore/componentsx/meta-soniccorex-bsp/recipes-diag
elif [ -d ./componentsx ] ; then 
    cd ./componentsx/meta-soniccorex-bsp/recipes-diag
elif [ -d ./meta-soniccorex-bsp ] ; then 
    cd ./meta-soniccorex-bsp/recipes-diag
elif [ -d ./recipes-diag ] ; then 
    cd ./recipes-diag
else 
    echo "ERROR: cannot cd to diag, not in known path!"
    # do not do 'exit', as this file is "sourced"!      
fi 

