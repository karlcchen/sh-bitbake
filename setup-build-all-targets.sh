#
# setup-build-all-targets
# this file can be sourced
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

source ${BB_DIR}/setup-build.sh loma-prieta   diag
# 
# need to wait until first build completed
#
#source ${BB_DIR}/setup-build.sh anderson-peak diag
#while [ ! -f ${FILE_BUILD_COMPLETE} ] ; 
#do 
#    sleep 5
#done
