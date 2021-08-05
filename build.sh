docker build -t jorarmarfin/apache-php:tmp .
docker build -t drinuxsac/qcrm2:1.0 .

docker build -t jorarmarfin/apache-php:7.4.22 .

docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:tmp
docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:latest

drm srv-apache 