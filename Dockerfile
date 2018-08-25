#Plataforma CentOS7.0
FROM centos:7
MAINTAINER Luis Mayta <luis.mayta@gmail.com>

RUN yum install -y httpd

WORKDIR /var/www

EXPOSE 80

CMD apache2ctl -DFOREGROUND
#laravel necesita mbstring

