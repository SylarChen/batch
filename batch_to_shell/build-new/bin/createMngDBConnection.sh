#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

if [ $1 ]
then
mng_host=$1
fi

if [ $2 ]
then
mng_port=$2
fi

if [ $3 ]
then
mng_database=$3
fi

if [ $4 ]
then
mng_user=$4
fi

if [ $5 ]
then
mng_password=$5
fi


echo $mng_host
echo $mng_port
echo $mng_database

$AS_ADMIN_CMD --port $admin_listener_port delete-jdbc-resource jdbc/ManagementDbConnectionPool
$AS_ADMIN_CMD --port $admin_listener_port delete-jdbc-connection-pool ManagementDbConnectionPool

$AS_ADMIN_CMD --port $admin_listener_port create-jdbc-connection-pool --restype="java.sql.Driver" --driverclassname="org.postgresql.Driver" --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname="com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation" --property "user=$mng_user:password=$mng_password:url=jdbc\:postgresql\:\/\/$mng_host\:$mng_port\/$mng_database:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2" ManagementDbConnectionPool
$AS_ADMIN_CMD --port $admin_listener_port create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool jdbc/ManagementDbConnectionPool
