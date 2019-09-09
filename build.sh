docker build -t jorarmarfin/apache-php:tmp0 .
docker build -t jorarmarfin/apache-php:tmp1 .
docker build -t jorarmarfin/apache-php:5.3.29 .

docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:7.2-opcache 