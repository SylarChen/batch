@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

taskkill /F /IM imqbrokersvc.exe /T
