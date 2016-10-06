FROM ubuntu:latest

RUN    apt-get update && apt-get -y install phpunit

CMD cd /pipeline/index && phpunit /pipeline/index/Tester.php

EXPOSE 8080
