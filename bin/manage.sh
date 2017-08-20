#!/bin/bash

if [[ -z ${CONSUL} ]]; then
	echo "Missing CONSUL Environment Variable" 
	exit 1
fi 

preStart() {
  export HOST=$(hostname) 
  consul-template \
		-once \
		-consul-addr ${CONSUL}:8500 \
		-template "/etc/cassandra.yaml.ctmpl:/etc/cassandra/conf/cassandra.yaml"
}

health() {
    local privateIp=$(ip addr show eth0 | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}')
    /usr/bin/curl --fail -s -o /dev/null http://${privateIp}:7000
}
$1 
