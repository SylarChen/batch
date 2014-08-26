@echo off

call %~dp0setenv.bat

echo "executing copy /y %~dp0password_admin\admin-keyfile %BTOA_HOME%\glassfish\glassfish\domains\BTOA\config"
copy /y %~dp0password_admin\admin-keyfile %BTOA_HOME%\glassfish\glassfish\domains\BTOA\config
echo "executed sucessfully"
