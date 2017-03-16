#! /bin/bash

sudo docker exec -d pipeline_stage bash /pipeline/php_stage/bash/createDIR.sh $1
sudo docker cp /home/ec2-user/workspace/jenkins_pipeline/$1/index/ pipeline_stage:/var/www/html/php_stage/$1/


sudo docker cp /home/ec2-user/workspace/DevOps/tests/push/index.php pipeline_stage:/var/www/html/php_stage/$1/index.php
