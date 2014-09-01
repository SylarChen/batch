@echo on

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy %1
