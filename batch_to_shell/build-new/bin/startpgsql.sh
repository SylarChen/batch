#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

$PG_CMD start -D "$PG_INSTANCE/data" -o "-h $mng_host -p $mng_port"
