FROM php:7.2-apache
MAINTAINER Luis Mayta <luis.mayta@gmail.com>

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
	&& docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql zip

EXPOSE 80


