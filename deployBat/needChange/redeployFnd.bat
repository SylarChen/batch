@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy fndwar
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy bsf
call %AS_ADMIN_CMD% --port %admin.listener.port% undeploy uim


call %AS_ADMIN_CMD% --port %admin.listener.port% deploy  --contextroot fndwar --force=true %AGORA_HOME%\apps\fndwar.war
call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot bsf --force=true %AGORA_HOME%\apps\bsf.war
call %AS_ADMIN_CMD% --port %admin.listener.port% deploy --contextroot uim --force=true %AGORA_HOME%\apps\uim.war
