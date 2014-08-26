#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

if [ $1 ]
then
central_host=$1
fi

if [ $2 ]
then
central_port=$2
fi

if [ $3 ]
then
central_database=$3
fi

if [ $4 ]
then
central_user=$4
fi

if [ $5 ]
then
central_password=$5
fi


echo $central_host
echo $central_port
echo $central_database

$AS_ADMIN_CMD --port $admin_listener_port delete-jdbc-resource jdbc/CentralDbConnectionPool
$AS_ADMIN_CMD --port $admin_listener_port delete-jdbc-connection-pool CentralDbConnectionPool

$AS_ADMIN_CMD --port $admin_listener_port create-jdbc-connection-pool --restype="java.sql.Driver" --driverclassname="org.postgresql.Driver" --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname="com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation" --property "user=$central_user:password=$central_password:url=jdbc\:postgresql\:\/\/$central_host\:$central_port\/$central_database:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2" CentralDbConnectionPool
$AS_ADMIN_CMD --port $admin_listener_port create-jdbc-resource --connectionpoolid=CentralDbConnectionPool jdbc/CentralDbConnectionPool
