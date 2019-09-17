# to be sourced
#
# cd-deploy-images.sh
#
DIAG_INITRAMFS_NAME="diag-kchen-image-initramfs"
SRC_IMGAE="soniccorex-image-sunup-initramfs-${BUILD_MACHINE}.cpio.gz"
DEST_IMAGE="${DIAG_INITRAMFS_NAME}-${BUILD_MACHINE}.cpio.gz"
#
pushd .
source ~/sh-bitbake/cd-deploy-images.sh
rm -f ${DEST_IMAGE}
ln -s ${SRC_IMGAE} ${DEST_IMAGE}
#
echo 
ls -l ${SRC_IMGAE} 
ls -l ${DEST_IMAGE}
echo 
popd 
