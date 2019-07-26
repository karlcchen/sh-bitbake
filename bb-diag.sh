#!/bin/bash
#
BUILD_TARGET="diag-minimal"
LOG_FILE="${BUILD_TARGET}.log"
TEE_LOG="tee --append ${LOG_FILE}"
start_time=`date +%s`
echo
echo "### bitbake diag-minimal, start_time=${start_time} ###"
rm -f ${LOG_FILE}
bitbake ${BUILD_TARGET} $1 $2 $3 $4 $5 $6 $7 $8 $9 2>&1 | ${TEE_LOG}
exe_status="$?"
end_time=`date +%s`
run_time=$((end_time-start_time))
echo | ${TEE_LOG}
echo "### run_time=${run_time}, exe_status=${exe_status} ###" | ${TEE_LOG}
echo | ${TEE_LOG}
