

SETLOCAL ENABLEDELAYEDEXPANSION

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat



if not exist "%AGORA_HOME%\log" mkdir "%AGORA_HOME%\log"
SET LOG="%AGORA_HOME%\log\deployment.log"
SET DEPLOY_ERRORLEVEL=

ECHO %TIME% ------- Start Undeploy operation -------
ECHO %TIME% ------- Start Undeploy operation ------- >> %LOG%



SET LIST_OF_XS_APP=xs2go-webapp,kpi-mng-web,dashboard-webapp,cap-webapp,mng-console
SET LIST_OF_FPA_APP=fpa
SET LIST_OF_DWH_APP=fbi-web,dw-web,dw-abc-web,dw-abc-services
SET LIST_OF_FND_APP=fndwar,bsf,uim
SET LIST_OF_APP=%LIST_OF_XS_APP%,%LIST_OF_FPA_APP%, %LIST_OF_DWH_APP%,%LIST_OF_FND_APP%

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

