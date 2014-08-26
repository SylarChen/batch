@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

rem call %~dp0redeployFnd.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy integrations

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot integrations --force=true %AGORA_HOME%\apps\integrations.war

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dw-web

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot dw-web --force=true %AGORA_HOME%\apps\dw-web.war

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dw-abc-web

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot dw-abc-web --force=true %AGORA_HOME%\apps\dw-abc-web.war

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy dw-abc-services

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot dw-abc-services --force=true %AGORA_HOME%\apps\dw-abc-services.war
