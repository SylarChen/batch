@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat


SET ARGS=%*

if /I "%ARGS%"=="-f" (
	GOTO :RESTORE_PASSWORD
)

SET answer=n
set /p answer= "Are you sure you want to restore admin password(y/n)[n]: "

if /I "%answer%"=="y" (
	GOTO :RESTORE_PASSWORD
)
if /I "%answer%"=="yes" (
	GOTO :RESTORE_PASSWORD
)

GOTO :EOF

:RESTORE_PASSWORD
	if exist "%BTOA_HOME%\jdk\bin\java.exe" (
		set JAVA="%BTOA_HOME%\jdk\bin\java"
		set BTOA_JAVA_HOME="%BTOA_HOME%\jdk\bin"
	)else (
		set JAVA="%JAVA_HOME%\bin\java"
		set BTOA_JAVA_HOME="%JAVA_HOME%\bin"
	)

	SET CLASSPATH="%BTOA_HOME%\confwizard\lib\*;%BTOA_HOME%\confwizard\classes"
	SET MAINCLASS=com.hp.btoe.postinstall.configwizard.fm.fnd.AdminPasswordOperationCLI
	set JAVA_OPTS=-XX:MaxPermSize=512m 
	set JAVA_OPTS=%JAVA_OPTS% -DBTOA_JAVA_HOME=%BTOA_JAVA_HOME%
	rem set JAVA_OPTS=%JAVA_OPTS% -Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=1052
	set JAVA_OPTS=%JAVA_OPTS% -Dlog4j.configuration="file:%BTOA_HOME%\conf\admin-password-operation-log4j.xml"
	%JAVA%  %JAVA_OPTS% -classpath %CLASSPATH% %MAINCLASS% -restore
	
:EOF