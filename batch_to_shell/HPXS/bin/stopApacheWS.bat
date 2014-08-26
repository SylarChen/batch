@echo off

call %~dp0setenv.bat


REM Stopping the server

%WS_ADMIN_CMD%  -k stop -n %WS_SERVICE_NAME%

sc config %WS_SERVICE_NAME% start= demand