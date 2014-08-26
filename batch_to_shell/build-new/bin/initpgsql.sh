#!/bin/sh
. setenv.sh
. SetDomainProperties.sh
echo $mng_password > $PG_INSTANCE/pwd
$PG_INIT_CMD -D "$PG_INSTANCE/data" -U $mng_user --pwfile "$PG_INSTANCE/pwd"
rm -f $PG_INSTANCE/pwd
