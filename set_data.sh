# /usr/bin/bash

# get elasticsearch nodeport
ES_NODEPORT=`curl http://${API_SERVER}/es/nodeport`

echo ${ES_NODEPORT}

# request kibana
echo ${KUBE_WORKER}
echo ${ES_NODEPORT}

while true
do
  RES=`curl -s -I ${KUBE_WORKER}:${ES_NODEPORT} head -1 | cut -d ' ' -f 2`
  if [ "${RES}" -eq 200 ]; then
    break
  fi
  
  sleep 2
done

# set mapping
curl -X PUT http://${KUBE_WORKER}:${ES_NODEPORT}/shakespeare \
-H "Content-Type: application/json" -d '
{
 "mappings": {
  "doc": {
   "properties": {
    "speaker": {"type": "keyword"},
    "play_name": {"type": "keyword"},
    "line_id": {"type": "integer"},
    "speech_number": {"type": "integer"}
   }
  }
 }
}
'

curl -X PUT http://${KUBE_WORKER}:${ES_NODEPORT}/logstash-2015.05.18 \
-H "Content-Type: application/json" -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'

curl -X PUT http://${KUBE_WORKER}:${ES_NODEPORT}/logstash-2015.05.19 \
-H "Content-Type: application/json" -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'


curl -X PUT http://${KUBE_WORKER}:${ES_NODEPORT}/logstash-2015.05.20 \
-H "Content-Type: application/json" -d '
{
  "mappings": {
    "log": {
      "properties": {
        "geo": {
          "properties": {
            "coordinates": {
              "type": "geo_point"
            }
          }
        }
      }
    }
  }
}
'

# put data
curl -H 'Content-Type: application/x-ndjson' -X POST ${KUBE_WORKER}:${ES_NODEPORT}/bank/account/_bulk?pretty --data-binary @./assets/accounts.json > /dev/null
curl -H 'Content-Type: application/x-ndjson' -X POST ${KUBE_WORKER}:${ES_NODEPORT}/shakespeare/doc/_bulk?pretty --data-binary @./assets/shakespeare_6.0.json > /dev/null
curl -H 'Content-Type: application/x-ndjson' -X POST ${KUBE_WORKER}:${ES_NODEPORT}/_bulk?pretty --data-binary @./assets/logs.jsonl > /dev/null

