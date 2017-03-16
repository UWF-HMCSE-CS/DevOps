FROM ubuntu:latest


#Map the scripts onto the pipeline folder
ADD ./stage /pipeline/

#Map Java backups onto the right subfolder on the server
ADD ./stage/java_stage/backUps/ /var/www/html/java_stage/

#Map PHP backups onto the right subfolder on the server
ADD ./stage/php_stage/backUps/ /var/www/html/php_stage/

RUN apt-get update && apt-get -y install apache2 && apt-get -y install php libapache2-mod-php php-mysql nano vim

CMD bash /pipeline/stage.sh

EXPOSE 80
