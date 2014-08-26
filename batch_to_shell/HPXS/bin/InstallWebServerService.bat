@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

%WS_ADMIN_CMD%  -k install -n %WS_SERVICE_NAME%

sc config %WS_SERVICE_NAME% start= demand 

sc config %WS_SERVICE_NAME% displayname= %WS_SERVICE_DISPLAY%