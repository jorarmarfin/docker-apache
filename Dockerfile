FROM php:7.2-apache

ENV TZ=America/Lima
# Environments vars
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libpq-dev \
    libxml2-dev \
    libbz2-dev  \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    vim git sudo zip cron python python3 python3-venv python3-pip jq unzip cron wget mariadb-client \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-configure opcache --enable-opcache \
    && docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql zip mysqli opcache bcmath soap bz2  intl xml \
    && pecl install mcrypt-1.0.1 \
    && pecl install apcu  \
    && pecl install redis-3.1.1 \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable mysqli \
    && docker-php-ext-enable apcu \
    && docker-php-ext-enable mcrypt \
    && a2enmod rewrite \
    && a2enmod substitute \
    && chmod 0777 -Rf /var/www \
    && rm -rf /var/lib/apt/lists/*

COPY ./files/*.ini /usr/local/etc/php/conf.d/

# Installation of compass
RUN apt-get update && \
    apt-get install -y git ruby-full && \
    gem install --no-rdoc --no-ri sass -v 3.4.22 && \
    gem install --no-rdoc --no-ri compass && \
    gem install susy

#Instalacion de composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
    && rm /var/www/html/composer-setup.php \
    && curl https://drupalconsole.com/installer -L -o drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal

EXPOSE 80

WORKDIR /var/www/

