@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat


call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy fbi-web
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dw-web
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dw-abc-web
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dw-abc-services