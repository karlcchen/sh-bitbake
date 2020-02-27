#!/bin/bash
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

echo "BB_DIR=${BB_DIR}"

${BB_DIR}/bb-diag-clean.sh 
${BB_DIR}/bb-diag.sh 
