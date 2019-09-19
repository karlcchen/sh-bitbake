#!/bin/bash
#
# bmap-tool-copy-wic2.sh
#
VERBOSE=0
FORCE_FLAG=0
MACHINE_TYPE=""
MIN_DRIVE_CAP=3
MAX_DRIVE_CAP=64
N_PARTITION_EXPECTED=4

if [ "$1" = "" ]; then
    echo -e "\nERROR: no input machine type specified!\n"
    exit 1
else 
    MACHINE_TYPE="${1}"
fi

# 
# called directly, ${BUILD_MACHINE_TYPE_DIR} can be undefined! 
# 
if [ "${WIC_FILENAME}" = "" ] ; then 
    INPUT_FILENAME="${BUILD_MACHINE_TYPE_DIR}${MACHINE_TYPE}/diag-minimal-${MACHINE_TYPE}.wic"
else 
    INPUT_FILENAME="${WIC_FILENAME}"	
fi 

echo -e "\nINFO: INPUT_FILENAME=${INPUT_FILENAME}"

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
    if [ ${DEST_DEV4_LAST_CHAR} -lt ${N_PARTITION_EXPECTED} ] ; then 
        printf "\nERROR: the destination device found is \"${DEST_DEV4}\", it cannot find its partition #%d\n" ${N_PARTITION_EXPECTED}
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

if [[ ! ${DEV_SIZE} -ge ${MIN_DRIVE_CAP} && ${DEV_SIZE} -le ${MAX_DRIVE_CAP} ]]; then 
    printf "\nERROR: device size is not within %d to %d %s\n" ${MIN_DRIVE_CAP} ${MAX_DRIVE_CAP} "${SIZE_UNIT_EXPECTED}"
    exit 6
fi 

# umount all mount device 
# TODO: this mab be skippped

DEST_DEV_LIST=`sudo fdisk -l | awk '{print $1}' | grep "${DEST_DEV}"`
MNT_DEV_LIST=`sudo mount | awk '{print $1}' | grep "${DEST_DEV}"` 

#for mnt_name in ${DEST_DEV}1 ${DEST_DEV}2 ${DEST_DEV}3 ${DEST_DEV}4
#for mnt_name in ${DEST_DEV_LIST}
for mnt_name in ${MNT_DEV_LIST}
do 
    if [ -e ${mnt_name} ] ; then 
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
    fi 	
done 

if [ -f "${INPUT_FILENAME}" ] ; then
    sudo bmaptool copy ${INPUT_FILENAME} ${DEST_DEV}
    if [ $? -ne 0 ] ; then 
        echo -e "\nERROR: 'sudo bmaptool copy ${INPUT_FILENAME} ${DEST_DEV}' failed!\n" 
        exit 8
    fi 
    TMP_MNT_NAME="./temp-part1"
    IMG_INFO_FILENAME="${TMP_MNT_NAME}/${MACHINE_TYPE}.info"     
    mkdir -p ${TMP_MNT_NAME}
    if [ $? -ne 0 ] ; then 
        printf "\nERROR: mkdir -p  %s failed!\n" "${TMP_MNT_NAME}"
        exit 9
    fi 
#
# just in case any of these were mounted before
    sudo umount ./temp-part1
    sudo umount ${DEST_DEV}1
#
    sudo mount ${DEST_DEV}1 ${TMP_MNT_NAME}
    if [ $? -ne 0 ] ; then 
        echo -e "\nERROR: mount ${DEST_DEV}1 ${TMP_MNT_NAME} failed!\n" 
        exit 10
    fi 
#
    echo "# MACHINE_TYPE =${MACHINE_TYPE}"   | sudo tee -a ${IMG_INFO_FILENAME}
    echo "# BUILD_TYPE   =diag-linux"        | sudo tee -a ${IMG_INFO_FILENAME}
    echo "# WIC_FILENAME =${INPUT_FILENAME}" | sudo tee -a ${IMG_INFO_FILENAME}
    echo "# DATE         =`date`"            | sudo tee -a ${IMG_INFO_FILENAME} 
#
    sync
    if [ $? -ne 0 ] ; then 
        echo -e "\nERROR ignored: sync failed!\n" 
    fi 

#
# for dump info file content
#    printf "\n=== Boot drive File %s in first partition ===\n" "${IMG_INFO_FILENAME}"
#    cat ${IMG_INFO_FILENAME} 
    if [ $? -ne 0 ] ; then 
        printf "\nERROR ignored car %s failed!\n" "${IMG_INFO_FILENAME}"
    fi 
#    sudo umount ./temp-part1
    sudo umount ${DEST_DEV}1
    if [ $? -ne 0 ] ; then 
        echo -e "\nERROR: ignore \"umount %s\" failed!\n" "${DEST_DEV}1"
        exit 10
    fi 
else
    printf "\nERROR: ### input file \"%s\" not found!\n" "${INPUT_FILENAME}"
    exit 11
fi

sync
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: sync failed!\n" 
    exit 12
fi 

sudo eject ${DEST_DEV} 
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: sudo eject ${DEST_DCEV} failed!\n" 
    exit 13
fi 

echo "=== Write to ${DEST_DEV} completed successfully ===" 
echo "=== Device ejected successfully, you may remove it now ===" 

