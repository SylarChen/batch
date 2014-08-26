@echo off 
 
call %~dp0setenv.bat

IF [%1]==[] goto MISSING_PARAM
IF [%2]==[] goto MISSING_PARAM

SET process.name=%1
SET command.line.pattern=%~2

SET PROCESS_PID=


FOR /F "tokens=1" %%A IN ('WMIC PROCESS WHERE "Caption='%process.name%.exe' and CommandLine like '%command.line.pattern%'" GET ProcessId 2^>nul') DO (
    IF [%%A] NEQ [ProcessId] (
        SET PROCESS_PID=%%A
        goto FOUND
    )
)


:FOUND

IF [%PROCESS_PID%]==[] goto END

echo. 
echo %PROCESS_PID%

goto END


:MISSING_PARAM
echo. 
echo Usage: 
echo.
echo GetProcessPid ^<process-name^> ^<command-line-pattern^>
echo.


:END
