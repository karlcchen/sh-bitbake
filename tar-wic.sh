#!/bin/bash
#
# tar-wic.sh 
#

IMAGE_DIR="./build_output/deploy"
FIND_SPEC1='*.wic' 
FIND_SPEC2='*.wic.bmap'

if [ "$1" = "" ] ; then 
    printf "\n ERROR: no base tar file name specified!\n"  
    printf "\n Example: tar-wic.sh anderson-peak\n\n"
    exit 1
else
    TAR_FILENAME="${1}-wic-bmap.tar.gz"
fi 
#
cd ${IMAGE_DIR}
if [ $? -ne 0 ] ; then 
    printf "\n ERROR: CANNOT \"cd %s\"\n" "${IMAGE_DIR}"
    printf "\n INFO: Please run from build directory, where I can do \"cd %s\"\n\n" "${IMAGE_DIR}" 
    exit 2
fi 
#
aname "${FIND_SPEC1}" "${FIND_SPEC2}" | xargs tar czvf ../../${TAR_FILENAME}
if [ $? -ne 0 ] ; then 
    printf "\n ERROR: tar %s files failed!" "${FIND_SPECS}"
    exit 3
fi 

