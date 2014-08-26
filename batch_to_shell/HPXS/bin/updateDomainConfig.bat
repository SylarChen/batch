call %~dp0setenv.bat
call %~dp0SetDomainProperties.bat
CMD /c %AS_ADMIN_CMD% -p 10001 set server-config.http-service.virtual-server.server.property.send-error_403="path=../applications/fndwar/static/statusPages/403.html reason=Forbidden code=403"
CMD /c %AS_ADMIN_CMD% -p 10001 set server-config.http-service.virtual-server.server.property.send-error_404="path=../applications/fndwar/static/statusPages/404.html reason=Resource_not_found code=404"
CMD /c %AS_ADMIN_CMD% -p 10001 set server-config.http-service.virtual-server.server.property.send-error_500="path=../applications/fndwar/static/statusPages/500.html reason=Internal_server_error code=500"
