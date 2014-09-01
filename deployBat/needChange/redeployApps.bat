@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat
rem call %~dp0createDataDbConnection.bat

rem call %~dp0redeployFnd.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy xs2go-webapp
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy kpi-mng-web
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dashboard-webapp
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy cap-webapp

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot xs2go-webapp --force=true %AGORA_HOME%/apps/xs2go-webapp.war
IF NOT "%ERRORLEVEL%"=="0" GOTO ERROR_EXIT

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot kpi-mng-web --force=true %AGORA_HOME%/apps/kpi-mng-web.war
IF NOT "%ERRORLEVEL%"=="0" GOTO ERROR_EXIT

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot dashboard-webapp --force=true %AGORA_HOME%/apps/dashboard-webapp.war
IF NOT "%ERRORLEVEL%"=="0" GOTO ERROR_EXIT

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot cap-webapp --force=true %AGORA_HOME%/apps/cap-webapp.war
IF NOT "%ERRORLEVEL%"=="0" GOTO ERROR_EXIT

exit /B 0

:ERROR_EXIT
echo ERRORLEVEL is %ERRORLEVEL%
exit /B 1