FROM ubuntu:latest

ADD ./ /cdep/

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update -y && apt-get install -y maven
RUN bash /cdep/setup_maven.sh

WORKDIR /cdep/
