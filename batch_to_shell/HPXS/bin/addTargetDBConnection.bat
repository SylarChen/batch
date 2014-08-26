@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

IF NOT "%1" == "" set trg.host=%1
IF NOT "%2" == "" set trg.port=%2
IF NOT "%3" == "" set trg.database=%3
IF NOT "%4" == "" set trg.user=%4
IF NOT "%5" == "" set trg.password=%5
IF NOT "%6" == "" set tnt.id=%6
IF [%dbtype%]==[MSSQL] (
    IF NOT "%7" == "" set instance.name=%7
) Else (
    IF NOT "%7" == "" set sid=%7
)


REM Parsing host string - replacing "\" with "\\"
set trg.host=%trg.host:\=\\%

echo %trg.host%
echo %trg.port%
echo %trg.database%
echo "=====new tenant id:====="
echo %tnt.id%
echo "================="
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/TargetDbConnectionPool%tnt.id%
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool TargetDbConnectionPool%tnt.id%

IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.OracleConnectionValidation --property user=%trg.user%:password=%trg.password%:url=jdbc\:mercury\:oracle\:\/\/%trg.host%\:%trg.port%;sid\=%trg.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 TargetDbConnectionPool%tnt.id%
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=TargetDbConnectionPool%tnt.id% jdbc/TargetDbConnectionPool%tnt.id%
IF [%dbtype%]==[MSSQL] (
    if defined instance.name (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%trg.database%:user=%trg.user%:password=%trg.password%:url=jdbc\:mercury\:sqlserver\:\/\/%trg.host%\:%trg.port%;instanceName\=%instance.name%;databaseName\=%trg.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 TargetDbConnectionPool%tnt.id%
    ) Else (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%trg.database%:user=%trg.user%:password=%trg.password%:url=jdbc\:mercury\:sqlserver\:\/\/%trg.host%\:%trg.port%;databaseName\=%trg.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 TargetDbConnectionPool%tnt.id%
    )
    call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=TargetDbConnectionPool%tnt.id% jdbc/TargetDbConnectionPool%tnt.id%
)
