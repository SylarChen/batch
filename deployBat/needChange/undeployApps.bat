@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy xs2go-webapp
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy kpi-mng-web
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dashboard-webapp
 call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy cap-webapp

