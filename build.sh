docker build -t jorarmarfin/apache-php:tmp .

docker build -t jorarmarfin/apache-php:7.3 .

docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:latest