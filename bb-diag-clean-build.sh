#!/bin/bash
#
BB_PROJECT="diag-minimal"
bitbake -c cleansstate ${BB_PROJECT} 2>&1 | tee clean-sstate-${BB_PROJECT}.log
if [ $? -ne 0 ] ; then 
    echo "ERROR: bitbake -c cleansstate ${BB_PROJECT} failed!"
    exit 1
fi 

bitbake ${BB_PROJECT} $1 $2 $3 $4 $5 $6 $7 $8 $9 2>&1 | tee ${BB_PROJECT}.log
if [ $? -ne 0 ] ; then 
    echo "ERROR: bitbake ${BB_PROJECT} failed!"
    exit 2
fi

