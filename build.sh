<<<<<<< HEAD
docker build -t jorarmarfin/apache-php:7.2 .
=======
docker build -t jorarmarfin/apache-php:7.0 .
>>>>>>> 4eca16d8abc42e19feca0cadc3cc0a1eac49c7e6

docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:7.2-opcache 