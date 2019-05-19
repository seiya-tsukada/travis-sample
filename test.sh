 /usr/bin/bash

# get elasticsearch nodeport
ES_NODEPORT=`curl http://${API_SERVER}/es/nodeport`

echo ${ES_NODEPORT}

# request kibana
echo ${KUBE_WORKER}
echo ${ES_NODEPORT}

while true
do
  RES=`curl -s -I ${KUBE_WORKER}:${ES_NODEPORT} head -1 | cut -d ' ' -f 2`

  if [ ${RES} == "200" ]; then
    break
  fi
  
  sleep 2
done

RET=`curl -s http://${KUBE_WORKER}:${ES_NODEPORT}/_cat/indices/shakespeare | wc -l`
if [ ${RET} -ne 1 ]; then
    exit 1
fi

RET=`curl -s http://${KUBE_WORKER}:${ES_NODEPORT}/_cat/count/shakespeare | cut -d ' ' -f 3`
if [ ${RET} -lt 1 ]; then
    exit 1
fi

echo "test success!"