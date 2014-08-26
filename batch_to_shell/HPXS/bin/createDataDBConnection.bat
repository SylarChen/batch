@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

IF NOT "%1" == "" set data.host=%1
IF NOT "%2" == "" set data.port=%2
IF NOT "%3" == "" set data.database=%3
IF NOT "%4" == "" set data.user=%4
IF NOT "%5" == "" set data.password=%5
IF [%dbtype%]==[MSSQL] (
    IF NOT "%6" == "" set instance.name=%6
    ) Else (
    IF NOT "%6" == "" set sid=%6
)

REM Parsing host string - replacing "\" with "\\"
set data.host=%data.host:\=\\%

echo %data.host%
echo %data.port%
echo %data.database%

call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/DataDbConnectionPool
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool DataDbConnectionPool

IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.OracleConnectionValidation --property user=%data.user%:password=%data.password%:url=jdbc\:mercury\:oracle\:\/\/%data.host%\:%data.port%;sid\=%data.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 DataDbConnectionPool
IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=DataDbConnectionPool jdbc/DataDbConnectionPool
IF [%dbtype%]==[MSSQL] (
    if defined instance.name (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%data.database%:user=%data.user%:password=%data.password%:url=jdbc\:mercury\:sqlserver\:\/\/%data.host%\:%data.port%;instanceName\=%instance.name%;databaseName\=%data.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 DataDbConnectionPool
    ) Else (
        call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%data.database%:user=%data.user%:password=%data.password%:url=jdbc\:mercury\:sqlserver\:\/\/%data.host%\:%data.port%;databaseName\=%data.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 DataDbConnectionPool
    )
    call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=DataDbConnectionPool jdbc/DataDbConnectionPool
)

:: ToDo - Temporary! Remove when multi-tenancy is added to post-intsall
::call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/DataDbConnectionPool1
::call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool DataDbConnectionPool1

::IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.OracleDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.OracleConnectionValidation --property user=%data.user%:password=%data.password%:url=jdbc\:mercury\:oracle\:\/\/%data.host%\:%data.port%;sid\=%data.sid%:LoginTimeout=30:BatchPerformanceWorkaround=true:MaxPooledStatements=5:WireProtocolMode=2 DataDbConnectionPool1
::IF [%dbtype%]==[Oracle] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=DataDbConnectionPool1 jdbc/DataDbConnectionPool1
::IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=com.hp.btoe.core.dbdrivers.SQLServerDriver --isconnectvalidatereq=true --validationmethod=custom-validation --validationclassname=com.hp.btoe.core.dbdrivers.validation.SQLServerConnectionValidation --property databaseName=%data.database%:user=%data.user%:password=%data.password%:url=jdbc\:mercury\:sqlserver\:\/\/%data.host%\:%data.port%;databaseName\=%data.database%:LoginTimeout=30:transactionMode=explicit:SendStringParametersAsUnicode=true:MaxPooledStatements=5 DataDbConnectionPool1
::IF [%dbtype%]==[MSSQL] call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=DataDbConnectionPool1 jdbc/DataDbConnectionPool1
