#!/bin/bash
#
# wic-from-tftpboot-2-bmap.sh
#
MACHINE_TYPE="${1}"
DEST_DEV="${2}"
OPT="-f"
TFTPBOOT_DEST="/tftpboot/kchen/wic-bmap"

if [ "${MACHINE_TYPE}" = "" ] ; then 
    echo -e "/nERROR: first argument: Missing Machine Type!/n"
    exit 1 
fi 

if [ "${DEST_DEV}" = "" ] ; then 
    echo -e "/nERROR: second argument: Missing Destniation Block Device Name!/n"
    exit 2 
fi 

~/sh-bitbake/bmap-tool-copy-wic2.sh ${OPT} ${TFTPBOOT_DEST}/${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic ${DEST_DEV}
