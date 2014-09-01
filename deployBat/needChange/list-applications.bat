call %~dp0setenv.bat
call ../glassfish/bin/asadmin.bat -p 10001 list-applications
pause > nul