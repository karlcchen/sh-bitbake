#!/bin/bash
#
# tar-wic.sh 
#

IMAGE_DIR="./build_output/deploy"
FIND_SPEC1='*.wic' 
FIND_SPEC2='*.wic.bmap'
PWD=`pwd`
MACHINE_TYPE="${1}"
BUILD_TYPE="${2}"

if [ "$1" = "" ] ; then 
    MACHINE_TYPE=`echo "${PWD}" | rev | cut -d"." -f1  | rev`
    printf "\nINFO: found MACHINE TYPE: %s\n" "${MACHINE_TYPE}"
fi 

if [ "$2" = "" ] ; then 
    BUILD_TYPE=`echo "${PWD}" | rev | cut -d"." -f2  | rev`
    printf "INFO: found BUILD TYPE: %s\n" "${BUILD_TYPE}"
fi 

TAR_FILENAME="${MACHINE_TYPE}-${BUILD_TYPE}-wic-bmap.tar.gz"

#
cd ${IMAGE_DIR}
if [ $? -ne 0 ] ; then 
    printf "\n ERROR: CANNOT \"cd %s\"\n" "${IMAGE_DIR}"
    printf "\n INFO: Please run from build directory, where I can do \"cd %s\"\n\n" "${IMAGE_DIR}" 
    exit 2
fi 
#
printf " Tarring files, please wait...\n" 
aname "${FIND_SPEC1}" "${FIND_SPEC2}" | xargs tar czvf ../../${TAR_FILENAME} 
if [ $? -ne 0 ] ; then 
    printf "\n ERROR: tar create \"%s\" file failed, Search for: %s %s" "${TAR_FILENAME}" "${FIND_SPECS1}" "${FIND_SPECS2}"
    exit 3
fi 
printf "\n all files tarred successfully\n"

