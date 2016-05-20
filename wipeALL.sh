#! /bin/bash


# !!WIPES CONTAINERS AND IMAGES!!
# Use this in case you must reset the installation.

docker rm kibana

docker rm fluentd

docker rm elastic


docker rmi kibana

docker rmi fluentd

docker rmi elastic
