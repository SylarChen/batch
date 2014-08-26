#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

#start httpd
. startApacheWS.sh

#start pgsql server
. startpgsql.sh

#start MQ server
. startMQBroker.sh & > ./log/imq.log

sleep 10
#start BTOA server
. startBTOA.sh
