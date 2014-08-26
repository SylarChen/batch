
SET XS_HOST=%1
SET XS_PORT=%2
SET FQDN=%XS_HOST%:%XS_PORT%

echo "INFO (%~n0):  FQDN=%FQDN%"

SET BTOA_HOME=%BTOA_HOME%
SET BAT_SCRIPT_HOME=%BTOA_HOME%\bin\updateShortcut

echo "INFO (%~n0): PRODUCT_HOME=%PRODUCT_HOME%"
echo "INFO (%~n0): BAT_SCRIPT_HOME=%BAT_SCRIPT_HOME%"

SET CSCRIPT_ENGINE=%SystemRoot%\System32\cscript.exe

::
:: Get the COMMON_PROGRAMS_DIR
::
FOR /f "delims=" %%a in ('%CSCRIPT_ENGINE% /nologo %BAT_SCRIPT_HOME%\readRegistry.vbs "Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders" "Common Programs" ') do (SET COMMON_PROGRAMS_DIR=%%a)

echo "INFO (%~n0): COMMON_PROGRAMS_DIR=%COMMON_PROGRAMS_DIR%"

SET PRODUCT_HOME=%BTOA_HOME%\..
SET PRODUCT_DISPLAY_NAME=HP Executive Scorecard
SET PRODUCT_MENU_FOLDER=%COMMON_PROGRAMS_DIR%\%PRODUCT_DISPLAY_NAME%

%CSCRIPT_ENGINE% /nologo %BAT_SCRIPT_HOME%\shortcut.vbs "%PRODUCT_MENU_FOLDER%\%PRODUCT_DISPLAY_NAME%.lnk" "https://%FQDN%/xs" "" "%PRODUCT_HOME%\installation\misc\launcher.ico"