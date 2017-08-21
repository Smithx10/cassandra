#!/bin/bash

if [[ -z ${CONSUL} ]]; then
	echo "Missing CONSUL Environment Variable" 
	exit 1
fi 

preStart() {

  while [ $(curl -Ls --fail http://127.0.0.1:8500/v1/health/node/${HOSTNAME} | jq  -r '.[].Status') != "passing" ]; do
    sleep 1.5
    echo "Waiting for Consul Agent to Register before Firing consul-template" 
  done
  
  replace
}

replace() { 
  
  export HOST=$(hostname) 
  
  consul-template \
		-once \
		-consul-addr 127.0.0.1:8500 \
		-template "/etc/cassandra.yaml.ctmpl:/etc/cassandra/conf/cassandra.yaml"
 
   consul-template \
	  -once \
	  -consul-addr 127.0.0.1:8500 \
		-template "/etc/cassandra-topology.properties.ctmpl:/etc/cassandra/conf/cassandra-topology.properties"
    
}

health() {

  if nodetool statusgossip > /dev/null; then
    exit 0
  fi

exit 1   
}
$1 
