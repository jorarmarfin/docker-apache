FROM php:7.4.22-apache


ENV TZ=America/Lima
# Environments vars
ENV TERM=xterm
ENV DEBIAN_FRONTEND noninteractive
ENV ACCEPT_EULA=Y

#En esta imagen 7.4 ya viene con mbstring
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
    && pecl install apcu  \
    && pecl install -f xdebug  \
    && pecl install redis-3.1.1 \
    && docker-php-ext-enable xdebug \
    && docker-php-ext-enable redis \
    && docker-php-ext-enable apcu \
    && a2enmod rewrite \
    && a2enmod substitute \
    && chmod 0777 -Rf /var/www \
    && rm -rf /var/lib/apt/lists/*

COPY ./files/*.ini /usr/local/etc/php/conf.d/
COPY ./files/entrypoint.sh /sbin/entrypoint.sh

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
    && chmod 755 /sbin/entrypoint.sh

# Microsoft SQL Server Prerequisites
RUN apt-get update \
    && apt-get install -y gnupg gnupg1 gnupg2 \
    && curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl https://packages.microsoft.com/config/debian/10/prod.list \
        > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get install -y --no-install-recommends \
        locales \
        apt-transport-https \
    && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
    && locale-gen \
    && apt-get update \
    && apt-get -y --no-install-recommends install \
        unixodbc-dev \
        msodbcsql17 \
        mssql-tools \
        && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc 
RUN pecl install sqlsrv pdo_sqlsrv \
    && docker-php-ext-enable sqlsrv pdo_sqlsrv 

EXPOSE 80

WORKDIR /var/www/

# By default, simply start apache.
CMD ["/sbin/entrypoint.sh"]