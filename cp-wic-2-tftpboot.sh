#!/bin/bash
#
# cp-wic-2-tftpboot.sh
#
MACHINE_TYPE="${1}"
TFTPBOOT_DEST="/tftpboot/kchen/wic-bmap"

if [ "${MACHINE_TYPE}" = "" ] ; then 
    echo -e "\nERROR: first argument: Missing Machine Type!\n"
    exit 1 
fi 

echo -e "\nINFO: copying diag-minimal-${MACHINE_TYPE}.wic ..."
cp build_output/deploy/images/${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic      ${TFTPBOOT_DEST}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'cp build_output/deploy/images/${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic ${TFTPBOOT_DEST}' failed!\n"
    exit 3 
fi 

echo -e "\nINFO: copying diag-minimal-${MACHINE_TYPE}.wic.bmap ..."
cp build_output/deploy/images/${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic.bmap ${TFTPBOOT_DEST}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: 'cp build_output/deploy/images/${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic.bmap ${TFTPBOOT_DEST}' failed!\n"
    exit 4 
fi 

