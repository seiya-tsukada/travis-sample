#! /usr/bin/bash

set -x

# request deploy api
curl http://${API_SERVER}

# get elasticsearch nodeport
while true
do
  ES_NODEPORT=`curl http://${API_SERVER}/es/nodeport`

  if [ -n ${ES_NODEPORT} ]; then
    break
  fi
  
  sleep 2
done

echo ${ES_NODEPORT}

# request kibana
echo ${KUBE_WORKER}
echo ${ES_NODEPORT}
echo "curl ${KUBE_WORKER}:${ES_NODEPORT}"
ANS=`curl ${KUBE_WORKER}:${ES_NODEPORT}`

echo ${ANS}
