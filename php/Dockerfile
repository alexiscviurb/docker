FROM php:5.6-fpm-alpine
MAINTAINER Alexis Cvirkun Urbanskyy <alexiscviurb@gmail.com>

ENV TZ "America/Sao_Paulo"

RUN apk add --no-cache \
	tzdata \
	libpq \
	libjpeg-turbo-dev \
	freetype-dev \
	mysql-client \
	libpng-dev

RUN docker-php-ext-install mysql pdo_mysql
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ 
RUN docker-php-ext-install gd
