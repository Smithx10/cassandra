#!/bin/bash
if [[ -z ${CONSUL} ]]; then
	echo "Missing CONSUL Environment Variable" 
	exit 1
fi 

preStart() {
	consul-template \
		-once \
		-consul-addr ${CONSUL}:8500 \
		-template "/etc/cassandra.yaml.ctmpl:/etc/cassandra/cassandra.yaml"
}











