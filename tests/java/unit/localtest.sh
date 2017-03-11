#! /bin/bash

docker build -t junit ./
docker run -t -d -v /home/ec2-user/workspace/jenkins_pipeline/${repo}:/pipeline --name \"junit\" junit
