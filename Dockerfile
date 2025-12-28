# ---- 1) deps Composer
FROM composer:2 AS vendor
WORKDIR /app

COPY composer.json composer.lock ./
RUN composer install --no-dev --prefer-dist --no-interaction --no-progress

COPY . .
RUN composer dump-autoload --optimize

# ---- 2) runtime PHP
FROM php:8.2-cli-alpine
WORKDIR /app

# Extensions utiles (mysql, pgsql, zip, etc.)
RUN apk add --no-cache \
    bash \
    icu-dev \
    libzip-dev \
    oniguruma-dev \
    && docker-php-ext-install \
    intl \
    mbstring \
    zip \
    pdo \
    pdo_mysql \
    pdo_pgsql

# Copie projet + vendors
COPY --from=vendor /app /app

# Permissions Laravel
RUN mkdir -p storage bootstrap/cache \
 && chmod -R 775 storage bootstrap/cache

# Script de démarrage
COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV APP_ENV=production
ENV LOG_CHANNEL=stderr
EXPOSE 8000

CMD ["/entrypoint.sh"]
