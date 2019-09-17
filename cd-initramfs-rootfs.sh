#
# cd-rootfs.sh 
#

if [ "$1" == "" ] ; then 
    printf "\nERROR: Need build machine name as 1st argument: for example \"anderson-peak\"\n\n"
    printf "For example:\n\t ./cd-rootfs.sh anderson-peak\n\n"
    return 1
fi 

BUILD_MACHINE="$1"
BUILD_TARGET="diag"
INITRAMFS_IMAGE_NAME="diag-kchen-image-initramfs"
BUILD_MACHINE1="`echo ${BUILD_MACHINE} | sed -e 's/-/_/g'`"
source cdjump "SonicCoreX" "./SonicCoreX/build.${BUILD_TARGET}.${BUILD_MACHINE}/build_output/work/${BUILD_MACHINE1}-soniccorex-linux/${INITRAMFS_IMAGE_NAME}/1.0-r0/rootfs"
