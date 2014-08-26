#!/bin/sh
. setenv.sh

$AS_ADMIN_CMD stop-domain BTOA
echo Executed stop domain BTOA, exit value: $?