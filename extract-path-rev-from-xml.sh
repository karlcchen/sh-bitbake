#!/bin/bash
#
cat $1 | sed -n '/path=/{p;n;p;}' | sed s/path=//g | sed s/revision=//g | sed s/\>//g
