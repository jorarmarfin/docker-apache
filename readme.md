# docker-apache-php7-laravel

#Paquetes
-Distribucion Ubuntu 18.10
-php 7.2

- Falta instalar zip
- Falta sudo a lmayta y su carpeta home y agregarle grupo apache

#Instalar DRUPAL composer
- composer create-project drupal-composer/drupal-project:8.x-dev

# docker-compose

~~~~
version: '3'
services:
  web:
    container_name: srv-apache
    image: jorarmarfin/apache-php:latest
    volumes:
      - ./apache/html:/var/www/html
    ports:
      - 9001:80
    restart: always
    networks:
      - net-apache
  db:
    container_name: srv-mysql
    image: mysql:5.7
    ports:
      - ${PUERTO_MYSQL}:3306
    environment:
      - MYSQL_ROOT_PASSWORD=root
    volumes:
      - ./mysql/data:/var/lib/mysql
      - ./mysql/conf:/etc/mysql/conf.d
      - ./mysql/backup:/backup
    restart: always
    networks:
      - net-apache
  adminer:
    container_name: srv-adminer
    image: adminer:latest
    ports:
      - 8080:8080
    restart: always
    networks:
      - net-apache
networks:
  net-apache:
~~~~