@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

sc stop %WS_SERVICE_NAME%
%WS_ADMIN_CMD% -k uninstall -n %WS_SERVICE_NAME%