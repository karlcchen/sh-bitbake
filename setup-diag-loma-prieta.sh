#
# setup-diag-loma-prieta.sh
#
<<<<<<< HEAD
~/sh-bitbake/setup-build.sh "loma-prieta" "diags"
=======
export BUILD_MACHINE="loma-prieta"
export BUILD_TARGET="diag"
source ~/sh-bitbake/setup-build.sh ${BUILD_MACHINE} ${BUILD_TARGET}
>>>>>>> update for preparing init, setup and build at one command

