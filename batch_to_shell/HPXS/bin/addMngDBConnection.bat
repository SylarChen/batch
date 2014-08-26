@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

IF NOT "%1" == "" set mng.host=%1
IF NOT "%2" == "" set mng.port=%2
IF NOT "%3" == "" set mng.database=%3
IF NOT "%4" == "" set mng.user=%4
IF NOT "%5" == "" set mng.password=%5
IF NOT "%6" == "" set tnt.id=%6
IF [%dbtype%]==[MSSQL] (
    IF NOT "%7" == "" set instance.name=%7
) Else (
    IF NOT "%7" == "" set sid=%7
)


REM Parsing host string - replacing "\" with "\\"
set mng.host=%mng.host:\=\\%

echo %mng.host%
echo %mng.port%
echo %mng.database%
echo "=====new tenant id:====="
echo %tnt.id%
echo "================="
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/ManagementDbConnectionPool%tnt.id%
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool ManagementDbConnectionPool%tnt.id%

IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.OracleConnectionValidation --property user=%mng.user%:password=%mng.password%:url=jdbc\:mercury\:oracle\:\/\/%mng.host%\:%mng.port%;sid\=%mng.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 ManagementDbConnectionPool%tnt.id%
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool%tnt.id% jdbc/ManagementDbConnectionPool%tnt.id%
IF [%dbtype%]==[MSSQL] (
    if defined instance.name (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%mng.database%:user=%mng.user%:password=%mng.password%:url=jdbc\:mercury\:sqlserver\:\/\/%mng.host%\:%mng.port%;instanceName\=%instance.name%;databaseName\=%mng.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 ManagementDbConnectionPool%tnt.id%
    ) Else (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%mng.database%:user=%mng.user%:password=%mng.password%:url=jdbc\:mercury\:sqlserver\:\/\/%mng.host%\:%mng.port%;databaseName\=%mng.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 ManagementDbConnectionPool%tnt.id%
    )
    call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=ManagementDbConnectionPool%tnt.id% jdbc/ManagementDbConnectionPool%tnt.id%
)