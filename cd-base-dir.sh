#
# cd-diag.sh
#
# source this from working directory to go to recipes-diag
#
if [ -d ./SonicCoreX ] ; then 
    cd ./SonicCoreX/projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp
elif [ -d ./projects ] ; then 
    cd ./projects/lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp
elif [ -d ./lithium ] ; then 
    cd ./lithium/sonicgit/soniccore/componentsx/meta-soniccorex-bsp
elif [ -d ./sonicgit ] ; then 
    cd ./sonicgit/soniccore/componentsx/meta-soniccorex-bsp
elif [ -d ./soniccore ] ; then 
    cd ./soniccore/componentsx/meta-soniccorex-bsp
elif [ -d ./componentsx ] ; then 
    cd ./componentsx/meta-soniccorex-bsp
elif [ -d ./meta-soniccorex-bsp ] ; then 
    cd ./meta-soniccorex-bsp
else 
    echo "ERROR: cannot cd to base-dir, not in known path!"
    # do not do 'exit', as this file is "sourced"!      
fi 

