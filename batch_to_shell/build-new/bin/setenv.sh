#!/bin/sh

export HPXS_HOME=./..
export BTOA_HOME=$HPXS_HOME

export JAVA_HOME=$HPXS_HOME/jdk
export AS_JAVA=$JAVA_HOME

export GLASSFISH_HOME=$HPXS_HOME/glassfish
export AS_ADMIN_CMD=$GLASSFISH_HOME/bin/asadmin

export MQ_HOME=$GLASSFISH_HOME/mq/bin
export MQ_ADMIN_CMD=$MQ_HOME/imqsvcadmin
export MQ_CLUSTER_URL_FILE=$HPXS_HOME/bin/cluster.properties
export MQ_BROKERS_HOME=$HPXS_HOME/glassfish/glassfish/brokers
export MQ_SERVICE_NAME="MQ4.5_Broker"
export MQ_SERVICE_DISPALY="HP Analytic MQ Broker"

export WEBSERVER_HOME=$HPXS_HOME/webserver
export WS_ADMIN_CMD=$WEBSERVER_HOME/httpd/bin/apachectl
export WS_SERVICE_NAME="HPAnalyticWebServer"
export WS_SERVICE_DISPLAY="HP Analytic Web Server"

export PG_INSTANCE=$HPXS_HOME/pgsql/instance1
export PG_INIT_CMD=$HPXS_HOME/pgsql/bin/initdb
export PG_CMD=$HPXS_HOME/pgsql/bin/pg_ctl

export LD_LIBRARY_PATH=$HPXS_HOME/webserver/httpd/lib:$HPXS_HOME/webserver/pcre/lib:$HPXS_HOME/webserver/openssl/lib:$HPXS_HOME/pgsql/lib
