@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

SET XS_LOG_TOOL_WAR=%AGORA_HOME%\apps\LogPortal.war
if not exist "%AGORA_HOME%\log" mkdir "%AGORA_HOME%\log"
SET LOG="%AGORA_HOME%\log\deployment.log"

REM SET LOG=fbi_deployment.log
SET DEPLOY_ERRORLEVEL=

ECHO %TIME% ------- Start Deploy operation -------
ECHO %TIME% ------- Start Deploy operation ------- >> %LOG%

call %AS_ADMIN_CMD% --port %admin.listener.port% deploy %XS_LOG_TOOL_WAR%

ECHO %TIME% ------- Deploy operation finished with Status %DEPLOY_ERRORLEVEL% -------
ECHO %TIME% ------- Deploy operation finished with Status %DEPLOY_ERRORLEVEL% ------- >> %LOG%

