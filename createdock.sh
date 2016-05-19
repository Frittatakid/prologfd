#! /bin/bash


HOST_IP=10.250.2.253

docker build -t "fluentd2" docker-files/fluentd+elasticp

docker build -t "elasticsearch2" docker-files/elasticsearch 

docker build -t "kibana2" docker-files/kibana


docker create --name fluentd2 -e ES_HOST="$HOST_IP" -p 24224:24224 -v /var/log:/var/log/syslogs fluentd2

docker create --name elastic2 -p 9200:9200 -p 9300:9300 elasticsearch2

docker create --name kibana2 -e ELASTICSEARCH_URL=http://10.250.2.253:9200 -p 5601:5601 kibana2
