FROM php:5.6-fpm-alpine
MAINTAINER Alexis Cvirkun Urbanskyy <alexiscviurb@gmail.com>

ENV TZ "America/Sao_Paulo"

RUN apk add --no-cache \
	tzdata \
	postgresql-dev \
	libjpeg-turbo-dev \
	freetype-dev \
	libpng-dev \
	mysql-client

RUN docker-php-ext-install pgsql pdo_pgsql mysql pdo_mysql
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install gd
