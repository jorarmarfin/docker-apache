FROM php:8.0-apache


ENV TZ=America/Lima
# Environments vars
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive
ENV ACCEPT_EULA=Y

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libpq-dev \
    libxml2-dev \
    libbz2-dev  \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libzip-dev \
    vim git sudo zip cron python python3 python3-venv python3-pip jq unzip cron wget mariadb-client \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install gd pdo_mysql pdo_pgsql zip mysqli opcache bcmath soap bz2  intl xml \
    && pecl install xdebug-3.2.0alpha3  \
    && docker-php-ext-enable xdebug  \
    && a2enmod rewrite \
    && a2enmod substitute \
    && chmod 0777 -Rf /var/www \
    && rm -rf /var/lib/apt/lists/*
# Cleaning
RUN apt-get purge -y --auto-remove $BUILD_DEPS \
	&& apt-get autoremove -y \
	&& rm -rf /var/lib/apt/lists/* \
	# Forward request and error logs to docker log collector
	&& ln -sf /dev/stdout /var/log/apache2/access.log \
	&& ln -sf /dev/stderr /var/log/apache2/error.log \
    && touch /var/www/html/index.php \
    && echo "<?php phpinfo();">> /var/www/html/index.php

COPY ./files/*.ini /usr/local/etc/php/conf.d/
COPY ./files/entrypoint.sh /sbin/entrypoint.sh

#Instalacion de composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
    && rm /var/www/html/composer-setup.php 
    
EXPOSE 80

WORKDIR /var/www/
