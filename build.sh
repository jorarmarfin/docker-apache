docker build -t jorarmarfin/apache-php:tmp .
docker build -t jorarmarfin/apache-php:5.6 .

docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:7.2-opcache