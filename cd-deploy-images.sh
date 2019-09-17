# to be sourced
#
# cd-deploy-images.sh
#
if [ "$1" == "" ] ; then 
    printf "\nERROR: Need build machine name as 1st argument: for example \"anderson-peak\"\n\n"
    printf "For example:\n\t ./cd-deplay-image.sh anderson-peak\n\n"
    return 1
fi 

BUILD_MACHINE="$1"
source cdjump "SonicCoreX" "./SonicCoreX/build.diag.${BUILD_MACHINE}/build_output/deploy/images"

if [ -d ${BUILD_MACHINE} ] ; then 
    cd ${BUILD_MACHINE}
else
    printf "\nERROR: cannot cd to directory: %s\n" "${BUILD_MACHINE}"
    return 2
fi 

