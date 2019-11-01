#!/bin/bash
#
# input argument of dest dev, such as "/dev/sdd" is not needed 
#

BB_DIR="`dirname $0`"
BB_DIR="`realpath ${BB_DIR}`"

${BB_DIR}/wic-2-bmap.sh castle-peak ${1}

