@echo off

call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat

%AGORA_HOME%\glassfish\mq\bin\imqbrokerd -name imqbroker_host1 -port %jms.port% -Dimq.cluster.url=file:%AGORA_HOME%\\bin\\cluster.properties -varhome
%AGORA_HOME%\\glassfish\\glassfish\\brokers -reset store
