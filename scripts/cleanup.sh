#! /bin/bash

docker rmi -f $(docker images -a)
docker rm $(docker ps -aq)


