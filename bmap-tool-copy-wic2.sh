#!/bin/bash
#
# bmap-tool-copy-wic2.sh
#
FORCE_FLAG=0

if [ "$1" = "" ]; then
    echo -e "\nERROR: no input wic file sepecified!\n"
    exit 1
else 
    INPUT_FILENAME="${1}"
    echo -e "\nINFO: INPUT_FILENAME=${INPUT_FILENAME}"
fi

if [ ! "$2" = "" ]; then
    DEST_DEV="$2"
    echo -e "\nINFO: Skip auto find device name, use DEST_DEV=${DEST_DEV}"
else
#
# auto find usb device name from the last entry of "fdisk -l"
#
    DEST_DEV4=`sudo fdisk -l | tail -n1 | awk '{print $1}'`  
    # DEST_DEV4_LAST_CHAR=`echo "${DEST_DEV4: -1}"`  # the old method of get last char of the string 
    DEST_DEV4_LAST_CHAR=`echo -n "${DEST_DEV4}" | tail -c 1`
    DEST_DEV_PREFIX=`echo -n "${DEST_DEV4}" | cut -c 1-5`
    DEST_DEV=`echo -n "${DEST_DEV4}" | cut -c 1-8`
    if [ "${DEST_DEV_PREFIX}" != "/dev/" ] ; then 
        echo -e "\nERROR: Cannot auto find the destination usb device running 'sudo fdiks -l | tail -n1', got: '${DEST_DEV4}'"
        echo -e "TIPS: the usb device must be newly inserted and not (yet) ejected\n"
        exit 2
    fi 
    if [ ${DEST_DEV4_LAST_CHAR} -lt 4  ] ; then 
        printf "\nERROR: the destination device found is \"${DEST_DEV4}\", it cannot find its partition #4\n"
        printf "The reason could be the device has never been processed by wic-2-bmap\n" 
        printf "Note: if you are sure the device, such as \"${DEST_DEV}\" is correct, specify its name instead of auto find it...\n"
        printf "\nFor Example:\n\n\t wic-2-bmap.sh %s\n\n" "${DEST_DEV}"
        exit 2 
    else 
        echo -e "\nINFO: auto found destniation device as ${DEST_DEV}"     
    fi 
fi

if [ "$3" = "-f" ] ; then 
    FORCE_FLAG=1
    echo -e "\nINFO: use option '-f': focre write to device even if umount the device failed..."
fi 

# check device is valid 
sudo fdisk -l ${DEST_DEV}
if [ $? -ne 0 ] ; then 
	echo -e "\nERROR: 'fdisk -l ${DEST_DEV}' failed!\n" 
	exit 2
fi 

SIZE_UNIT_EXPECTED="GiB,"
# remove decimal part of the number
DEV_SIZE=`sudo fdisk -l ${DEST_DEV} | head -n1 | awk '{print $3}' | cut -d. -f1`
if [ $? -ne 0 ] ; then 
	echo -e "\nERROR: 'sudo fdisk -l ${DEST_DEV} | head -n1 | awk '{print $3}' | cut -d. -f1' failed!\n" 
	exit 3
fi 

SIZE_UNIT=`sudo fdisk -l ${DEST_DEV} | head -n1 | awk '{print $4}'`
if [ $? -ne 0 ] ; then 
	echo -e "\nERROR: 'sudo fdisk -l ${DEST_DEV} | head -n1 | awk '{print $4}'' failed!\n" 
	exit 4
fi 

echo -e "\n=== INFO: DEVICE ${DEST_DEV} size found by fidsk is ${DEV_SIZE} ${SIZE_UNIT} ==="
if [ "${SIZE_UNIT}" != "${SIZE_UNIT_EXPECTED}" ] ; then 
    echo -e "\nERROR: ${DEST_DEV} size unit is ${SIZE_UNIT}, but ${SIZE_UNIT_EXPECTED} expected\n"
    exit 5
fi 

if [[ ! ${DEV_SIZE} -ge 8 && ${DEV_SIZE} -le 64 ]]; then 
    echo -e "\nERROR: device size is not within 8 to 64 ${SIZE_UNIT_EXPECTED}\n"
    exit 6
fi 

# umount all mount device 
# TODO: this mab be skippped
for mnt_name in ${DEST_DEV}1 ${DEST_DEV}2 ${DEST_DEV}3 ${DEST_DEV}4
do 
    echo "INFO: sudo umount ${mnt_name}..."
    sudo umount ${mnt_name}
    if [ $? -ne 0 ] ; then 
	if [ $FORCE_FLAG -eq 0 ] ; then 
	    echo -e "\nERROR: sudo umount ${mnt_name} failed!\n" 
	    echo -e "INFO: you may use '-f' (as first argument) to force write to ${DEST_DEV} when umount failed"
	    exit 7
	else 
	    echo -e "INFO: sudo umount ${mnt_name} failed, but ignored..." 
	fi 
    fi 
done 

if [ -f "${INPUT_FILENAME}" ] ; then
    sudo bmaptool copy ${INPUT_FILENAME} ${DEST_DEV}
else
    printf "\nERROR: ### input file \"%s\" not found!\n" "${INPUT_FILENAME}"
    exit 8
fi

sync
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: sync failed!\n" 
    exit 9
fi 

sudo eject ${DEST_DEV} 
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: sudo eject ${DEST_DCEV} failed!\n" 
    exit 10
fi 

echo "=== Write to ${DEST_DEV} completed successfully ===" 
echo "=== Device ejected successfully, you may remove it now ===" 

