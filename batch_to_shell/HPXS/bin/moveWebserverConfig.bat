@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

REM override httpd config file %WEBSERVER_HOME%\conf\directories.conf with latest one %FILE_DIRECTORY_NEW%
SET FILE_DIRECTORY_OLD="%WEBSERVER_HOME%\conf\directories.conf"
SET FILE_DIRECTORY_NEW="%WEBSERVER_HOME%\post-install\conf\directories.conf"

SET FILE_DIRECTORY_OLD_BACKUP="%WEBSERVER_HOME%\conf\directories.conf_bak"

if  not exist  %FILE_DIRECTORY_OLD_BACKUP% (
	copy /Y %FILE_DIRECTORY_OLD%  %FILE_DIRECTORY_OLD_BACKUP%
)

copy /Y %FILE_DIRECTORY_NEW%  %FILE_DIRECTORY_OLD%
 
 

REM override httpd config file %WEBSERVER_HOME%\conf\uriworkermap.properties with latest one %FILE_DIRECTORY_NEW%
SET FILE_DIRECTORY_OLD="%WEBSERVER_HOME%\conf\uriworkermap.properties"
SET FILE_DIRECTORY_NEW="%WEBSERVER_HOME%\post-install\conf\uriworkermap.properties"

SET FILE_DIRECTORY_OLD_BACKUP="%WEBSERVER_HOME%\conf\uriworkermap.properties_bak"

if  not exist  %FILE_DIRECTORY_OLD_BACKUP% (
	copy /Y %FILE_DIRECTORY_OLD%  %FILE_DIRECTORY_OLD_BACKUP%
)

 copy /Y %FILE_DIRECTORY_NEW%  %FILE_DIRECTORY_OLD%
 