@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy ----contextroot %1 --force=true  %2

