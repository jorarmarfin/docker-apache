FROM php:7.0.33-apache

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev vim git sudo zip libbz2-dev \
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

# Installation of compass
RUN apt-get update && \
    apt-get install -y git ruby-full && \
    gem install --no-rdoc --no-ri sass -v 3.4.22 && \
    gem install --no-rdoc --no-ri compass && \
    gem install susy

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
    && rm /var/www/html/composer-setup.php \
    && useradd -s /bin/bash -m lmayta \
    && curl https://drupalconsole.com/installer -L -o drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal

EXPOSE 80


