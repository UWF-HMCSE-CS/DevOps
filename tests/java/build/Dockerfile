FROM ubuntu:latest

ADD ./ /cdep/

# Installing all of the dependencies
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y software-properties-common && add-apt-repository -y ppa:webupd8team/java && apt-get update -y && apt-get install -y maven

# Installing and configuring Java
RUN bash /cdep/setup_maven.sh
