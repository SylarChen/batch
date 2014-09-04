@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

SET FILEBASED_HOME=%AGORA_HOME%\apps
SET LOG="%AGORA_HOME%\DataWarehouse\log\dw_fbi_deployment.log"
REM SET LOG=fbi_deployment.log
SET DEPLOY_ERRORLEVEL=

ECHO %TIME% ------- Start Deploy operation -------
ECHO %TIME% ------- Start Deploy operation ------- >> %LOG%

SET LIST_OF_APP=fbi-web

FOR %%M IN (%LIST_OF_APP%) DO (
	SET MODULE=%%M
	
	rem SET EXT=.war	

	SET APP=!FILEBASED_HOME!\%%M!VERSION!!EXT!
	
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

