# /usr/bin/bash

set -x

# request deploy api
curl http://${API_SERVER}

sleep 10

# get nodeport
NODEPORT=`curl http://${API_SERVER}/nodeport`

echo ${NODEPORT}

# request kibana
ANS = `curl ${KUBE_WORKER}:${NODEPORT}`

echo ${ANS}

