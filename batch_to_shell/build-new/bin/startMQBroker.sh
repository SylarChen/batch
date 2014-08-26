#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

$HPXS_HOME/glassfish/mq/bin/imqbrokerd -vmargs "-Xms192m -Xmx192m -Xss256k" -name imqbroker_host1 -port $jms_port -Dimq.cluster.url=file:$HPXS_HOME/bin/cluster.properties -varhome
$HPXS_HOME/glassfish/glassfish/brokers -reset store
