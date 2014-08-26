@echo off

IF NOT "%1" == "" set host=%1
IF NOT "%2" == "" set mng=%2
IF NOT "%3" == "" set data=%3
IF NOT "%4" == "" set tenant=%4

call %~dp0createDataSourceConnection.bat ManagementDbConnectionPool%tenant% %host% 1433 %mng% sa mercurypw
call %~dp0createDataSourceConnection.bat DataDbConnectionPool%tenant% %host% 1433 %data% sa mercurypw