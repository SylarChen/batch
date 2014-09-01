
@ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat


SET FILEBASED_HOME=%AGORA_HOME%\apps\filebased
SET LOG="%AGORA_HOME%\DataWarehouse\log\dw_fbi_deployment.log"
REM SET LOG=fbi_deployment.log
SET DEPLOY_ERRORLEVEL=

ECHO %TIME% ------- Start Undeploy operation -------
ECHO %TIME% ------- Start Undeploy operation ------- >> %LOG%

SET LIST_OF_APP=fbi-web

FOR %%M IN (%LIST_OF_APP%) DO (
	SET MODULE=%%M
			
	ECHO %TIME% ------- undeploying !MODULE! ------- 
	ECHO %TIME% ------- undeploying !MODULE! ------- >> !LOG!
	
    CMD /c !AS_ADMIN_CMD! --port !admin.listener.port! undeploy  !MODULE! >> !LOG!
    SET DEPLOY_ERRORLEVEL=!DEPLOY_ERRORLEVEL!!ERRORLEVEL!
	IF !ERRORLEVEL! NEQ 0 (
		ECHO !TIME! ------- Fail to Undeploy !MODULE!------ >> !LOG!
	)
)

ECHO %TIME% ------- Undeploy operation finished with Status %DEPLOY_ERRORLEVEL% -------
ECHO %TIME% ------- Undeploy operation finished with Status %DEPLOY_ERRORLEVEL% ------- >> %LOG%

