#! /bin/bash


docker start $1

docker exec -it $1 /bin/bash
