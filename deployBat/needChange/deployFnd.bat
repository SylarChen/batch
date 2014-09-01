@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

SET APPS_HOME=%AGORA_HOME%\apps
if not exist "%AGORA_HOME%\log" mkdir "%AGORA_HOME%\log"
SET LOG="%AGORA_HOME%\log\deployment.log"

REM SET LOG=fbi_deployment.log
SET DEPLOY_ERRORLEVEL=

ECHO %TIME% ------- Start Deploy operation -------
ECHO %TIME% ------- Start Deploy operation ------- >> %LOG%



SET LIST_OF_FND_APP=fndwar,bsf,uim
SET LIST_OF_APP=%LIST_OF_FND_APP%


FOR %%M IN (%LIST_OF_APP%) DO (
	SET MODULE=%%M
	
	rem SET EXT=.war	

	SET APP=!APPS_HOME!\%%M!VERSION!!EXT!
	
	ECHO %TIME% ------- Deploying !MODULE! module from path: !APP! -------
	ECHO %TIME% ------- Deploying !MODULE! module from path: !APP! ------- >> !LOG!
	
    CMD /c !AS_ADMIN_CMD! --port !admin.listener.port! deploy --contextroot !MODULE! --force=true !APP!.war >> !LOG!
	SET DEPLOY_ERRORLEVEL=!DEPLOY_ERRORLEVEL!!ERRORLEVEL!
	IF !ERRORLEVEL! NEQ 0 (
		ECHO !TIME! ------- Fail to Deploy !MODULE!------ >> !LOG!
		exit /B 1
	)
)

ECHO %TIME% ------- Deploy operation finished with Status %DEPLOY_ERRORLEVEL% -------
ECHO %TIME% ------- Deploy operation finished with Status %DEPLOY_ERRORLEVEL% ------- >> %LOG%

