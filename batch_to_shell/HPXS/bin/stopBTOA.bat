@echo off

call %~dp0setenv.bat


REM Stopping the server

call %AS_ADMIN_CMD% stop-domain BTOA


Rem Making sure the server has stopped

call %~dp0GetBTOAPid.bat

IF [%BTOA_PID%]==[] goto END

Rem Sleep for 60 second (win2k sleep workaround)
echo BTOA still running, retry in 60 seconds...
ping -n 60 127.0.0.1 >NUL

call %~dp0GetBTOAPid.bat

IF [%BTOA_PID%]==[] goto END

Rem Sleep for 60 second (win2k sleep workaround)
echo BTOA still running, retry in 60 seconds...
ping -n 60 127.0.0.1 >NUL

call %~dp0GetBTOAPid.bat

IF [%BTOA_PID%]==[] goto END

echo BTOA still running, killing the process
echo.
TASKKILL /F /PID %BTOA_PID% /T


:END