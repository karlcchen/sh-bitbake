#!/bin/bash
bitbake --verbose --debug soniccorex-image-base 2>&1 | tee soniccorex-image-base.log
