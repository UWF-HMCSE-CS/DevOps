#! /bin/bash

sudo docker build -t jstage /home/ec2-user/workspace/DevOps/tests/java/staging
sudo docker run -itd -p 80:80 --privileged jstage -D FOREGROUND
