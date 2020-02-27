FROM php:5.4.45-apache

ENV TZ=America/Lima
# Environments vars
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y  --force-yes apt-utils \
    libpng-dev \
    libjpeg-dev \
    libpq-dev \
    libxml2-dev \
    libbz2-dev  \
    libxslt1-dbg \
    libxslt1-dev \
    libxslt1.1  \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    vim git sudo zip cron python jq mysql-client unzip cron wget \
    && docker-php-ext-install zip bcmath dom gd \
    && a2enmod rewrite \
    && chmod 0777 -Rf /var/www \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/

EXPOSE 80
