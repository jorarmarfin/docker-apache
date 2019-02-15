FROM php:5.6.30-apache

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev vim git sudo zip libbz2-dev  \
    mysql-client iputils-ping \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql zip mysqli opcache bcmath soap bz2 \
    && pecl install redis-3.1.1 \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable mysqli \
    && a2enmod rewrite \
    && chmod 0777 /var/www/html \
    && rm -rf /var/lib/apt/lists/*

COPY ./files/*.ini /usr/local/etc/php/conf.d/

EXPOSE 80

WORKDIR /var/www


