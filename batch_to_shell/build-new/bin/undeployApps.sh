#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

IFS=','
LIST_OF_FND_APP=xs2go-webapp,kpi-mng-web,dashboard-webapp,cap-webapp
for i in $LIST_OF_FND_APP
do

$AS_ADMIN_CMD --port $admin_listener_port undeploy $i

done

