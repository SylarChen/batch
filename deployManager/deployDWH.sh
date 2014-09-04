#!/bin/sh
. `dirname $0`/setenv.sh
. `dirname $0`/SetDomainProperties.sh

IFS=','
LIST_OF_DWH_APP=fbi-web,dw-web,dw-abc-web,dw-abc-services
for i in $LIST_OF_DWH_APP
do

$AS_ADMIN_CMD --port $admin_listener_port deploy --contextroot $i --force=true $HPXS_HOME/apps/$i.war 

done