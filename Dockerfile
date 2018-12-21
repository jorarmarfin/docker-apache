FROM php:7.2-apache

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libpq-dev libxml2-dev\
     vim git sudo zip \
	&& docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
    && docker-php-ext-install gd mbstring pdo_mysql pdo_pgsql zip mysqli \
    && docker-php-ext-enable mysqli \
    && a2enmod rewrite \
    && chmod 0777 /var/www/html

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
    && rm /var/www/html/composer-setup.php \
    && useradd -s /bin/bash lmayta \
    && curl https://drupalconsole.com/installer -L -o drupal.phar \
    && mv drupal.phar /usr/local/bin/drupal \
    && chmod +x /usr/local/bin/drupal

EXPOSE 80


