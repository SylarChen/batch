#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

$PG_CMD stop -D "$PG_INSTANCE/data" -m fast

