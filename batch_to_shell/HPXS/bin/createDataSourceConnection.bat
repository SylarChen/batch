@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

IF NOT "%1" == "" set data.source.name=%1
IF NOT "%2" == "" set data.source.host=%2
IF NOT "%3" == "" set data.source.port=%3
IF NOT "%4" == "" set data.source.database=%4
IF NOT "%5" == "" set data.source.user=%5
IF NOT "%6" == "" set data.source.password=%6
IF [%dbtype%]==[MSSQL] (
    IF NOT "%7" == "" set instance.name=%7
) Else (
    IF NOT "%7" == "" set sid=%7
)

echo %data.source.host%
echo %data.source.port%
echo %data.source.database%

call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/%data.source.name%
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool %data.source.name%

IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.OracleConnectionValidation --property user=%data.source.user%:password=%data.source.password%:url=jdbc\:mercury\:oracle\:\/\/%data.source.host%\:%data.source.port%;sid\=%data.source.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 %data.source.name%
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=%data.source.name% jdbc/%data.source.name%
IF [%dbtype%]==[MSSQL] (
    if defined instance.name (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%data.source.database%:user=%data.source.user%:password=%data.source.password%:url=jdbc\:mercury\:sqlserver\:\/\/%data.source.host%\:%data.source.port%;instanceName\=%instance.name%;databaseName\=%data.source.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 %data.source.name%
    ) Else (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%data.source.database%:user=%data.source.user%:password=%data.source.password%:url=jdbc\:mercury\:sqlserver\:\/\/%data.source.host%\:%data.source.port%;databaseName\=%data.source.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 %data.source.name%
    )
    call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=%data.source.name% jdbc/%data.source.name%
)
