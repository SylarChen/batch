@echo off
call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% create-threadpool --maxthreadpoolsize 25 --minthreadpoolsize 5 --idletimeout 900 allocEngineThreadPool
call %AS_ADMIN_CMD% --port %admin.listener.port% create-resource-adapter-config --threadpoolid allocEngineThreadPool jmsra

exit /B 0

:ERROR_EXIT
echo ERRORLEVEL is not 0
exit /B 1