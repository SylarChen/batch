@echo off

call %~dp0setenv.bat

echo "executing copy /y %~dp0password_empty\admin-keyfile %BTOA_HOME%\glassfish\glassfish\domains\BTOA\config"
copy /y %~dp0password_empty\admin-keyfile %BTOA_HOME%\glassfish\glassfish\domains\BTOA\config

echo "executing copy /y %~dp0password_empty\jmxsecurity.properties %BTOA_HOME%\conf"
copy /y %~dp0password_empty\jmxsecurity.properties %BTOA_HOME%\conf
echo "executed sucessfully"
