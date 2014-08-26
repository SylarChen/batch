@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jvm-options -DDebug=true
call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jvm-options -DDebug=false
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options -DDebug=false

call %AS_ADMIN_CMD% --port %admin.listener.port% delete-jvm-options '-XX:+UseConcMarkSweepGC'
call %AS_ADMIN_CMD% --port %admin.listener.port% create-jvm-options '-XX:+UseConcMarkSweepGC'
