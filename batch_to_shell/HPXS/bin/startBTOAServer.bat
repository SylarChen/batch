@echo off

call %~dp0startMQBroker.bat
start /b cmd /c %~dp0startMQBroker.bat
start /w cmd /c %~dp0startBTOA.bat