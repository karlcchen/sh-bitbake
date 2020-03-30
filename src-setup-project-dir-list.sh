# file to be sourced 
# 
# src-setup-project-dir-list.sh
#
# expect BB_DIR already set from calling script
#

if [ "${1}" = "--rpath" ] ; then 
    b_REALPATH=0
    shift 1
fi 

if [ "${1}" = "--apath" ] ; then 
    b_REALPATH=1
    shift 1
fi 

# if the argument is "-" , skip it
if [ ! "${1}" = "" ] ; then 
    echo "DEBUG: cd %1"
    if [ ! "${1}" = "-" ] ; then 
        cd $1
        if [ $? -ne 0 ] ; then 
            printf "\nERROR: cd \"%s\" failed!\n" "${1}"
            return 1
        fi 
    fi
fi 

if [ ${b_REALPATH} -eq 0 ] ; then 
    DIR_LIST="`${BB_DIR}/git-dirs.sh --rpath`"
else
    DIR_LIST="`${BB_DIR}/git-dirs.sh --apath`"
fi 
if [ $? -ne 0 ] ; then 
    printf "\nERROR2: ${BB_DIR}/git-dirs.sh \"%s\" failed!\n" "${1}"
    return 2
fi 
