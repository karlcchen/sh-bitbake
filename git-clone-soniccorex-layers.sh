#!/bin/bash
#
# 
# see 
# 
# K_BRANCH="soniccorex-marvell-4.14-ga-19.06.3"
# K_SRC="git@sonicgit.eng.sonicwall.com:soniccore/componentsx/soniccorex-kernel-cache.git"
#
K_BRANCH="MASTER/soniccorex/6.5.4/master"
K_SRC="git@sonicgit.eng.sonicwall.com:soniccore/componentsx/soniccorex-layers.git"
#
git clone ${K_SRC} --branch ${K_BRANCH}
