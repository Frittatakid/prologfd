#!/bin/bash

# Requires at least Docker version 1.10.1 for creating the network!


# Build container images from their respective docker files
docker build --tag="fluentd" docker-files/fluentd+elasticp

docker build --tag="elasticsearch" docker-files/elasticsearch 

docker build --tag="kibana" docker-files/kibana


# Creates the network for establishing the connection between the containers
docker network create --subnet=172.18.0.0/24 efknet


# Create containers, some of these variables might be modified if needed.
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
