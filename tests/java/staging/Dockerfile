FROM ubuntu:latest

RUN apt-get upgrade -y && apt-get update -y && apt-get -y install apache2 nmap

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

RUN service apache2 start

EXPOSE 80
