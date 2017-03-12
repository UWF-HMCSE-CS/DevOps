FROM ubuntu:latest

ADD ./ /pipeline/

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update -y && apt-get install -y wget unzip nano
RUN bash /pipeline/setup_maven.sh
