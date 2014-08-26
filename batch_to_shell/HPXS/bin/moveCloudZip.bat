@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

SET GLASSFISH_CONFIG=%GLASSFISH_HOME%\glassfish\domains\BTOA\config
SET CLOUD_ZIP_FILE="%GLASSFISH_CONFIG%\cap\import\load\Cloud.zip"
SET CLOUD_ZIP_FILE_BAK="%GLASSFISH_CONFIG%\temp\Cloud.zip"

REM move the file "%GLASSFISH_CONFIG%\cap\import\load\Cloud.zip" to %GLASSFISH_CONFIG%\temp\
if  exist  %CLOUD_ZIP_FILE% (
	copy /Y %CLOUD_ZIP_FILE%  %CLOUD_ZIP_FILE_BAK%
	del /F %CLOUD_ZIP_FILE%
)