#! /bin/bash
docker build -t junit /home/ec2-user/workspace/DevOps/tests/java/unit/ 
docker run -t -d -v /home/ec2-user/workspace/jenkins_pipeline/medium:/maven --name "junit" junit
