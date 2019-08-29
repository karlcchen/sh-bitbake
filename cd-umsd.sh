#
# cd-diag.sh
#
# source this from working directory to go to recipes-diag
#
if [ -d ./SonicCoreX ] ; then 
    cd ./SonicCoreX/projects/lithium/sonicgit/bsp/vendor-sdk/Marvell/UMSD	
elif [ -d ./projects ] ; then 
    cd ./projects/lithium/sonicgit/bsp/vendor-sdk/Marvell/UMSD
elif [ -d ./lithium ] ; then 
    cd ./lithium/sonicgit/bsp/vendor-sdk/Marvell/UMSD
elif [ -d ./sonicgit ] ; then
    cd ./sonicgit/bsp/vendor-sdk/Marvell/UMSD
elif [ -d ./bsp ] ; then   
    cd ./bsp/vendor-sdk/Marvell/UMSD
elif [ -d ./vendor-sdk ] ; then 
    cd ./vendor-sdk/Marvell/UMSD
elif [ -d ./Marvell ] ; then 
    cd ./Marvell/UMSD
elif [ -d ./Marvell ] ; then
    cd ./UMSD
else 
    echo "ERROR: cannot cd to base-dir, not in known path!"
    # do not do 'exit', as this file is "sourced"!      
fi 

