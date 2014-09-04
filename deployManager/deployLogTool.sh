#!/bin/sh
. `dirname $0`/setenv.sh
. `dirname $0`/SetDomainProperties.sh

$AS_ADMIN_CMD --port $admin_listener_port deploy --contextroot LogPortal --force=true $HPXS_HOME/apps/LogPortal.war 