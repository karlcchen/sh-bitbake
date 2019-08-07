#!/bin/bash
#
# bmap-tool-copy-wic2.sh
#
DEST_DEV="/dev/sdd"
FORCE_FLAG=0

if [ "$1" = "-f" ] ; then 
    FORCE_FLAG=1
    echo "INFO: focre write to device even if umount failed"
    shift 1
fi 

if [ "$1" = "" ]; then
    echo "ERROR: no input wic file sepecified!"
    exit 1
else 
    INPUT_FILENAME="$1"
    echo "INFO: INPUT_FILENAME=${INPUT_FILENAME}"
fi

if [ ! "$2" = "" ]; then
    DEST_DEV="$2"
    echo "INFO: set DEST_DEV=${DEST_DEV}"
fi

# check device is valid 
sudo fdisk -l ${DEST_DEV}
if [ $? -ne 0 ] ; then 
	echo -e "ERROR: fdisk ${DEST_DCEV} failed!\n" 
	exit 2
fi 

# umount all mount device 
# TODO: this mab be skippped
for mnt_name in ${DEST_DEV}1 ${DEST_DEV}2 ${DEST_DEV}3 ${DEST_DEV}4
do 
    echo "INFO: sudo umount ${mnt_name}..."
    sudo umount ${mnt_name}
    if [ $? -ne 0 ] ; then 
	if [ $FORCE_FLAG -eq 0 ] ; then 
	    echo -e "ERROR: sudo umount ${mnt_name} failed!\n" 
	    echo "INFO: you may use '-f' (as first argument) to force write to ${DEST_DEV} when umount failed"
	    exit 3
	else 
	    echo -e "INFO: sudo umount ${mnt_name} failed, but ignored...\n" 
	fi 
    fi 
done 

if [ -f "$INPUT_FILENAME" ] ; then
    sudo bmaptool copy ${INPUT_FILENAME} ${DEST_DEV}
else
    echo -e "ERROR: file \'$INPUT_FILENAME\' not found!"
    exit 9
fi

sync
sync
sudo eject ${DEST_DEV} 
if [ $? -ne 0 ] ; then 
    echo -e "ERROR: sudo eject ${DEST_DCEV} failed!\n" 
    exit 10
fi 

echo "=== Write to ${DEST_DEV} completed successfully ===" 
echo "=== Device ejected, you may remove it now ===" 

