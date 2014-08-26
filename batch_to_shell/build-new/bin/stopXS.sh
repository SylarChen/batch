#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

#stop httpd
. stopApacheWS.sh

#stop pgsql server
. stoppgsql.sh

#stop MQ server
. stopMQBroker.sh & > ./log/imq.log

sleep 10
#stop BTOA server
. stopBTOA.sh
