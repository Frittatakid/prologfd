#!/bin/bash

# Requereix versió 1.10.1 de Docker!


docker build -t "fluentd" docker-files/fluentd+elasticp

docker build -t "elasticsearch" docker-files/elasticsearch 

docker build -t "kibana" docker-files/kibana


docker network create --subnet=172.18.0.0/24 efknet


docker create \
	--name elastic \
	--publish 9200:9200 \
	--publish 9300:9300 \
	--net efknet \
	--ip 172.18.0.20 \
	elasticsearch

docker create \
        --name fluentd \
        --env ES_HOST="172.18.0.20" \
        --volume /var/log:/var/log/syslogs \
        --net efknet \
        --ip 172.18.0.10 \
        fluentd

docker create \
	--name kibana \
	--env ELASTICSEARCH_URL=http://172.18.0.20:9200 \
	--publish 5601:5601 \
        --net efknet \
        --ip 172.18.0.30 \
	kibana
