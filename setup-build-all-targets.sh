#
# setup-build-all-targets
# this file can be sourced
#
source ~/sh-bitbake/setup-build.sh loma-prieta   diag
# 
# need to wait until first build completed
#
#source ~/sh-bitbake/setup-build.sh anderson-peak diag
#while [ ! -f ${FILE_BUILD_COMPLETE} ] ; 
#do 
#    sleep 5
#done
