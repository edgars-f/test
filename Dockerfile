#composer

FROM composer:latest as build-composer
WORKDIR /app
COPY . .
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# node

FROM node:alpine as build-node
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run build
COPY . .

# php

FROM php:8.2-fpm-alpine as php-fpm
WORKDIR /var/www

RUN apk --no-cache add \
    bash \
    git \
    libpng-dev \
    libjpeg-turbo-dev \
    freetype-dev \
    icu-dev \
    libxml2-dev \
    oniguruma-dev \
    zip \
    unzip \
    curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        gd \
        intl \
        pdo_mysql \
        mbstring \
        xml \
        pcntl \
        opcache

COPY --from=build-composer /app /var/www
COPY --from=build-node /app /var/www

RUN chown -R www-data:www-data /var/www

#nginx

FROM nginx:alpine as nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=php-fpm /var/www/public /var/www/public
RUN chown -R nginx:nginx /var/www/public

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
