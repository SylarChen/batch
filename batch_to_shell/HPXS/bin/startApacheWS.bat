@echo off

call %~dp0setenv.bat

%WS_ADMIN_CMD% -k start -n %WS_SERVICE_NAME%
