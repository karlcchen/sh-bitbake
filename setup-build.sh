#
# for being 'source'd file, not to be execuated by shell 
# setup-build.sh
#

BUILD_MACHINE="$1"
BUILD_TARGET="$2"

echo -e "\n BUILD_MACHINE=${BUILD_MACHINE}\n"
echo -e " BUILD_TARGET=${BUILD_TARGET}\n"

if [ ! -e ./setup.sh ] ; then 
    echo
    echo "ERROR: Must run it from directory that has ./setup.sh, fro example: SonicCoreX/" 
    echo
# do not exit as this file is sourced, also if "exited" and running in tmux/screen, it exit the current screen not "bash"  
#    exit 1
else
    PROJECT=lithium MACHINE=${BUILD_MACHINE} PRODUCT="" CONF=dev source ./setup.sh build.${BUILD_TARGET}.${BUILD_MACHINE}
    if [ $? -ne 0 ] ; then 
	echo 
	echo "ERROR: setup bitbake build environment: ${BUILD_TARGET}.${BUILD_MACHINE} failed!" 
	echo
#    exit 2
    fi
fi 

