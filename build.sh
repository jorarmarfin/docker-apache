docker build -t jorarmarfin/apache-php:tmp .
docker build -t jorarmarfin/apache-php:tmp1 -f Dockerfile2 .


docker run --name srv-apache-tmp -d -p 9001:80 jorarmarfin/apache-php:tmp
docker run --name srv-apache-tmp -d -p 9001:80 jorarmarfin/apache-php:8.0


drm srv-apache 

docker tag fe62c6d62a2f jorarmarfin/apache-php:latest

Installing '/usr/local/lib/php/extensions/no-debug-non-zts-20200930/xdebug.so'
install ok: channel://pecl.php.net/xdebug-3.2.0alpha3
configuration option "php_ini" is not set to php.ini location
You should add "zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20200930/xdebug.so" to php.ini




# Debug
zend_extension=/usr/local/lib/php/extensions/no-debug-non-zts-20160303/xdebug.so
xdebug.default_enable=1
xdebug.remote_enable=1
xdebug.remote_port=9000
xdebug.remote_handler=dbgp
xdebug.remote_connect_back=0
xdebug.remote_host=host.docker.internal
xdebug.idekey=VSCODE
xdebug.remote_autostart=1
xdebug.remote_log=/var/www/xdebug.log

# My Xdebug
zend_extension=/usr/lib/php/20200930/xdebug.so
xdebug.mode = debug
xdebug.start_with_request = yes
xdebug.client_port=9003 

#Instalar SOAP
RUN apt-get update && \
    apt-get install -y libxml2-dev \
    && apt-get install php${PHP_VERSION}-soap -y

# Installation of compass
RUN apt-get update && \
    apt-get install -y git ruby-full && \
    gem install --no-rdoc --no-ri sass -v 3.4.22 && \
    gem install --no-rdoc --no-ri compass && \
    gem install susy

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