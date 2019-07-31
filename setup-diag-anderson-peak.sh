# 'source'd file, not for shell exec
#
# setup-diag-anderson-peak.sh
#
<<<<<<< HEAD
~/sh-bitbake/setup-build.sh "anderson-peak" "diags"
=======
export BUILD_MACHINE="anderson-peak"
export BUILD_TARGET="diag"
source ~/sh-bitbake/setup-build.sh ${BUILD_MACHINE} ${BUILD_TARGET}

>>>>>>> update for preparing init, setup and build at one command

