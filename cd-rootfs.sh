#
# cd-rootfs.sh 
#
SCRIPT_NAME="cd-rootfs.sh"

if [ "$1" == "" ] ; then 
    printf "\nERROR: Need build machine name as 1st argument: for example \"anderson-peak\"\n\n"
    printf "For example:\n\t ./%s %s\n\n" "${SCRIPT_NAME}" "anderson-peak"
    return 1
fi 

BUILD_MACHINE="$1"
BUILD_MACHINE1="`echo ${BUILD_MACHINE} | sed -e 's/-/_/g'`"
BUILD_TARGET="diag"
ROOTFS_IMAGE_NAME="diag-minimal"
DEST_DIR="./SonicCoreX/build.${BUILD_TARGET}.${BUILD_MACHINE}/build_output/work/${BUILD_MACHINE1}-soniccorex-linux/${ROOTFS_IMAGE_NAME}/1.0-r0/rootfs"
source cdjump "SonicCoreX" "${DEST_DIR}"
