#!/bin/bash
#
#
#pwd
#cd SonicCoreX
#if [ $? -ne 0 ] ; then 
#    pwd
#    echo -e "\nERROR: cd SonicCoreX failed!"
#    exit 4 
#fi
#

source ~/sh-bitbake/setup-diag-loma-prieta.sh
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: source ~/sh-bitbake/setup-diag-loma-prieta.sh failed!"
    exit 5 
fi

~/sh-bitbake/bb-diag.sh
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: ~/sh-bitbake/bb-diag.sh failed!"
    exit 6
fi

