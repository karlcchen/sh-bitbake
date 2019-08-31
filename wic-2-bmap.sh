#!/bin/bash
#
# wic-2-bmap.sh
#

DEST_DEV="${1}"   # can be skipped and auto found
MACHINE_TYPE="${2}" # can be skipped and auto found
OPT="-f"

AUTO_MACHINE_TYPE_DIR="./build_output/deploy/images"

if [ "${MACHINE_TYPE}" = "" ] ; then 
    if [ -d "${AUTO_MACHINE_TYPE_DIR}" ] ; then 
       MACHINE_TYPE=`ls ${AUTO_MACHINE_TYPE_DIR}`  
       echo -e "\nINFO: auto find machine type: '${MACHINE_TYPE}'" 
    else 
       echo -e "\nERROR: auto find 'machine type' must be run from build root directory, that has sub-dir './build_output'\n"         
#        echo -e "/nERROR: first argument: Missing Machine Type!/n"
       exit 1 
    fi 
fi 

#
#if [ "${DEST_DEV}" = "" ] ; then 
#    echo -e "/nERROR: second argument: Missing Destniation Block Device Name!/n"
#    exit 2 
#fi 
#

~/sh-bitbake/bmap-tool-copy-wic2.sh "${MACHINE_TYPE}" "${DEST_DEV}" "${OPT}"  
