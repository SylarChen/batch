. `dirname $0`/setenv.sh
. `dirname $0`/SetDomainProperties.sh

case "$1" in
	"-d" ) 
		$AS_ADMIN_CMD --port $admin_listener_port deploy --contextroot $2 --force=true $HPXS_HOME/apps/${2}.war
		;;
	"-u" ) 
		echo "undeploy"
		;;
	"-r" ) 
		echo "redeploy"
		;;
	*)
		echo "error option"
		;;
esac
