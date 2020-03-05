#!/bin/bash
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

echo "BB_DIR=${BB_DIR}"

${BB_DIR}/bb-diag-clean.sh 
if [ $? -ne 0 ] ; then 
    echo 
    echo "ERROR: exec ${BB_DIR}/bb-diag-clean.sh"
    echo
    exit 1
fi 
${BB_DIR}/bb-diag.sh 
if [ $? -ne 0 ] ; then 
    echo
    echo "ERROR: exec ${BB_DIR}/bb-diag.sh" 
    echo
    exit 2        
fi 

