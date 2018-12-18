docker build -t jorarmarfin/apache-php:7.0 .

docker run --name srv-apache -d -p 8181:80 lfmc/iso-apache