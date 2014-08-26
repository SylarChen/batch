@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

IF NOT "%1" == "" (
	set fpa.database=%1
) ELSE (
	set fpa.database=testdb
)

echo %fpa.database%

call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-resource jdbc/FpaDummyDbConnectionPool
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jdbc-connection-pool FpaDummyDbConnectionPool

call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-connection-pool --restype=java.sql.Driver --driverclassname=org.hsqldb.jdbcDriver --isconnectvalidatereq=false --property user=sa:password=\"\":url=jdbc\:hsqldb\:mem\:testdb FpaDummyDbConnectionPool
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jdbc-resource --connectionpoolid=FpaDummyDbConnectionPool jdbc/FpaDummyDbConnectionPool
IF NOT "%ERRORLEVEL%"=="0" GOTO ERROR_EXIT

exit /B 0

:ERROR_EXIT
echo ERRORLEVEL is not 0
exit /B 1