@echo off
call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy fpa

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot fpa --force=true %AGORA_HOME%/apps/fpa.war
IF NOT "%ERRORLEVEL%"=="0" GOTO ERROR_EXIT

exit /B 0

:ERROR_EXIT
echo ERRORLEVEL is not 0
exit /B 1