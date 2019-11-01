#!/bin/bash
#
# 

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

${BB_DIR}/wic-from-tftpboot.sh castle-peak ${1}

