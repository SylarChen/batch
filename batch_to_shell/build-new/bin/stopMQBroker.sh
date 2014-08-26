#!/bin/sh
. setenv.sh
. SetDomainProperties.sh

for i in `ps aux | grep $jms_port | awk '{if($11 != "grep") print $2}'`
do
kill $i
done
