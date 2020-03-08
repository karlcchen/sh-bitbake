#!/bin/bash
#
bitbake -c cleansstate soniccorex-image-dev
bitbake $1 $2 $3 $4 $5 $6 $7 $8 $9 soniccorex-image-dev 2>&1 | tee soniccorex-image-dev.log
