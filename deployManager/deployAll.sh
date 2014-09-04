#!/bin/sh
. `dirname $0`/setenv.sh
. `dirname $0`/SetDomainProperties.sh

IFS=','

LIST_OF_XS_APP=xs2go-webapp,kpi-mng-web,dashboard-webapp,cap-webapp
LIST_OF_FPA_APP=fpa
LIST_OF_DWH_APP=fbi-web,dw-web,dw-abc-web,dw-abc-services
LIST_OF_FND_APP=fndwar,bsf,uim

LIST_OF_APP=${LIST_OF_FND_APP},${LIST_OF_DWH_APP},${LIST_OF_XS_APP},${LIST_OF_FPA_APP}

for i in $LIST_OF_APP
do

$AS_ADMIN_CMD --port $admin_listener_port deploy --contextroot $i --force=true $HPXS_HOME/apps/$i.war 

done