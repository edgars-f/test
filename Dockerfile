# First stage: Build the PHP dependencies
FROM composer:latest AS composer
WORKDIR /app
COPY composer.json composer.lock ./
RUN composer install --prefer-dist --no-dev --no-autoloader --no-scripts

# Second stage: Build the Node.js dependencies
FROM node:14-alpine AS node
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .
RUN npm run dev

# Final stage: Set up the application image
FROM php:8.2-fpm
WORKDIR /var/www

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    unzip \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install pdo pdo_mysql gd

# Copy PHP dependencies from the composer stage
COPY --from=composer /app/vendor /var/www/vendor
COPY --from=composer /app/composer.json /var/www/composer.json

# Copy Node.js dependencies and built assets from the node stage
COPY --from=node /app/node_modules /var/www/node_modules
COPY --from=node /app/public /var/www/public

# Copy the rest of the application files
COPY . /var/www

# Set proper ownership and permissions
RUN chown -R www-data:www-data /var/www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
