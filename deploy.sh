# /usr/bin/bash

set -x

# request deploy api
curl http://${API_SERVER}

sleep 10

# get elasticsearch nodeport
ES_NODEPORT=`curl http://${API_SERVER}/es/nodeport`

echo ${ES_NODEPORT}

# request kibana
echo ${KUBE_WORKER}
echo ${ES_NODEPORT}
curl ${KUBE_WORKER}:${ES_NODEPORT}
ANS = `curl ${KUBE_WORKER}:${ES_NODEPORT}`

echo ${ANS}





# get kibana nodeport

KIBANA_NODEPORT=`curl http://${API_SERVER}/kibana/nodeport`

echo ${KIBANA_NODEPORT}

# request kibana
echo ${KUBE_WORKER}
echo ${KIBANA_NODEPORT}
echo "request url : ${KUBE_WORKER}:${KIBANA_NODEPORT}"

