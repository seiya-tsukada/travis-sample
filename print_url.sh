# /usr/bin/bash

set -x

# get kibana nodeport

KIBANA_NODEPORT=`curl http://${API_SERVER}/kibana/nodeport`

echo ${KIBANA_NODEPORT}

# request kibana
echo ${KUBE_WORKER}
echo ${KIBANA_NODEPORT}
echo "request url : ${KUBE_WORKER}:${KIBANA_NODEPORT}"