@echo off

IF NOT "%1" == "" set host=%1
IF NOT "%2" == "" set database=%2

call %~dp0createDataSourceConnection.bat UniverseDB1 %host% 1433 %database% sa mercurypw
call %~dp0createDataSourceConnection.bat UniverseDB2 %host% 1433 %database% sa mercurypw
call %~dp0createDataSourceConnection.bat UniverseDB3 %host% 1433 %database% sa mercurypw
