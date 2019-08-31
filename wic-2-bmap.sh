#!/bin/bash
#
# wic-2-bmap.sh
#

DEST_DEV="${1}"   # can be skipped and auto found
MACHINE_TYPE="${2}" # can be skipped and auto found
OPT="-f"

if [ "${MACHINE_TYPE}" = "" ] ; then 
    export BUILD_MACHINE_TYPE_DIR="./build_output/deploy/images/"
    if [ ! -d "${BUILD_MACHINE_TYPE_DIR}" ] ; then 
	printf "\nINFO: not in build directory...\n" 
  	export BUILD_MACHINE_TYPE_DIR="./images/"	
        if [ ! -d "${BUILD_MACHINE_TYPE_DIR}" ] ; then 
            pwd
            printf "\nERROR: must be in knwonw board type directory!\n\n" 
            exit 1       
        fi 
    fi 
#   MACHINE_TYPE=`ls -l ${BUILD_MACHINE_TYPE_DIR} | tail -n 1 | awk '{print $9}'`						
    MACHINE_TYPE=`ls ${BUILD_MACHINE_TYPE_DIR}`						
    if [ ! -d "${BUILD_MACHINE_TYPE_DIR}${MACHINE_TYPE}" ] ; then 
        pwd
        printf "\nERROR: %s not found!\n\n" "${BUILD_MACHINE_TYPE_DIR}${MACHINE_TYPE}"
        exit 2       
    fi  
    export WIC_FILENAME="${BUILD_MACHINE_TYPE_DIR}${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic"
    export BMAP_FILENAME="${BUILD_MACHINE_TYPE_DIR}${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic.bmap"

else 
    export WIC_FILENAME="${BUILD_MACHINE_TYPE_DIR}${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic"
    export BMAP_FILENAME="${BUILD_MACHINE_TYPE_DIR}${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic.bmap"
fi 


if [ ! -f "${WIC_FILENAME}" ] ; then 
    printf "\nERROR: cannot find WIC file: \"%s\"\n" "${WIC_FILENAME}"        
    exit 2	
fi 

if [ ! -f "${BMAP_FILENAME}" ] ; then 
    printf "\nERROR: cannot find BMAP file: \"%s\"\n" "${BMAP_FILENAME}"        
    exit 3	
fi 

#
#if [ "${DEST_DEV}" = "" ] ; then 
#    echo -e "/nERROR: second argument: Missing Destniation Block Device Name!/n"
#    exit 2 
#fi 
#

~/sh-bitbake/bmap-tool-copy-wic2.sh "${MACHINE_TYPE}" "${DEST_DEV}" "${OPT}"  
