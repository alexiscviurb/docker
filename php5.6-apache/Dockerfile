FROM php:5.6-apache
MAINTAINER Alexis Cvirkun Urbanskyy <alexiscviurb@gmail.com>

RUN a2enmod rewrite

RUN chown www-data. /var/www/html/

RUN apt-get update && apt-get install -y \
	libpq-dev \
	libmysqlclient-dev \
	libfreetype6-dev \
	libjpeg62-turbo-dev \
    && apt-get clean

RUN mkdir /usr/include/freetype2/freetype && ln -s /usr/include/freetype2/freetype.h /usr/include/freetype2/freetype/freetype.h

RUN docker-php-ext-install pgsql pdo_pgsql mysql pdo_mysql
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install gd

RUN echo "date.timezone = America/Sao_Paulo" >> /usr/local/etc/php/conf.d/timezone.ini
RUN echo "upload_max_filesize = 20M" >> /usr/local/etc/php/conf.d/core.ini
RUN echo "post_max_size = 20M" >> /usr/local/etc/php/conf.d/core.ini
