#!/bin/sh
. `dirname $0`/setenv.sh
. `dirname $0`/SetDomainProperties.sh

$AS_ADMIN_CMD --port $admin_listener_port deploy --contextroot fpa --force=true $HPXS_HOME/apps/fpa.war