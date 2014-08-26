@echo off

echo Start of startBTOA.bat

call %~dp0setenv.bat

call %AS_ADMIN_CMD% start-domain BTOA
echo Executed start domain BTOA, exit value: %errorlevel%

if "%errorlevel%"=="0" (
	GOTO :sucess
)

if "%errorlevel%"=="1" (
	GOTO :failure
)

:failure
	echo Trying to restart domain BTOA ...
	
	set PID_FILE=%BTOA_HOME%\confwizard\glassfishPID.txt
	netstat -abno |find "10001" > %PID_FILE%
	FOR /F "tokens=5 delims= " %%i in (%PID_FILE%) do (
	         set PID=%%i
	)
	echo Killing process %PID%
	taskkill /F /PID %PID%
	
	call %AS_ADMIN_CMD% stop-domain BTOA
	call %AS_ADMIN_CMD% start-domain BTOA
	if "%errorlevel%"=="0" (
		echo Restarted domain BTOA sucessfully.
	)
	if "%errorlevel%"=="1" (
		echo Failed to restart domain BTOA.
	)
	GOTO :end

:sucess	
	echo domain BTOA started sucessfully.
	GOTO :end

:end
	echo Final exit value: %errorlevel%
	echo End of startBTOA.bat
