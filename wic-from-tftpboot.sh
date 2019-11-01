#!/bin/bash
#
# wic-from-tftpboot-2-bmap.sh
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

MACHINE_TYPE="${1}"
DEST_DEV="${2}"
OPT="-f"
TFTPBOOT_DEST="/tftpboot/kchen/wic-bmap/${MACHINE_TYPE}"

if [ "${MACHINE_TYPE}" = "" ] ; then 
    echo -e "/nERROR: first argument: Missing Machine Type!/n"
    exit 1 
fi 

if [ "${DEST_DEV}" = "" ] ; then 
    echo -e "/nERROR: second argument: Missing Destniation Block Device Name!/n"
    exit 2 
fi 

${BB_DIR}/bmap-tool-copy-wic2.sh ${OPT} ${TFTPBOOT_DEST}/diag-minimal-${MACHINE_TYPE}.wic ${DEST_DEV}
