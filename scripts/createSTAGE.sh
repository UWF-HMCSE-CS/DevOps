#! /bin/sh

sudo docker stop $(docker ps -aq)

sudo docker rm $(docker ps -aq)

sudo docker rmi $(docker images -q)

sudo docker build -t stage /home/ec2-user/workspace/DevOps-Pipeline/tests/stage/

sudo docker run -d --name pipeline_stage -v /home/ec2-user/workspace/DevOps-Pipeline/tests/stage/bash:/pipeline/ --privileged -p 80:80 stage

sudo docker cp /home/ec2-user/workspace/DevOps-Pipeline/tests/push/index.php pipeline_stage:/var/www/html/index.php
