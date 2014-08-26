@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

REM Domain Creation
call %AS_ADMIN_CMD% stop-domain BTOA
call %AS_ADMIN_CMD% delete-domain BTOA
call %AS_ADMIN_CMD% create-domain --adminport %admin.listener.port% --instanceport %http.listener1.port% --domainproperties http.ssl.port=%http.listener2.port%:orb.listener.port=%orb.listener.port%:orb.ssl.port=%orb.ssl.port%:orb.mutualauth.port=%orb.mutualauth.port%:jms.port=%jms.port%:domain.jmxPort=%jmx.connector.port% --nopassword true BTOA
call %AS_ADMIN_CMD% start-domain BTOA

REM JVM Options
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jvm-options -client
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jvm-options -Xmx512m
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jvm-options -XX\:MaxPermSize=192m
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jvm-options -Dosgi.shell.telnet.port=6666
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -server
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Xmx1536m
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -XX\:MaxPermSize=320m
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -XX\:+UseCompressedOops
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -XX\:+UseCompressedOops
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -XX\:+HeapDumpOnOutOfMemoryError
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -XX\:+LogVMOutput
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -XX\:+UseConcMarkSweepGC
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -XX\:LogFile=${com.sun.aas.instanceRoot}/logs/jvm.log
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -DDebug=false
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Dorg.glassfish.web.rfc2109_cookie_names_enforced=false
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Dosgi.shell.telnet.port=%osgi.shell.telnet.port%
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Dfelix.fileinstall.debug=1
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -DBTOA_HOME=${com.sun.aas.installRoot}/../../
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Dbtoa.log.path=${com.sun.aas.instanceRoot}/logs
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -DBSF_HOME=${com.sun.aas.instanceRoot}
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Dbsf_conf=${com.sun.aas.instanceRoot}/config/conf
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Dbsf_db_location=file\:${com.sun.aas.installRoot}/../../conf/mngdb.properties
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -Dbsf.properties.configuration=true

REM JMS Configuration
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jms-host default_JMS_host
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jms-host --mqhost localhost --mqport %jms.port% --mquser admin --mqpassword admin host1
call %AS_ADMIN_CMD% --port %admin.listener.port% set server.jms-service.type=REMOTE
call %AS_ADMIN_CMD% --port %admin.listener.port% set server.jms-service.default-jms-host=host1
call %AS_ADMIN_CMD% --port %admin.listener.port% create-connector-connection-pool --raname jmsra --connectiondefinition javax.jms.ConnectionFactory jms/KPIConnectionFactory
call %AS_ADMIN_CMD% --port %admin.listener.port% create-connector-resource --poolname jms/KPIConnectionFactory jms/KPIConnectionFactory
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jms-resource --restype javax.jms.Queue --property Name=KPICalculationQueue jms/KPICalculationQueue
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jms-resource --restype javax.jms.Queue --property Name=KPIResultQueue jms/KPIResultQueue
call %AS_ADMIN_CMD% --port %admin.listener.port% create-connector-connection-pool --raname jmsra --connectiondefinition javax.jms.ConnectionFactory jms/SettingConnectionFactory
call %AS_ADMIN_CMD% --port %admin.listener.port% create-connector-resource --poolname jms/SettingConnectionFactory jms/SettingConnectionFactory
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jms-resource --restype javax.jms.Topic --property Name=SettingTopic jms/SettingTopic
call %AS_ADMIN_CMD% --port %admin.listener.port% create-connector-connection-pool --raname jmsra --connectiondefinition javax.jms.ConnectionFactory jms/CacheConnectionFactory
call %AS_ADMIN_CMD% --port %admin.listener.port% create-connector-resource --poolname jms/CacheConnectionFactory jms/CacheConnectionFactory
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jms-resource --restype javax.jms.Topic --property Name=CacheTopic jms/CacheTopic
call %AS_ADMIN_CMD% --port %admin.listener.port% set server-config.mdb-container.max-pool-size=100
call %AS_ADMIN_CMD% --port %admin.listener.port% set server-config.mdb-container.idle-timeout-in-seconds=500
call %AS_ADMIN_CMD% --port %admin.listener.port% set server-config.mdb-container.pool-resize-quantity=5
call %AS_ADMIN_CMD% --port %admin.listener.port% set server-config.mdb-container.steady-pool-size=10

REM Security Configuration
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-message-security-provider --layer HttpServlet GFConsoleAuthModule
call %AS_ADMIN_CMD% --port %admin.listener.port% create-message-security-provider --layer HttpServlet --classname com.hp.btoe.authentication.sam.BSFServerAuthModule --providertype server BSFSAM

REM Protocol Configuration
call %AS_ADMIN_CMD% --port %admin.listener.port% create-protocol jk-connector-protocol
call %AS_ADMIN_CMD% --port %admin.listener.port% create-http --default-virtual-server server jk-connector-protocol
call %AS_ADMIN_CMD% --port %admin.listener.port% create-network-listener --listenerport 10010 --protocol jk-connector-protocol --transport tcp --jkenabled true --threadpool http-thread-pool jk-connector

REM Data Source Configuration
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --property user=%mng.user%:password=%mng.password%:url=jdbc\:mercury\:oracle\:\/\/%mng.host%\:%mng.port%;sid\=%mng.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 ManagementDbConnectionPool
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool jdbc/ManagementDbConnectionPool
IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --property databaseName=%mng.database%:user=%mng.user%:password=%mng.password%:url=jdbc\:mercury\:sqlserver\:\/\/%mng.host%\:%mng.port%;databaseName\=%mng.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 ManagementDbConnectionPool
IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool jdbc/ManagementDbConnectionPool


call %AS_ADMIN_CMD% stop-domain BTOA

REM Make admin console http://localhost:10001 secured
copy /Y "%AGORA_HOME%\conf\BTOA-admin-keyfile" "%GLASSFISH_HOME%\glassfish\domains\BTOA\config\admin-keyfile"
REM call %AS_ADMIN_CMD% start-domain BTOA



