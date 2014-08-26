#!/bin/sh
. setenv.sh

$AS_ADMIN_CMD start-domain BTOA
echo Executed start domain BTOA, exit value: $?
