#! /usr/bin/env python
# coding: utf-8

from flask import Flask
import subprocess

app = Flask(__name__)

@app.route("/")
def index():

    target_dir = "/root/work/"
    file_s = ["elasticsearch-deployment.yaml",  "kibana-deployment.yaml", "elasticsearch-service.yaml", "kibana-service.yaml"]

    for file in file_s:
      cmd = "kubectl apply -f {0}{1}".format(target_dir, file)
      proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
      out, err = proc.communicate()

      ret = [ s for s in out.split('\n') if s ]

      print ret

    return "deploy done"

@app.route("/es/nodeport")
def es_nodeport():

   cmd = "kubectl get services/elasticsearch -o go-template='{{(index .spec.ports 0).nodePort}}'"

   proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
   out, err = proc.communicate()

   ret = [ s for s in out.split('\n') if s ]

   print ret[0]

   return ret[0]

@app.route("/kibana/nodeport")
def kibana_nodeport():

   cmd = "kubectl get services/kibana -o go-template='{{(index .spec.ports 0).nodePort}}'"

   proc = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
   out, err = proc.communicate()

   ret = [ s for s in out.split('\n') if s ]

   print ret[0]

   return ret[0]

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)