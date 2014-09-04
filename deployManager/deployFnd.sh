#!/bin/sh
. `dirname $0`/setenv.sh
. `dirname $0`/SetDomainProperties.sh

IFS=','
LIST_OF_FND_APP=fndwar,bsf,uim
for i in $LIST_OF_FND_APP
do

$AS_ADMIN_CMD --port $admin_listener_port deploy --contextroot $i --force=true $HPXS_HOME/apps/$i.war 

done