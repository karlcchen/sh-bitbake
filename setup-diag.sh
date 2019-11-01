# to be sourced
#
# setup-diag.sh
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

if [ "$1" == "" ] ; then 
    printf "\nERROR: need BUILD_MACHINE as 1st argument\n"
    printf "\nFor example: \n\t ./setup-diag.sh anderson-peak\n\n"
    printf "List of valid build machine:\n"
    printf "tz670 or anderson-peak\n"
    printf "tz570 or castle-peak\n"
    printf "tz470 or bear-mountain\n"
    printf "tz370 or birch-mountain\n"
    printf "tz370 or mammoth-mountain\n"
    printf "tz270 or mount-ritter\n"
    printf "tz270 or palomar-mountain\n"
    printf "tz170 or loma-prieta\n\n"
    return 1
#    exit 1
fi 

export BUILD_MACHINE="$1"
# remove the argument, as setup-build.sh expect inputs:
# 1). all from env vars 
# 2). all from arguments 
shift 1

export BUILD_TARGET="diag"
export BUILD_PROJECT="lithium"
#export BUILD_PRODUCT="tz-670"
export BUILD_PRODUCT=""
export BUILD_CONF="dev"
export BUILD_SDKMACHINE=""
export BUILD_TUNE=""
# 
source ${BB_DIR}/setupenv-build.sh ${BUILD_MACHINE} ${BUILD_TARGET} ${BUILD_PROJECT} 
#source ${BB_DIR}/setupenv-build.sh 

