#!/bin/bash
#
# bitbake $1 $2 $3 $4 $5 $6 $7 $8 $9 soniccorex-image-base 2>&1 | tee soniccorex-image-base.log
bitbake $1 $2 $3 $4 $5 $6 $7 $8 $9 soniccorex-image-dev 2>&1 | tee soniccorex-image-dev.log
