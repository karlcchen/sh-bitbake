# to be sourced 
#
#

DIR_BASE="SonicCoreX"
JUMP_TO_DIR="${DIR_BASE}/projects"

source ~/bin/cdjump "${DIR_BASE}" "${JUMP_TO_DIR}"
if [ $? -ne 0 ] ; then 
    printf "\nERROR: cdjump from %s to %s failed!\n" "${DIR_BASE}" "${DIR_BASE}/${JUMP_TO_DIR}"
    return 0 
fi 
