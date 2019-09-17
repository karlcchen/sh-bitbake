# to be sourced
#
# ln-diag-initramfs-images.sh
#
DIAG_INITRAMFS_NAME="diag-kchen-image-initramfs"
# DIAG_INITRAMFS_NAME="diag-image-initramfs"

SRC_IMGAE="soniccorex-image-sunup-initramfs-${BUILD_MACHINE}.cpio.gz"
DEST_IMAGE="${DIAG_INITRAMFS_NAME}-${BUILD_MACHINE}.cpio.gz"
#
if [ "$1" = "" ] ; then 
    printf "\nERROR: Need build machine name as 1st argument: for example \"anderson-peak\"\n\n"
    printf "For example:\n\t ./ln-diag-initramfs.sh anderson-peak\n\n"
    return 1 
fi 
#
pushd .
source ~/sh-bitbake/cd-deploy-images.sh $1
if [ $? -ne 0 ] ; then 
    popd 
    return 2 
fi 
#
rm -f ${DEST_IMAGE}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: \"rm -f ${DEST_IMAGE}\n"
    popd 
    return 3 
fi 
#
ln -s ${SRC_IMGAE} ${DEST_IMAGE}
if [ $? -ne 0 ] ; then 
    echo -e "\nERROR: \"ln -s ${SRC_IMGAE} ${DEST_IMAGE}\" failed!\n"
    popd
    return 4 
fi 
#
echo 
ls -l ${SRC_IMGAE} 
ls -l ${DEST_IMAGE}
echo 
popd 
