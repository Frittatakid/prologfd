#!/bin/bash


HOST_IP=10.250.2.253


docker build -t "fluentd" docker-files/fluentd+elasticp

docker build -t "elasticsearch" docker-files/elasticsearch 

docker build -t "kibana" docker-files/kibana


docker create \
	--name elastic \
	--publish 9200:9200 \
	--publish 9300:9300 \
	elasticsearch

docker create \
        --name fluentd \
        --link elasticsearch
        --env ES_HOST="elasticsearch" \
        --volume /var/log:/var/log/syslogs \
        fluentd

docker create \
	--name kibana \
	--env ELASTICSEARCH_URL=http://10.250.2.253:9200 \
	--publish 5601:5601 \
	kibana
