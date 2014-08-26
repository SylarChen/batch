@echo off

set AGORA_HOME=%~dp0..

set JAVA_HOME=%AGORA_HOME%/jdk
set AS_JAVA=%JAVA_HOME%

set GLASSFISH_HOME=%AGORA_HOME%/glassfish
set AS_ADMIN_CMD=%GLASSFISH_HOME%/bin/asadmin.bat

set MQ_HOME=%GLASSFISH_HOME%/mq/bin
set MQ_ADMIN_CMD=%MQ_HOME%/imqsvcadmin
set MQ_CLUSTER_URL_FILE=%AGORA_HOME%/bin/cluster.properties
set MQ_BROKERS_HOME=%AGORA_HOME%/glassfish/glassfish/brokers
set MQ_SERVICE_NAME="MQ4.5_Broker"
set MQ_SERVICE_DISPALY="HP Analytic MQ Broker"

set WEBSERVER_HOME=%AGORA_HOME%/webserver
set WS_ADMIN_CMD=%WEBSERVER_HOME%/bin/httpd.exe
set WS_SERVICE_NAME="HPAnalyticWebServer"
set WS_SERVICE_DISPLAY="HP Analytic Web Server"