@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

SET GLASSFISH_CONFIG=%GLASSFISH_HOME%\glassfish\domains\BTOA\config
SET FILE_ADMIN_KEY="%GLASSFISH_CONFIG%\admin-keyfile"
SET FILE_ADMIN_KEY_BAK="%GLASSFISH_CONFIG%\admin-keyfile.bak"

REM backup the origianl file
if not exist  %FILE_ADMIN_KEY_BAK% (
	copy /Y %FILE_ADMIN_KEY%  %FILE_ADMIN_KEY_BAK%
)

REM Make admin console http://localhost:10001 secured
copy /Y "%AGORA_HOME%\conf\BTOA-admin-keyfile" %FILE_ADMIN_KEY%


SET FILE_ASADMIN_PASSWORD="%SYSTEMDRIVE%\users\%USERNAME%\.asadminpass"
SET FILE_ASADMIN_PASSWORD_BAK="%FILE_ASADMIN_PASSWORD%.bak"

REM backup the origianl file
if  exist  %FILE_ASADMIN_PASSWORD% (
	copy /Y %FILE_ADMIN_KEY%  %FILE_ASADMIN_PASSWORD_BAK%
)

copy /Y "%AGORA_HOME%\conf\BTOA-asadminpass" "%FILE_ASADMIN_PASSWORD%"

