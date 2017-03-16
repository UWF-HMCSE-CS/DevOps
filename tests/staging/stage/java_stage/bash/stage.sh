#! /bin/bash

rm /var/www/html/index.html
service apache2 start

#Place the greetings page as the index.html right here
cp /pipeline/index.html /var/www/html/


while(true)
do
    sleep 10
    ls /var/www/html/
done
