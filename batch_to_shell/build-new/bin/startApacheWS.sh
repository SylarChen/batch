#!/bin/sh
. setenv.sh

$WS_ADMIN_CMD -d $HPXS_HOME/webserver/httpd -k start
