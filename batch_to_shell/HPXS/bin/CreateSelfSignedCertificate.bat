@echo off

call %~dp0setenv.bat

SET PASS_PHRASE=changeit
SET WEBSERVER_BIN=%WEBSERVER_HOME%\bin
SET AGORA_KEYS=%AGORA_HOME%\conf\keys
SET FILES_PREFIX=btoa.host.hp.com
SET JRE_BIN=%JAVA_HOME%\jre\bin
SET CLASSPATH="%AGORA_HOME%\confwizard\lib\*;%AGORA_HOME%\confwizard\classes"
SET MAINCLASS=com.hp.btoe.postinstall.configwizard.fm.fnd.ImportPrivateKeyAndCertificateToJKS

rem replace of 'fnd.host.fqdn'
SET HOST_FQDN=RAYVMCD100.fpazsh.com
rem end of replace

rem 	Mandatory Input Parameters
rem     --------------------------

IF /i not exist "%WEBSERVER_BIN%/openssl.exe" goto NOOPENSSL
IF /i not exist "%WEBSERVER_BIN%/openssl.cnf" goto NOOPENSSL

cd %WEBSERVER_BIN%
CLS

ECHO.
ECHO ***** This batch creates PEM encoded selfsigned certificate and private key
ECHO ***************************************************************************

ECHO.
ECHO  Step 1 - generate encrypted RSA key
ECHO  -----------------------------------
ECHO Tip - remember the pass phrase you will enter
ECHO.
openssl.exe genrsa -des3 -passout pass:%PASS_PHRASE% -out %AGORA_KEYS%\%FILES_PREFIX%.key 1024

ECHO.
ECHO  Step 2 - remove the pass phrase from key
ECHO  ----------------------------------------
ECHO.
openssl rsa -passin pass:%PASS_PHRASE% -in %AGORA_KEYS%\%FILES_PREFIX%.key -out %AGORA_KEYS%\%FILES_PREFIX%.key.pem

ECHO.
ECHO  Step 3- Creating a certificate request
ECHO  --------------------------------------
ECHO.
openssl req -new -config openssl.cnf -passin pass:%PASS_PHRASE% -key %AGORA_KEYS%\%FILES_PREFIX%.key -out %AGORA_KEYS%\%FILES_PREFIX%.csr -subj /commonName=%HOST_FQDN%

ECHO.
ECHO  Step 4- Creating a certificate
ECHO  ------------------------------
ECHO.
openssl x509 -req -days 1825 -passin pass:%PASS_PHRASE% -in %AGORA_KEYS%\%FILES_PREFIX%.csr -signkey %AGORA_KEYS%\%FILES_PREFIX%.key.pem -out %AGORA_KEYS%\%FILES_PREFIX%.cert.pem

ECHO.
ECHO  Step 5- Creating a PKCS#12 file from private and self signed cert
ECHO  ------------------------------
ECHO.
openssl pkcs12 -export -passout pass: -in %AGORA_KEYS%\%FILES_PREFIX%.cert.pem -inkey %AGORA_KEYS%\%FILES_PREFIX%.key.pem -name "%HOST_FQDN%" -out %AGORA_KEYS%\%FILES_PREFIX%.pfx

ECHO.
ECHO  Step 6- Creating a PKCS#8 file from private and self signed cert (for JKS import)
ECHO  ------------------------------
ECHO.
openssl pkcs8 -topk8 -nocrypt -in %AGORA_KEYS%\%FILES_PREFIX%.key.pem -inform PEM -out %AGORA_KEYS%\%FILES_PREFIX%.key.der -outform DER

ECHO.
ECHO  Step 7- Creating a certificate file in DER format (for JKS import)
ECHO  ------------------------------
ECHO.
openssl x509 -in %AGORA_KEYS%\%FILES_PREFIX%.cert.pem -inform PEM -out %AGORA_KEYS%\%FILES_PREFIX%.cert.der -outform DER

ECHO.
ECHO  Step 8- Import to JKS
ECHO  ------------------------------
ECHO.
cd %JRE_BIN%
java -DBTOA_HOME=%AGORA_HOME% -classpath %CLASSPATH% %MAINCLASS%
keytool -storepass insecure -storepasswd -new %PASS_PHRASE% -keystore ..\lib\security\cacerts

cd %AGORA_HOME%\bin

del %AGORA_KEYS%\%FILES_PREFIX%.key
del %AGORA_KEYS%\%FILES_PREFIX%.csr
del %AGORA_KEYS%\%FILES_PREFIX%.key.der
del %AGORA_KEYS%\%FILES_PREFIX%.cert.der
set PASS_PHRASE=

ECHO.
ECHO  Finished creating the files succesfully
ECHO  ---------------------------------------
ECHO  server certificate file : %AGORA_KEYS%\%FILES_PREFIX%.cert.pem
ECHO  private key file : %AGORA_KEYS%\%FILES_PREFIX%.key.pem
ECHO  pkcs#12 key store file : %AGORA_KEYS%\%FILES_PREFIX%.pfx
ECHO.


GOTO :END

:SCRIPT_USAGE
cls
ECHO   Used for: This batch file creates
ECHO             1)PEM encoded self signed certifiate
ECHO             2)PEM Encoded private key pair of the Public key in certificate
ECHO             3)PKCS#12 keystore with both Certificate and Private key without password
ECHO   Used for: This batch file create a PEM encoded self signed certifiate and coresponde private key
ECHO.
ECHO   Usage   : CreateSelfSignedCertificate.bat [server name]
ECHO.
ECHO   PARAMETERS :
ECHO   1) [server name] = The Fully Qaulified Domain Name of the server
ECHO.
ECHO   e.g. : CreateSelfSignedCertificate.bat www.mywebserver.com
ECHO.
PAUSE
GOTO :END

:NOOPENSSL
cls
ECHO.
ECHO   Required OpenSSL files are:
ECHO   ---------------------------
ECHO   openssl.exe  - execution file
ECHO   openssl.cnf  - request template
ECHO.
PAUSE
GOTO :END

:END
