docker build -t jorarmarfin/apache-php:tmp .
docker build -t jorarmarfin/apache-php:7.2 .
docker build -t drinuxsac/qcrm2:1.0 .

docker build -t jorarmarfin/apache-php:7.4.22 .

docker run --name srv-apache-tmp -d -p 9001:80 jorarmarfin/apache-php:sqlsrv
docker run --name srv-apache -d -p 8181:80 jorarmarfin/apache-php:latest

drm srv-apache 

docker tag fe62c6d62a2f jorarmarfin/apache-php:latest


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
