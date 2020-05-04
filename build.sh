docker build -t jorarmarfin/apache-php:tmp .

docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:7.0-opcache 