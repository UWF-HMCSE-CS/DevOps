#! /bin/bash

sudo docker exec -d pipeline_stage bash /pipeline/java_stage/bash/createDIR.sh $1
sudo docker cp /home/ec2-user/workspace/jenkins_pipeline/$1/Index/index.php pipeline_stage:/var/www/html/java_stage/$1/index.php
(cd  /home/ec2-user/workspace/jenkins_pipeline/$1/; sudo zip java.zip ./target/*.jar)
sudo docker cp /home/ec2-user/workspace/jenkins_pipeline/$1/java.zip pipeline_stage:/var/www/html/java_stage/$1/java.zip
