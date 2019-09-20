# for being 'source'd file, not to be execuated by shell 
#
# setupenv-build.sh
#

if [ "$1" = "" ] ; then 
# no argument
    if [ "${BUILD_MACHINE}" = "" ] ; then 
        printf "\nERROR: env var BUILD_MACHINE undefine!\n"
        return 1 
    fi
    if [ "${BUILD_TARGET}" = "" ] ; then 
        printf "\nERROR: env var BUILD_TARGET undefine!\n"
        return 2 
    fi
    if [ "${BUILD_PROJECT}" = "" ] ; then 
        printf "\nERROR: env var BUILD_PROJECT undefine!\n"
        return 3
    fi
    if [ "${BUILD_PRODUCT}" = "" ] ; then 
        printf "\nINFO: env var BUILD_PRODUCT undefine!\n"
#
#        printf "\nERROR: env var BUILD_PRODUCT undefine!\n"
#        return 4
    fi
    if [ "${BUILD_CONF}" = "" ] ; then 
        printf "\nERROR: env var BUILD_CONF undefine!\n"
        return 5
    fi
else 
# expect three env vars defined
    export BUILD_MACHINE="$1"
    if [ "$2" = "" ] ; then 
        printf "\nERROR: BUILD_TARGET not found in 2nd argument!\n"
        return 6
    elif [ "$BUILD_TARGET" = "" ] ; then 
        export BUILD_TARGET="$2"
    fi

    if [ "$3" = "" ] ; then 
        echo -e "ERROR: BUILD_PROJECT not found in 3rd argument!"
        return 7
    elif [ "$BUILD_PROJECT" = "" ] ; then 
        export BUILD_PROJECT="$3"
    fi
fi 

export FILE_BUILD_COMPLETE=".build_complete"

#if [ \("${BUILD_MACHINE}" = "" \)  -o  \( "${BUILD_TARGET}" = "" \) ] ; then
if [[ ( "${BUILD_MACHINE}" = "" ) ||  ( "${BUILD_TARGET}" = "" ) ]] ; then
    echo -e "\nERROR: incomplete input found!\n"
    return 3
else
    echo -e "\nBUILD_MACHINE=${BUILD_MACHINE}"
    echo -e "BUILD_TARGET=${BUILD_TARGET}\n"
    if [ ! -e ./setup.sh ] ; then 
        printf "\nERROR: Expect running from directory \"SonicCoreX\", where \"./setup.sh\" is located!\n" 
    # do not exit as this file is sourced, also if "exited" and running in tmux/screen, it exit the current screen not "bash"  
    #    exit 1
    else
	rm -f ${FILE_BUILD_COMPLETE}
        PROJECT="${BUILD_PROJECT}" MACHINE="${BUILD_MACHINE}" PRODUCT="${BUILD_PRODUCT}" CONF="${BUILD_CONF}" source ./setup.sh build.${BUILD_TARGET}.${BUILD_MACHINE}
        # PROJECT="${BUILD_PROJECT}" MACHINE="${BUILD_MACHINE}" PRODUCT="${BUILD_PRODUCT}" CONF="${BUILD_CONF}" source ./setup.sh
        if [ $? -ne 0 ] ; then 
	    echo -e "\nERROR: setup bitbake build environment: ${BUILD_TARGET}.${BUILD_MACHINE} failed!\n" 
	#    exit 2
        fi
    fi 
fi



