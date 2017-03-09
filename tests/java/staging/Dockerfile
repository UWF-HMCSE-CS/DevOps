FROM ubuntu:latest

RUN apt-get upgrade -y && apt-get update -y && apt-get -y install apache2 nmap

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

CMD service apache2 start && tail -F /var/log/apache2/error.log

EXPOSE 80
