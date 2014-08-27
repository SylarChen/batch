set +v

. setenv.sh

export PASS_PHRASE=changeit
export WEBSERVER_BIN=${WEBSERVER_HOME}/openssl/ssl
export AGORA_KEYS=${HPXS_HOME}/conf/keys
export FILES_PREFIX=btoa.host.hp.com
export JRE_BIN=${JAVA_HOME}/jre/bin
#export CLASSPATH="${HPXS_HOME}/confwizard/lib/*:${HPXS_HOME}/confwizard/classes"
#export MAINCLASS=com.hp.btoe.postinstall.configwizard.fm.fnd.ImportPrivateKeyAndCertificateToJKS

# replace of 'fnd.host.fqdn'
export HOST_FQDN=RAYVMCD100.fpazsh.com
# end of replace

# 	Mandatory Input Parameters
#   --------------------------

function NOOPENSSL() {
	clear
	echo
	echo   Required OpenSSL files are:
	echo   ---------------------------
#	echo   openssl.exe  - execution file
	echo   openssl.cnf  - request template
	echo
	sleep
	exit
}

#if [! -e "${WEBSERVER_BIN}/openssl.exe" ];then 
#	NOOPENSSL
#fi
if [! -e "${WEBSERVER_BIN}/openssl.cnf" ];then 
	NOOPENSSL
fi

cd $WEBSERVER_BIN
clear

echo
echo ***** This batch creates PEM encoded selfsigned certificate and private key
echo ***************************************************************************

echo
echo  Step 1 - generate encrypted RSA key
echo  -----------------------------------
echo Tip - remember the pass phrase you will enter
echo
openssl genrsa -des3 -passout pass:${PASS_PHRASE} -out ${AGORA_KEYS}/${FILES_PREFIX}.key 1024

echo
echo  Step 2 - remove the pass phrase from key
echo  ----------------------------------------
echo
openssl rsa -passin pass:${PASS_PHRASE} -in ${AGORA_KEYS}/${FILES_PREFIX}.key -out ${AGORA_KEYS}/${FILES_PREFIX}.key.pem

echo
echo  Step 3- Creating a certificate request
echo  --------------------------------------
echo
openssl req -new -config openssl.cnf -passin pass:${PASS_PHRASE} -key ${AGORA_KEYS}/${FILES_PREFIX}.key -out ${AGORA_KEYS}/${FILES_PREFIX}.csr -subj /commonName=${HOST_FQDN}

echo
echo  Step 4- Creating a certificate
echo  ------------------------------
echo
openssl x509 -req -days 1825 -passin pass:${PASS_PHRASE} -in ${AGORA_KEYS}/${FILES_PREFIX}.csr -signkey ${AGORA_KEYS}/${FILES_PREFIX}.key.pem -out ${AGORA_KEYS}/${FILES_PREFIX}.cert.pem

echo
echo  Step 5- Creating a PKCS#12 file from private and self signed cert
echo  ------------------------------
echo
openssl pkcs12 -export -passout pass: -in ${AGORA_KEYS}/${FILES_PREFIX}.cert.pem -inkey ${AGORA_KEYS}/${FILES_PREFIX}.key.pem -name "${HOST_FQDN}" -out ${AGORA_KEYS}/${FILES_PREFIX}.pfx

echo
echo  Step 6- Creating a PKCS#8 file from private and self signed cert (for JKS import)
echo  ------------------------------
echo
openssl pkcs8 -topk8 -nocrypt -in ${AGORA_KEYS}/${FILES_PREFIX}.key.pem -inform PEM -out ${AGORA_KEYS}/${FILES_PREFIX}.key.der -outform DER

echo
echo  Step 7- Creating a certificate file in DER format (for JKS import)
echo  ------------------------------
echo
openssl x509 -in ${AGORA_KEYS}/${FILES_PREFIX}.cert.pem -inform PEM -out ${AGORA_KEYS}/${FILES_PREFIX}.cert.der -outform DER

echo
echo  Step 8- Import to JKS
echo  ------------------------------
echo
cd $JRE_BIN

#java -DBTOA_HOME=${HPXS_HOME} -classpath ${CLASSPATH} ${MAINCLASS}

keytool -storepass insecure -storepasswd -new ${PASS_PHRASE} -keystore ../lib/security/cacerts

cd ${HPXS_HOME}/bin

rm ${AGORA_KEYS}/${FILES_PREFIX}.key
rm ${AGORA_KEYS}/${FILES_PREFIX}.csr
rm ${AGORA_KEYS}/${FILES_PREFIX}.key.der
rm ${AGORA_KEYS}/${FILES_PREFIX}.cert.der
export PASS_PHRASE=

echo
echo  Finished creating the files succesfully
echo  ---------------------------------------
echo  server certificate file : ${AGORA_KEYS}/${FILES_PREFIX}.cert.pem
echo  private key file : ${AGORA_KEYS}/${FILES_PREFIX}.key.pem
echo  pkcs#12 key store file : ${AGORA_KEYS}/${FILES_PREFIX}.pfx
echo

function SCRIPT_USAGE() {
	clear
	echo   Used for: This batch file creates
	echo             1)PEM encoded self signed certifiate
	echo             2)PEM Encoded private key pair of the Public key in certificate
	echo             3)PKCS#12 keystore with both Certificate and Private key without password
	echo   Used for: This batch file create a PEM encoded self signed certifiate and coresponde private key
	echo
	echo   Usage   : CreateSelfSignedCertificate.bat [server name]
	echo
	echo   PARAMETERS :
	echo   1) [server name] = The Fully Qaulified Domain Name of the server
	echo
	echo   e.g. : CreateSelfSignedCertificate.bat www.mywebserver.com
	echo
	sleep
	exit
}