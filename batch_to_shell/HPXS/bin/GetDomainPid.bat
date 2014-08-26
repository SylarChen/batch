@echo off

IF [%1]==[] goto MISSING_PARAM

SET domain.name=%1
SET domain.pattern="%%%%ASMain%%%% -domainname%%%% %domain.name% %%%% com.sun.enterprise.admin.cli.AsadminMain%%%% -type%%%% DAS %%%%"

SET DOMAIN_PID=


call %~dp0GetProcessPid java %domain.pattern%


set DOMAIN_PID=%PROCESS_PID%

IF [%DOMAIN_PID%]==[] goto END

echo. 
echo %DOMAIN_PID%

goto END


:MISSING_PARAM
echo. 
echo Usage: 
echo.
echo GetDomainPid ^<domain-name^>
echo.


:END
