#! /bin/bash

#Remove the default Apache index.html
rm /var/www/html/index.html

#Start  Apache server
service apache2 start

#Place the greetings index.html right here, into the server root
cp /pipeline/index.html /var/www/html/


 while(true)
 do
     sleep 10
     ls /var/www/html/
 done
