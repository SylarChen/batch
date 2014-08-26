@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/ManagementDbConnectionPool
call call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool ManagementDbConnectionPool
call call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/DataDbConnectionPool
call call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool DataDbConnectionPool

IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --property user=%mng.user%:password=%mng.password%:url=jdbc\:mercury\:oracle\:\/\/%mng.host%\:%mng.port%;sid\=%mng.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 ManagementDbConnectionPool
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool jdbc/ManagementDbConnectionPool
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --property user=%data.user%:password=%data.password%:url=jdbc\:mercury\:oracle\:\/\/%data.host%\:%data.port%;sid\=%data.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 DataDbConnectionPool
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=DataDbConnectionPool jdbc/DataDbConnectionPool
IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --property databaseName=%mng.database%:user=%mng.user%:password=%mng.password%:url=jdbc\:mercury\:sqlserver\:\/\/%mng.host%\:%mng.port%;databaseName\=%mng.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 ManagementDbConnectionPool
IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool jdbc/ManagementDbConnectionPool
IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --property databaseName=%data.database%:user=%data.user%:password=%data.password%:url=jdbc\:mercury\:sqlserver\:\/\/%data.host%\:%data.port%;databaseName\=%data.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 DataDbConnectionPool
IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=DataDbConnectionPool jdbc/DataDbConnectionPool
