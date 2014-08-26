
. setenv.sh
. SetDomainProperties.sh

# Domain Creation
$AS_ADMIN_CMD stop-domain BTOA
$AS_ADMIN_CMD delete-domain BTOA
$AS_ADMIN_CMD create-domain --adminport $admin_listener_port --instanceport $http_listener1_port --domainproperties http.ssl.port=$http_listener2_port:orb.listener.port=$orb_listener_port:orb.ssl.port=$orb_ssl_port:orb.mutualauth.port=$orb_mutualauth_port:jms.port=$jms_port:domain.jmxPort=$jmx_connector_port --nopassword true BTOA
$AS_ADMIN_CMD start-domain BTOA

# JVM Options
#$AS_ADMIN_CMD --port $admin_listener_port delete-jvm-options -client
#$AS_ADMIN_CMD --port $admin_listener_port delete-jvm-options -Xmx512m
#$AS_ADMIN_CMD --port $admin_listener_port delete-jvm-options -XX\:MaxPermSize=192m
#$AS_ADMIN_CMD --port $admin_listener_port delete-jvm-options -Dosgi.shell.telnet.port=6666
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -server
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Xmx1536m
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -XX\:MaxPermSize=320m
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -XX\:+UseCompressedOops
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -XX\:+UseCompressedOops
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -XX\:+HeapDumpOnOutOfMemoryError
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -XX\:+LogVMOutput
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -XX\:+UseConcMarkSweepGC
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -XX\:LogFile=${com.sun.aas.instanceRoot}/logs/jvm.log
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -DDebug=false
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Dorg.glassfish.web.rfc2109_cookie_names_enforced=false
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Dosgi.shell.telnet.port=%osgi.shell.telnet.port%
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Dfelix.fileinstall.debug=1
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -DBTOA_HOME=${com.sun.aas.installRoot}/../../
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Dbtoa.log.path=${com.sun.aas.instanceRoot}/logs
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -DBSF_HOME=${com.sun.aas.instanceRoot}
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Dbsf_conf=${com.sun.aas.instanceRoot}/config/conf
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Dbsf_db_location=file\:${com.sun.aas.installRoot}/../../conf/mngdb.properties
#$AS_ADMIN_CMD --port $admin_listener_port create-jvm-options -Dbsf.properties.configuration=true

# JMS Configuration
#$AS_ADMIN_CMD --port $admin_listener_port delete-jms-host default_JMS_host
#$AS_ADMIN_CMD --port $admin_listener_port create-jms-host --mqhost localhost --mqport $jms_port --mquser admin --mqpassword admin host1
#$AS_ADMIN_CMD --port $admin_listener_port set server.jms-service.type=#OTE
#$AS_ADMIN_CMD --port $admin_listener_port set server.jms-service.default-jms-host=host1
#$AS_ADMIN_CMD --port $admin_listener_port create-connector-connection-pool --raname jmsra --connectiondefinition javax.jms.ConnectionFactory jms/KPIConnectionFactory
#$AS_ADMIN_CMD --port $admin_listener_port create-connector-resource --poolname jms/KPIConnectionFactory jms/KPIConnectionFactory
#$AS_ADMIN_CMD --port $admin_listener_port create-jms-resource --restype javax.jms.Queue --property Name=KPICalculationQueue jms/KPICalculationQueue
#$AS_ADMIN_CMD --port $admin_listener_port create-jms-resource --restype javax.jms.Queue --property Name=KPIResultQueue jms/KPIResultQueue
#$AS_ADMIN_CMD --port $admin_listener_port create-connector-connection-pool --raname jmsra --connectiondefinition javax.jms.ConnectionFactory jms/SettingConnectionFactory
#$AS_ADMIN_CMD --port $admin_listener_port create-connector-resource --poolname jms/SettingConnectionFactory jms/SettingConnectionFactory
#$AS_ADMIN_CMD --port $admin_listener_port create-jms-resource --restype javax.jms.Topic --property Name=SettingTopic jms/SettingTopic
#$AS_ADMIN_CMD --port $admin_listener_port create-connector-connection-pool --raname jmsra --connectiondefinition javax.jms.ConnectionFactory jms/CacheConnectionFactory
#$AS_ADMIN_CMD --port $admin_listener_port create-connector-resource --poolname jms/CacheConnectionFactory jms/CacheConnectionFactory
#$AS_ADMIN_CMD --port $admin_listener_port create-jms-resource --restype javax.jms.Topic --property Name=CacheTopic jms/CacheTopic
#$AS_ADMIN_CMD --port $admin_listener_port set server-config.mdb-container.max-pool-size=100
#$AS_ADMIN_CMD --port $admin_listener_port set server-config.mdb-container.idle-timeout-in-seconds=500
#$AS_ADMIN_CMD --port $admin_listener_port set server-config.mdb-container.pool-resize-quantity=5
#$AS_ADMIN_CMD --port $admin_listener_port set server-config.mdb-container.steady-pool-size=10

# Security Configuration
#$AS_ADMIN_CMD --port $admin_listener_port delete-message-security-provider --layer HttpServlet GFConsoleAuthModule
#$AS_ADMIN_CMD --port $admin_listener_port create-message-security-provider --layer HttpServlet --classname com.hp.btoe.authentication.sam.BSFServerAuthModule --providertype server BSFSAM

# Protocol Configuration
#$AS_ADMIN_CMD --port $admin_listener_port create-protocol jk-connector-protocol
#$AS_ADMIN_CMD --port $admin_listener_port create-http --default-virtual-server server jk-connector-protocol
#$AS_ADMIN_CMD --port $admin_listener_port create-network-listener --listenerport 10010 --protocol jk-connector-protocol --transport tcp --jkenabled true --threadpool http-thread-pool jk-connector

# Data Source Configuration
#if [ $dbtype == Oracle ] 
#then $AS_ADMIN_CMD --port $admin_listener_port create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --property user=$mng_user:password=$mng_password:url=jdbc\:mercury\:oracle\:\/\/$mng_host\:$mng_port;sid\=$mng_sid:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 ManagementDbConnectionPool
#fi
#if [ $dbtype == Oracle ] 
#then $AS_ADMIN_CMD --port $admin_listener_port create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool jdbc/ManagementDbConnectionPool
#fi
#if [ $dbtype == MSSQL ] 
#then $AS_ADMIN_CMD --port $admin_listener_port create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --property databaseName=$mng_database:user=$mng_user:password=$mng_password:url=jdbc\:mercury\:sqlserver\:\/\/$mng_host\:$mng_port;databaseName\=$mng_database:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 ManagementDbConnectionPool
#fi
#if [ $dbtype == MSSQL ] 
#then $AS_ADMIN_CMD --port $admin_listener_port create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool jdbc/ManagementDbConnectionPool
#fi

#$AS_ADMIN_CMD stop-domain BTOA

# Make admin console http://localhost:10001 secured
# copy /Y "%HPXS_HOME%\conf\BTOA-admin-keyfile" "%GLASSFISH_HOME%\glassfish\domains\BTOA\config\admin-keyfile"
# #$AS_ADMIN_CMD start-domain BTOA



