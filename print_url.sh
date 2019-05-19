#! /usr/bin/bash

set -x

# get kibana nodeport
while true
do
  KIBANA_NODEPORT=`curl http://${API_SERVER}/kibana/nodeport`

  if [ -n ${KIBANA_NODEPORT} ]; then
    break
  fi
  
  sleep 2
done

echo ${KIBANA_NODEPORT}

# request kibana
echo ${KUBE_WORKER}
echo ${KIBANA_NODEPORT}
echo "request url : ${KUBE_WORKER}:${KIBANA_NODEPORT}"
