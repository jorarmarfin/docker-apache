docker build -t jorarmarfin/apache-php:latest .

docker build -t jorarmarfin/apache-php:7.0 .

docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:latest