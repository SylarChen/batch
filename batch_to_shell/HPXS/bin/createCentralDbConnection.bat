@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

IF NOT "%1" == "" set central.host=%1
IF NOT "%2" == "" set central.port=%2
IF NOT "%3" == "" set central.database=%3
IF NOT "%4" == "" set central.user=%4
IF NOT "%5" == "" set central.password=%5
IF [%dbtype%]==[MSSQL] (
    IF NOT "%6" == "" set instance.name=%6
) Else (
    IF NOT "%6" == "" set sid=%6
)

REM Parsing host string - replacing "\" with "\\"
set central.host=%central.host:\=\\%

echo %central.host%
echo %central.port%
echo %central.database%


call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/CentralDbConnectionPool
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool CentralDbConnectionPool

IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.OracleConnectionValidation --property user=%central.user%:password=%central.password%:url=jdbc\:mercury\:oracle\:\/\/%central.host%\:%central.port%;sid\=%central.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 CentralDbConnectionPool
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=CentralDbConnectionPool jdbc/CentralDbConnectionPool
IF [%dbtype%]==[MSSQL] (
    if defined instance.name (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%central.database%:user=%central.user%:password=%central.password%:url=jdbc\:mercury\:sqlserver\:\/\/%central.host%\:%central.port%;instanceName\=%instance.name%;databaseName\=%central.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 CentralDbConnectionPool
    ) Else (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%central.database%:user=%central.user%:password=%central.password%:url=jdbc\:mercury\:sqlserver\:\/\/%central.host%\:%central.port%;databaseName\=%central.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 CentralDbConnectionPool
    )
    call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=CentralDbConnectionPool jdbc/CentralDbConnectionPool
)
