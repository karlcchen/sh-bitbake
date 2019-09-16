#
# for being 'source'd file, not to be execuated by shell 
#
# setup-build.sh
#
if [ ! "$1" = "" ] ; then 
    export BUILD_MACHINE="$1"
elif [ "$BUILD_MACHINE" = "" ] ; then 
    echo -e "ERROR: env var BUILD_MACHINE undefine!"
    exit 1
fi 
if [ ! "$2" = "" ] ; then 
    export BUILD_TARGET="$2"
elif [ "$BUILD_TARGET" = "" ] ; then 
    echo -e "ERROR: env var BUILD_TARGET undefine!"
    exit 2
fi

export FILE_BUILD_COMPLETE=".build_complete"

#if [ \("${BUILD_MACHINE}" = "" \)  -o  \( "${BUILD_TARGET}" = "" \) ] ; then
if [[ ( "${BUILD_MACHINE}" = "" ) ||  ( "${BUILD_TARGET}" = "" ) ]] ; then
    echo -e "\nERROR: incomplete input found!\n"
    exit 3
else
    echo -e "\nBUILD_MACHINE=${BUILD_MACHINE}"
    echo -e "BUILD_TARGET=${BUILD_TARGET}\n"
    if [ ! -e ./setup.sh ] ; then 
        echo -e "\nERROR: Must run it from directory that has ./setup.sh, for example: 'SonicCoreX'\n" 
    # do not exit as this file is sourced, also if "exited" and running in tmux/screen, it exit the current screen not "bash"  
    #    exit 1
    else
	rm -f ${FILE_BUILD_COMPLETE}
        PROJECT=lithium MACHINE=${BUILD_MACHINE} PRODUCT="" CONF=dev source ./setup.sh build.${BUILD_TARGET}.${BUILD_MACHINE}
        if [ $? -ne 0 ] ; then 
	    echo -e "\nERROR: setup bitbake build environment: ${BUILD_TARGET}.${BUILD_MACHINE} failed!\n" 
	#    exit 2
        fi
    fi 
fi



