#!/bin/bash
#
# get-prj-name.sh 
#
SONIC_CORE_X_DIR="SonicCoreX"

#
# separate string to two parts by using "${SONIC_CORE_X_DIR}" as field separator 
SONIC_BASE="`pwd | awk -F \"${SONIC_CORE_X_DIR}\" '{print $1}'`"
if [ $? -ne 0 ] ; then
    printf "ERROR: pasering current path: %s\n" "`pwd`"
    exit 1
fi 

PRJ_NAME=`basename ${SONIC_BASE}`

printf "%s\n" "${PRJ_NAME}"
