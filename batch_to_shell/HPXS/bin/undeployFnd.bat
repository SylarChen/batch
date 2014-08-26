@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy fndwar
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy bsf
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy uim

