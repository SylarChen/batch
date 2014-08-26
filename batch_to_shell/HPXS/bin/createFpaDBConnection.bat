@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

IF NOT "%1" == "" set fpa.host=%1
IF NOT "%2" == "" set fpa.port=%2
IF NOT "%3" == "" set fpa.database=%3
IF NOT "%4" == "" set fpa.user=%4
IF NOT "%5" == "" set fpa.password=%5
IF [%dbtype%]==[MSSQL] (
    IF NOT "%6" == "" set instance.name=%6
    ) Else (
    IF NOT "%6" == "" set sid=%6
)


REM Parsing host string - replacing "\" with "\\"
::set fpa.host=%fpa.host:\=\\%

echo %fpa.host%
echo %fpa.port%
echo %fpa.database%

call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/FpaDbConnectionPool
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool FpaDbConnectionPool

IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.OracleConnectionValidation --property user=%fpa.user%:password=%fpa.password%:url=jdbc\:mercury\:oracle\:\/\/%fpa.host%\:%fpa.port%;sid\=%fpa.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 FpaDbConnectionPool
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=FpaDbConnectionPool jdbc/FpaDbConnectionPool
IF [%dbtype%]==[MSSQL] (
    if defined instance.name (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%fpa.database%:user=%fpa.user%:password=%fpa.password%:url=jdbc\:mercury\:sqlserver\:\/\/%fpa.host%\:%fpa.port%;instanceName\=%instance.name%;databaseName\=%fpa.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=false:MaxPooledStatements=5 FpaDbConnectionPool
    ) Else (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%fpa.database%:user=%fpa.user%:password=%fpa.password%:url=jdbc\:mercury\:sqlserver\:\/\/%fpa.host%\:%fpa.port%;databaseName\=%fpa.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=false:MaxPooledStatements=5 FpaDbConnectionPool
    )
    call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=FpaDbConnectionPool jdbc/FpaDbConnectionPool
)